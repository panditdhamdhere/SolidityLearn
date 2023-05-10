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

// pure func

contract MyContract {
    function add(uint x, uint y) external pure returns(uint) {
        return x + y;
    }
}

// return muiltiple value 

function mathtime (uint sum, uint product) external pure returns (uint sum, uint product) {
    sum = 5 + 5;
    product = 5 * 5;
}


// multiple values
function mathtime (uint sum, uint product) external pure returns (uint sum, uint product) {
    sum = 5 + 5;
    product = 5 * 5;

    return (sum, product)
}


// Double functions


contract Contract {
	function pandit(uint x) public pure returns(uint) {
		return x * 2;
	}
	
	function pandit(uint a, uint b) external pure returns(uint, uint) {
		return (pandit(a), pandit(b));
	}
}