// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract func {
    uint public d;

    constructor(uint _d) {
        d = _d;
    }

    // external
    function incre() external {
        d++;
    }

    // view
    function add(uint p) external view returns (uint) {
        return d + p;
    }

    // pure
    function pouble(uint x) external pure returns (uint) {
        return x * 2;
    }

    // double overload

    // function double(uint pandit, uint tara) external pure returns (uint, uint) {
    //     (double(pandit), double(tara));
    // }

    function pouble(uint p, uint t) external pure returns (uint, uint) {
return (pouble(p), pouble(t));
	}
}
