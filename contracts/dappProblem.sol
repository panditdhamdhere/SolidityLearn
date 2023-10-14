// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolahParchiThap {
    address public owner;
    address[4] public players;
    uint8[4][4] public parchis;
    address public currentPlayer;
    uint public gameStartTime;
    mapping(address => uint256) public wins;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier validPlayer() {
        require(msg.sender != owner, "Owner cannot be a player");
        require(getPlayerIndex(msg.sender) < 4, "Only 4 players are allowed");
        _;
    }

    modifier gameInProgress() {
        require(currentPlayer != address(0), "No game in progress");
        _;
    }

    modifier validGameState(uint8[4][4] memory state) {
        for (uint i = 0; i < 4; i++) {
            uint sum = 0;
            for (uint j = 0; j < 4; j++) {
                sum += state[i][j];
                require(state[i][j] <= 4, "Invalid number of parchis of a type");
            }
            require(sum >= 3 && sum <= 5, "Invalid number of parchis for a player");
        }
        _;
    }

    function getPlayerIndex(address player) internal view returns (uint) {
        for (uint i = 0; i < 4; i++) {
            if (players[i] == player) {
                return i;
            }
        }
        revert("Player not found");
    }

    function setState(address[4] memory _players, uint8[4][4] memory _parchis) public onlyOwner validGameState(_parchis) {
        require(currentPlayer == address(0), "A game is already in progress");

        for (uint i = 0; i < 4; i++) {
            players[i] = _players[i];
            wins[players[i]] = 0;
            for (uint j = 0; j < 4; j++) {
                parchis[i][j] = _parchis[i][j];
            }
        }

        gameStartTime = block.timestamp;
        currentPlayer = players[0];
    }

    function passParchi(uint8 parchi) public validPlayer gameInProgress {
        uint playerIndex = getPlayerIndex(msg.sender);
        uint nextPlayerIndex = (playerIndex + 1) % 4;

        require(parchis[playerIndex][parchi] > 0, "You don't have any parchis of this type");

        parchis[playerIndex][parchi]--;
        parchis[nextPlayerIndex][parchi]++;

        currentPlayer = players[nextPlayerIndex];
    }

    function claimWin() public gameInProgress {
        uint playerIndex = getPlayerIndex(msg.sender);
        for (uint i = 0; i < 4; i++) {
            if (parchis[playerIndex][i] == 4) {
                wins[msg.sender]++;
                currentPlayer = address(0); // Game ends
                return;
            }
        }
        revert("You don't have 4 parchis of the same type");
    }

    function endGame() public gameInProgress {
        require(block.timestamp >= gameStartTime + 1 hours, "You can't end the game yet");
        currentPlayer = address(0); // Game ends
    }

    function getWins(address add) public view returns (uint256) {
        return wins[add];
    }

    function myParchis() public view gameInProgress returns (uint8[4] memory) {
        uint playerIndex = getPlayerIndex(msg.sender);
        return parchis[playerIndex];
    }

    function getState() public view returns (address[4] memory, address, uint8[4][4] memory) {
        return (players, currentPlayer, parchis);
    }
}
