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


contract MyContractConstructor {
    constructor() {
        // Constructor logic here
    }
}


contract MyContract {
    fallback() external payable {
        // Fallback logic here
    }
}


contract Pandit {
    receive() external payable {
        // Receive logic here
    }
}


contract MyHandle {
    function handleCallback() external {
        // Handle callback logic here
    }
}

contract Pandit {
    uint public myVariable;
    
    function getMyVariable() public view returns (uint) {
        return myVariable;
    }
}



contract EventSplFunc {
    event MyEvent(uint indexed id, string message);
    
    function triggerEvent(uint _id, string memory _message) public {
        emit MyEvent(_id, _message);
    }
}
