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

}


}
