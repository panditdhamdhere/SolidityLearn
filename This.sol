// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract MyContract {
    address payable public owner;
    address payable public charity;

    constructor(address payable _charity) {
        owner = payable(msg.sender);
        charity = _charity;
    }

    receive() external payable {}

    function donate () public {
        charity.transfer(address(this).balance);
    }

    // function tip() public payable {
    //     // forwards all remaining gas along
    //     (bool success, ) = owner.call{value: msg.value}("");
       
    // } // console.log(success);
}
