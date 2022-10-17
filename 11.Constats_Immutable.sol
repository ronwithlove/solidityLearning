//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//把不需要修改的值用常量表示 constant，或者immutable, 节约gas
contract Contrants {
    //常量命名习惯，用大写，中间用下划线隔开
    address public constant MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    //每次读取消耗 21420 gas
    //虽然读取是不消耗gas的，但是在写入方法中调用的时候就会消耗这个gas
}

contract Value {
    //常量命名习惯，用大写，中间用下划线隔开
    address public MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    //每次读取消耗 23553 gas
}

contract Immutable {
    address public immutable ownwer = msg.sender;

    //写法2，在构造函数里写
    address public immutable ownwer2;
    constructor(){
        ownwer2 = msg.sender;
    }

    uint public x;
    function foo() external { //消耗 50123 gas
        require(msg.sender == ownwer);
        x+=1;
    }
}

contract NoImmutable {
    address public ownwer = msg.sender;

    uint public x;
    function foo() external { //调用方法消耗 52576 gas
        require(msg.sender == ownwer);
        x+=1;
    }
}