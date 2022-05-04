//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//被调用合约
contract TestDelegateCall {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) external payable {
        num = _num;
        //num = 2 * _num;

        sender = msg.sender;
        value = msg.value;
    }
}

//委托合约
contract DelegeteCall {
    uint256 public num; //变量位置需要和被调用合约保持一一对应的关系
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _num) external payable {
        //这个是写法一
        // (bool success, bytes memory data) = _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint256)", _num)
        // );

        //写法二，可以避免写错函数名和他的传参类型
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "delegatecall failed");
    }
}
