
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HotelBooking {

    string public hotelName = "Dublin Hotel";
    address public hotelOwner;

    uint256 public nextBookingId = 1;
    uint256 public pendingPayout;

    struct Room {
        uint256 roomId;
        uint256 pricePerNight;
        bool isActive;
    }

    struct Booking {
        uint256 bookingId;
        uint256 roomId;
        address guest;
        uint256 checkInDay;
        uint256 amountPaid;
    }

    mapping(uint256 => Room) public rooms;
    mapping(uint256 => Booking) public bookings;
    mapping(uint256 => mapping(uint256 => bool)) public reservedDays;

    event RoomAdded(uint256 indexed roomId, uint256 price);
    event RoomBooked(
        uint256 indexed bookingId,
        uint256 indexed roomId,
        address indexed guest,
        uint256 checkInDay,
        uint256 amountPaid
    );
    event FundsWithdrawn(address indexed owner, uint256 amount);

    // Set the hotel owner
    constructor() {
        hotelOwner = msg.sender;
    }

    // Register a new room
    function addRoom(uint256 _roomId, uint256 _pricePerNight) public {
        require(msg.sender == hotelOwner, "Only hotel owner allowed");
        require(_roomId > 0, "Room ID must be greater than 0");
        require(_pricePerNight > 0, "Price must be greater than 0");
        require(rooms[_roomId].roomId == 0, "Room already exists");

        rooms[_roomId] = Room(_roomId, _pricePerNight, true);

        emit RoomAdded(_roomId, _pricePerNight);
    }

    // View room information
    function getRoom(uint256 _roomId) public view returns (Room memory) {
        require(rooms[_roomId].roomId != 0, "Room does not exist");
        return rooms[_roomId];
    }

    // Check availability for a specific day
    function isRoomAvailable(
        uint256 _roomId,
        uint256 _checkInDay
    ) public view returns (bool) {

        if (rooms[_roomId].roomId == 0) {
            return false;
        }

        if (!rooms[_roomId].isActive) {
            return false;
        }

        if (_checkInDay <= block.timestamp / 1 days) {
            return false;
        }

        return !reservedDays[_roomId][_checkInDay];
    }

    // Book a room and pay with ETH
    function bookRoom(
        uint256 _roomId,
        uint256 _checkInDay
    ) public payable {

        require(rooms[_roomId].roomId != 0, "Room does not exist");
        require(rooms[_roomId].isActive, "Room is not active");
        require(
            _checkInDay > block.timestamp / 1 days,
            "Date must be in the future"
        );
        require(
            !reservedDays[_roomId][_checkInDay],
            "Room already booked"
        );
        require(
            msg.value == rooms[_roomId].pricePerNight,
            "Incorrect payment amount"
        );

        uint256 bookingId = nextBookingId;

        bookings[bookingId] = Booking(
            bookingId,
            _roomId,
            msg.sender,
            _checkInDay,
            msg.value
        );

        reservedDays[_roomId][_checkInDay] = true;
        pendingPayout += msg.value;
        nextBookingId++;

        emit RoomBooked(
            bookingId,
            _roomId,
            msg.sender,
            _checkInDay,
            msg.value
        );
    }

    // View booking information
    function getBooking(
        uint256 _bookingId
    ) public view returns (Booking memory) {

        require(
            bookings[_bookingId].bookingId != 0,
            "Booking does not exist"
        );

        return bookings[_bookingId];
    }

    // Hotel owner withdraws received payments
    function withdrawFunds() public {

        require(msg.sender == hotelOwner, "Only hotel owner allowed");

        uint256 amount = pendingPayout;
        require(amount > 0, "No funds available");

        pendingPayout = 0;

        (bool success, ) = payable(hotelOwner).call{value: amount}("");
        require(success, "Withdrawal failed");

        emit FundsWithdrawn(hotelOwner, amount);
    }
}
