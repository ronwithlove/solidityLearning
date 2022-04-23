//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//storge 状态变量，memory是局部变量，calldata只能用在输入的参数
contract SimpleStorage {
    string public text;

    //这里calldata也可以改成memory，但是用的gas会多一点
    function set(string calldata _text) external {
        text = _text;
    }

    //把状态变量拷贝到内存中再返回，这样原理
    function get() external view returns (string memory) {
        return text;
    }
}
