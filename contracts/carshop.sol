// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CarShop {
    address public owner;
    uint public totalCars;

    struct Car {
        string make;
        string model;
        uint price;
        bool available;
    }

    mapping(uint => Car) public cars;

    event CarAdded(uint carId, string make, string model, uint price);
    event CarPurchased(uint carId, address buyer);

    constructor() {
        owner = msg.sender;
        totalCars = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function addCar(
        string memory _make,
        string memory _model,
        uint _price
    ) public onlyOwner {
        totalCars++;
        cars[totalCars] = Car({
            make: _make,
            model: _model,
            price: _price,
            available: true
        });

        emit CarAdded(totalCars, _make, _model, _price);
    }

    function purchaseCar(uint _carId) public payable {
        require(_carId > 0 && _carId <= totalCars, "Invalid car ID");
        Car storage car = cars[_carId];
        require(car.available, "Car is not available");
        require(msg.value >= car.price, "Insufficient payment");

        car.available = false;
        address payable seller = payable(owner);
        seller.transfer(msg.value);

        emit CarPurchased(_carId, msg.sender);
    }

    function getCar(
        uint _carId
    ) public view returns (string memory, string memory, uint, bool) {
        require(_carId > 0 && _carId <= totalCars, "Invalid car ID");
        Car storage car = cars[_carId];
        return (car.make, car.model, car.price, car.available);
    }
}
