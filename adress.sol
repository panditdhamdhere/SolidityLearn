// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract addressAd {
    address public owner;

    constructor () {
        owner = msg.sender;
    }
}