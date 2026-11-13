 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.20;

 contract HotelBooking {

     string public hotelName = "Dublin Hotel";
     address public hotelOwner;

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

    mapping(uint256 => Booking) public bookings;

    mapping(uint256 => mapping(uint256 => bool)) public reservedDays;

    mapping(uint256 => Room) public rooms;

    uint256 public nextBookingId = 1;

    constructor() {
    hotelOwner = msg.sender;
    }

    function addRoom(uint256 _roomId, uint256 _pricePerNight) public {
    require(msg.sender == hotelOwner, "Only hotel owner allowed");
    require(_roomId > 0, "Room ID must be greater than 0");
    require(_pricePerNight > 0, "Price must be greater than 0");
    require(rooms[_roomId].roomId == 0, "Room already exists");
    rooms[_roomId] = Room(_roomId,_pricePerNight, true);  
    }

    function bookRoom(uint256 _roomId, uint256 _checkInDay) public payable {
    require(rooms[_roomId].isActive == true, "Room is not active");
    require(rooms[_roomId].roomId != 0, "Room does not exist");
    require(_checkInDay > block.timestamp / 1 days, "Date must be in the future");
    require(reservedDays[_roomId][_checkInDay] == false, "Room already booked");
    require(msg.value == rooms[_roomId].pricePerNight, "Incorrect payment amount");
    }

    
 }



 