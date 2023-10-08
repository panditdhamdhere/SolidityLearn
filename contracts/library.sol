// SPDX-License-Identifier: MIT
import "./Prime.sol";
pragma solidity 0.8.19;

library Math {
    function add(uint a, uint b) external pure returns (uint) {
        return a + b;
    }
}

contract MyContract {
    using Math for uint;

    function myFunction(uint x, uint y) public pure returns (uint) {
        return x.add(y);
    }

    //   Finding Block number
    using Prime for uint;

    function iswinner() public view returns (bool) {
        return block.number.isPrime();
    }
}
