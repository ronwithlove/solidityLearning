//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Modifier {
    bool public paused;
    uint256 public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    //使用modifier
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; //其他函数运行的位置，这里表示在require之后运行
    }

    function inc() external whenNotPaused {
        count += 1;
    }

    function dec() external whenNotPaused {
        count -= 1;
    }
}
