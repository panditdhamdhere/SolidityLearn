// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract Game {
    int public team1Score;
    int public team2Score;

    enum Teams {
        Team1,
        Team2
    }

    function addScore(Teams teamNumber) external {
        if (teamNumber == Teams.Team1) {
            team1Score++;
        } else {
            team2Score++;
        }
    }
}
