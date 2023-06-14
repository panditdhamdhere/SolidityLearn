// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Game.sol";

contract Bet {
    Game public game;

    constructor(address _game) {
        game = Game(_game);
    }

    function getScoreDifference(Game.Teams teamNumber) public view returns (int) {
        if (teamNumber == Game.Teams.Team1) {
            
        }
    }

    function calculatePayout(
        uint bet,
        int scoreDifference
    ) private pure returns (uint) {
        uint abs = uint(scoreDifference);
        uint odds = 2 ** abs;
        if (scoreDifference < 0) {
            return bet + bet / odds;
        }
        return bet + bet * odds;
    }
}


contract ChildContractPandit is ParentContractDhamdhere {
// Child contract
//  code goes here..
}


contract MyContract is Interface1, Interface2 {
// Contract 
// code goes here...
}