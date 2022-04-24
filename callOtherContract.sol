//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CallContractFunction {
    //方法一
    function callsetX(address _test, uint256 _x) external {
        TestContract(_test).setX(_x); //传入需要调用方法的合约地址，和方法的传参
    }

    //方法二
    function callsetX2(TestContract _test, uint256 _x) external {
        _test.setX(_x); //传入需要调用方法的合约地址，和方法的传参
    }

    //view returns 要和getX保持一致
    function callgetX(address _test) external view returns (uint256) {
        uint256 x = TestContract(_test).getX();
        return x;
        //return TestContract(_test).getX(); //这样也可以
    }

    //被调用的函数有payable，这里调用的函数也要有
    function callsetXAndReceiveEther(address _test, uint256 _x)
        external
        payable
    {
        TestContract(_test).setXAndReceiveEther{value: msg.value}(_x); //把所有调用时候传入的主币都放到这个被调用的函数中
    }

    function callgetXAndValue(address _test)
        external
        view
        returns (uint256, uint256)
    {
        // (uint x, uint value) = TestContract(_test).getXAndValue();
        // return (x, value);
        return TestContract(_test).getXAndValue();
    }
}

contract TestContract {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXAndReceiveEther(uint256 _x) external payable {
        x = _x;
        value = msg.value; //函数接收到的主币数量
    }

    function getXAndValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}
