//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Modifier {
    bool public paused;
    uint256 public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    function inc() external {
        require(!paused, "paused");
        count += 1;
    }

    function dec() external {
        require(!paused, "paused");
        count -= 1;
    }
}
