//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BRBwithGraph {
    event ChangeNameEvent (string name);
    event ChangeTwitterNameEvent (string name);
    event TransferEvent(address from, address to, uint amount);

    string public name = "The Graph";
    string public twitterName = "graphprotocol";

    function changeName(string calldata _name) public {
    name = _name;
    emit ChangeNameEvent(_name);
   } 

   function changeTwitterName(string calldata _twitterName) public {
    twitterName = _twitterName;
    emit ChangeTwitterNameEvent(_twitterName);
   } 

   function transfer(address payable to) public payable {
    to.transfer(msg.value);
    emit TransferEvent(msg.sender, to, msg.value);
 }
}

// 0xC1dE6db4da5d6718D5e3F03D8BA30C65E58b5B25