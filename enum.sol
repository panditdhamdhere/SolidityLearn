// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    enum Game {
        Cricket,
        Football,
        Chess,
        Tennis
    }

    Game public food1 = Game.Cricket;
    Game public food2 = Game.Football;
    Game public food3 = Game.Chess;
    Game public food4 = Game.Tennis;
}

// enum values are stored as unsigned integers. If there are less than 256 values, it will be stored as a uint8. If you have more than 256 values it will use a uint16 and will grow from there as needed (although I'm not sure how many contracts will ever need more than 65536 values in their enum...). The way this data is stored will become more important when we look to parse our smart contracts from the outside world through the ABI.
