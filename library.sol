// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

// library Math {
//     function add(uint a, uint b) internal pure returns (uint) {
//         return a + b;
//     }
// }

// contract MyContract {
//     function myFunction(uint x, uint y) public pure returns (uint) {
//         return Math.add(x, y);
//     }
// }

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
}
