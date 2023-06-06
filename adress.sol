// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract addressAd {
    address public owner;

    constructor () {
        owner = msg.sender;
    }
}

contract pay {
    address payable public owner;
    constructor () public {
        owner = payable(msg.sender);
    }
}