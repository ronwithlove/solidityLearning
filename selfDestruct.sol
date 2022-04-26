//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint256) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    //调用Kill合约，执行kill函数
    function kill(Kill _kill) external {
        _kill.kill();
    }
}
