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

    mapping(uint256 => Room) public rooms;

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
 }



 