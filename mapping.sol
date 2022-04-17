//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Mapping {
    mapping(address => uint256) public balances;
    //嵌套映射
    mapping(address => mapping(address => bool)) public isFriend;

    function example() external {
        balances[msg.sender] = 123; //添加数据
        uint256 bal = balances[msg.sender]; //获取数据
        //获取不存在的值
        uint256 bal2 = balances[address(1)]; //得到0
        //修改值，在原来基础上加上了456 123 + 456
        balances[msg.sender] += 456;
        //删除数据，再查询就是0
        delete balances[msg.sender];

        //嵌套赋值
        isFriend[msg.sender][address(this)] = true;
    }
}
