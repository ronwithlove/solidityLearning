//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Immutable {
    //需要部署之后才知道的常量，必须部署的时候就给他赋值
    //写法1
    address public immutable owner = msg.sender;

    //写法2
    address public immutable owner2;

    constructor() {
        owner2 = msg.sender;
    }
}
