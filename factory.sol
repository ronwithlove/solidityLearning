//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

//这个认为是产品
contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender; //工厂合约地址
        owner = _owner; //会通过工厂传入
    }
}

//生产Account产品的工厂合约
contract AccountFactory {
    Account[] public accountList;

    function createAccount(address _owner) external payable {
        //account就记录了新创建合约的地址
        //因为Account合约在一个文件内，所以知道名字，不在一个文件内，import进来就可以了
        //Account可以接受主币，所以这里可以传入主币
        Account account = new Account{value: 111}(_owner);
        accountList.push(account);
    }
}
