# Hotel Booking DApp – Architecture

## 1. Project Objective

The objective of this project is to create a hotel booking system using blockchain technology. Customers will be able to book rooms and make payments using Ethereum (ETH).

The main idea is to make the booking process more secure and transparent by using smart contracts. The system will also prevent customers from booking the same room on the same date.

## 2. System Actors

The system will have two main users:

- **Customer:** Can check available rooms, make bookings, pay using ETH and check booking information.
- **Hotel Owner:** Can add new rooms, set prices and withdraw payments.

The smart contract will work between the customer and the hotel to manage bookings and payments.

## 3. Booking Process

The booking process will have three steps:

1. **Select a Room:** The customer chooses a room and a date.
2. **Check Availability and Pay:** The smart contract checks if the room is available and if the payment is correct.
3. **Confirm Booking:** If everything is correct, the booking is saved on the blockchain and the room becomes unavailable for that date.

## 4. Smart Contract Functions

The system will use different functions to manage rooms, bookings and payments.

- **constructor():** Defines the hotel owner when the contract is created.
- **addRoom():** Allows the hotel owner to add rooms and set their prices.
- **getRoom():** Shows information about a specific room.
- **isRoomAvailable():** Checks if a room is available on a selected date.
- **bookRoom():** Allows customers to book a room and pay with ETH.
- **getBooking():** Shows information about a booking.
- **withdrawFunds():** Allows the hotel owner to withdraw the money received from bookings.

The system will also use `struct` to organise information and `mapping` to store rooms and bookings.

## 5. Security Considerations

The system will use different security measures to protect bookings and payments.

- **Access Control:** Only the hotel owner can add rooms and withdraw money.
- **Payment Validation:** The smart contract checks if the customer paid the correct amount of ETH.
- **Double Booking Prevention:** Two customers cannot book the same room on the same date.
- **Digital Signatures:** Ethereum uses digital signatures to verify that transactions are authorised by the account sending them.
- **Data Privacy:** The system will not store personal information such as customer names or passport numbers on the blockchain.

## 6. Technologies Used

For this project, I will use:

- **Solidity:** To create the smart contract.
- **Remix IDE:** To write, compile and test the code.
- **Remix VM:** To simulate the blockchain and test transactions using virtual ETH.

## 7. Limitations

The system will be a basic hotel booking application. Customers will only be able to book one night at a time.

It will not include features such as booking cancellations, refunds or a graphical interface.

The main purpose is to demonstrate how smart contracts can manage hotel bookings and payments using blockchain technology.