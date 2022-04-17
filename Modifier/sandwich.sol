//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Modifier {
    uint256 public count;

    //sandwich 类型修改器
    modifier sandwich() {
        count += 10; //逻辑1
        _; //执行调用的函数
        count *= 2; //逻辑2
    }

    function foo() external sandwich {
        count += 1;
    }
}
