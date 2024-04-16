// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Lottery {
    address public manager;
    address payable[] public players;

    constructor() {
        manager = msg.sender;
    }

    function alreadyEntered() private view returns (bool) {
        for (uint256 i = 0; i < players.length; i++) {
            if (players[i] == msg.sender) return true;
        }
        return false;
    }

    function enter() public payable {
        require(msg.sender != manager, "Manager cannot enter");
        require(alreadyEntered() == false, "Already entered");
        require(msg.value >= 1 ether, "Must enter at least 1 ether");

        players.push(payable(msg.sender));
        // alreadyEntered() = true;
    }

    function random() private view returns (uint256) {
        return
            uint256(
                sha256(
                    abi.encodePacked(block.prevrandao, block.number, players)
                )
            );
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick winner   ");
        uint256 index = random() % players.length; // winner index
        address contractAddress = address(this);
        players[index].transfer(contractAddress.balance);
        players = new address payable[](0);
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
}
