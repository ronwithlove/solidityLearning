//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//发送函数
contract SendEther {
    constructor() payable {}

    //三种发送的方法
    //如果失败会有reverts
    function useTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function useSend(address payable _to) external payable {
        bool success = _to.send(123); //sent回返回一个bool值
        require(success, "send failed");
    }

    function useCall(address payable _to) external payable {
        //语法和前面两个有点不同，call可以使用低级调用，转钱的同时也可以调用目标合约的函数
        //(bool success, bytes memory data) = _to.call{value: 123}(""); //""这里是填写需要发送的数据
        //先不接收data数据
        (bool success, ) = _to.call{value: 123}("");
        require(success, "call failed");
    }
}

//接收合约，用来收上面发的币
contract EthReceiver {
    event Log(uint256 amount, uint256 gas);

    //要让合约可以接收主币，有两种写法
    //方法一
    //constructor() payable {}
    //方法二
    receive() external payable {
        //收到钱以后会打印出日志
        emit Log(msg.value, gasleft()); //gasleft剩余的gas
    }
}
