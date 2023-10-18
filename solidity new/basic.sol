// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Hello {
    string public message;
    address public to;

    constructor() {
        to = msg.sender;
    }

    function sayHello() public view returns (string memory) {
        return message;
    }
}