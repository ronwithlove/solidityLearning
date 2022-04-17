//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Mapping {
    mapping(address => uint256) public balances; //余额
    mapping(address => bool) public accounts; //是否存在,true表示存在
    address[] public keys;

    function set(address _key, uint256 _val) external {
        balances[_key] = _val; //设置账户余额

        if (!accounts[_key]) {
            //如果不存在
            accounts[_key] = true; //插入到accounts mapping里
            keys.push(_key); //同时也放到数组中去
        }
    }

    //获得长度
    function getSize() external view returns (uint256) {
        return keys.length;
    }

    //获取第一个地址的余额
    function firstAccBalance() external view returns (uint256) {
        //先从数组拿到第一个地址，再使用这个地址从balance拿到余额
        return balances[keys[0]];
    }

    function lastAccBalance() external view returns (uint256) {
        //先从数组拿到第一个地址，再使用这个地址从balance拿到余额
        return balances[keys[keys.length - 1]];
    }

    //获取制定位置的余额
    function getBalance(uint256 _i) external view returns (uint256) {
        return balances[keys[_i]];
    }
}
