//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//storge 状态变量，memory是局部变量，calldata只能用在输入的参数
contract Event {
    //例1
    event Log(string message, uint256 val);
    //index变量最多3个
    event IndexedLog(address indexed sender, uint256 val);

    function example() external {
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 567);
    }

    //例2
    event Message(address indexed _from, address indexed _to, string message);

    function sendMsg(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
