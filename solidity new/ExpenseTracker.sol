// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ExpenseTracker {
    // struct
    struct Expense {
        address user;
        string description;
        uint256 amount;
    }

    Expense[] public expenses;

    // constructor
constructor() {
expenses.push(Expense(msg.sender, "Glossery", 10));
expenses.push(Expense(msg.sender, "Light Bill", 100));
expenses.push(Expense(msg.sender, "PetrolBill", 50));
}


}
