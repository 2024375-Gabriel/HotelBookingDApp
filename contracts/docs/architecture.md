The project objective aims to create a blockchain-based hotel booking system that allows customers to book rooms and make secure payments using smart contracts.

The main actors will be the customers and the Hotel owner.

The booking process will be in three steps: 
Select a Room.
Check availability and Pay.
Confirm Booking.

The Hotel Booking system will use different smart contract functions to manage rooms, bookings and payments.

constructor(): Defines the owner when the contract is created.

addRoom(): Allows the hotel owner to add new rooms and set their prices.

getRoom(): Allows users to view information about a room.

isRoomAvailable(): Checks if a room is available for a specific date.

bookRoom(): Allows customers to book a room and pay using ETH.

getBooking(): Allows users to check booking details.

withdrawFunds(): Allows the hotel owner to withdraw available payments.

The Hotel Booking system will use different security measures to protect bookings and payments.

Access Control: Only the hotel owner can add rooms and withdraw funds.

Payment Validation: The smart contract checks if the customer has paid the correct amount of ETH.

Double Booking Prevention: The system prevents two customers from booking the same room on the same date.

Digital Signatures: Ethereum uses cryptographic signatures to verify that transactions are authorised by the account sending them.

Data Privacy: Personal information will not be stored directly on the blockchain because blockchain records are publicly accessible.