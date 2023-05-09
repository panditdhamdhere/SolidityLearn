// View Function Example

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

contract myContract {
    uint x = 5;
    uint y = 10;

    function sum() external view returns (uint) {
        x + y;
    }
}

// view func

contract MyContract {
    function add(uint x, uint y) external pure returns(uint) {
        return x + y;
    }
}