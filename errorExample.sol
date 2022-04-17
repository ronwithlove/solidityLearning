//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ErrorExmaple {
    function requireExmaple(uint256 _i) public pure {
        require(_i <= 10, "i > 10"); //符合这个条件的继续下面逻辑，不符合报引号中的错误
        //code
    }

    function revertExmaple(uint256 _i) public pure {
        if (_i > 10) {
            revert("i > 10"); //不能包含表达式
        }
    }

    uint256 public num = 123;

    function assertExample() public view {
        assert(num == 123);
    }

    //给num加1，再运行asserExample就会报错了
    function incNum() public {
        num += 1;
    }

    //error MyError();//自定义错误，节约gas fee
    error MyError2(address caller, uint256 i); //可以添加变量

    function errorExample(uint256 _i) public view {
        if (_i > 10) {
            revert MyError2(msg.sender, _i);
        }
    }
}
