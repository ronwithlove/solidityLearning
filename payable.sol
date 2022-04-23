//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Payable {
    //例子1:
    address payable public owner; //只有加了payable 这个地址才可以发送以太坊主币

    constructor() {
        //如果有构造函数，也必须加上payable和上面定义的变量owner保持一致
        owner = payable(msg.sender);
    }

    //例子1不用写也是可以支付的
    //例子2，接收
    //函数必须有payable才可以接收以太坊主币，调用这个方法就直接可以接收以太坊主币了
    function deposit() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance; //this就是当前合约，这里就是当前合约余额
    }
}
