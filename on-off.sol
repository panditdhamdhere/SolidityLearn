// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract onOffSwitch {
    bool private isOn;

    constructor() public {
        isOn = true;
    }

    function toggle() public returns (bool) {
        isOn = !isOn;
        return isOn;
    }
}
