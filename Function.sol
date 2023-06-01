// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract func {
    uint public d;

    constructor(uint _d) {
        d = _d;
    }

// external
    function incre () external{
        d++;
    }
// view
    function add(uint p) external view returns(uint) {
        return d + p;
    }

    // pure 
    function double (uint x) external pure returns (uint) {
        return x * 2;
    }
}
