//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Fallback {
    event Log(string func, address sender, uint256 value, bytes data);

    //回退函数可以接收到合约中不存在的函数
    //fallback() external {}
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    } //加上payable可以接收主币

    //8.0新的，这个receive只接收主币
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, ""); //不接收数据，第三个字段就设为空好了
    }
}

//msg.data不为空且有receive函数就运行receive，否则就是fallback
