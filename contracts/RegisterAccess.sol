// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.25;

contract RegisterAccess {
    // Variables

    string[] private info;
    address public owner;
    mapping(address => bool) public allowList;

    // constructor
    constructor() {
        owner = msg.sender;
        allowList[msg.sender] = true;
    }

    //event
    event InfoChange(string OldInfo, string NewInfo);

    // modifiers

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyAllowlist() {
        require(allowList[msg.sender], "Only allowlist can call this function");
        _;
    }

    // functions

    function getInfo(uint256 index) public view returns (string memory) {
        return info[index];
    }

    function setInfo(uint256 index, string memory _info) public onlyAllowlist {
        info[index] = _info;
        emit InfoChange(info[index], _info);
    }

    function addInfo(
        string memory _info
    ) public onlyAllowlist returns (uint256 index) {
        info.push(_info);
        index = info.length - 1;
    }

    function listInfo() public view returns (string[] memory) {
        return info;
    }

    function addMember(address _member) public onlyOwner {
        allowList[_member] = true;
    }

    function deleteMember(address _member) public onlyOwner {
        allowList[_member] = false;
    }
}
