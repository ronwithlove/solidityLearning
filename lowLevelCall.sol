//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract TestCall {
    string public message;
    uint256 public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint256 _x)
        external
        payable
        returns (bool, uint256)
    {
        message = _message;
        x = _x;
        return (true, 999);
    }
}

//低级调用使用，调用TestCall
contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        //测试一，这个情况会失败，因为我们这里指定5000gas 是不够修改2个变量的
        //(bool success, bytes memory _data) = _test.call{value: 1, gas: 5000}(
        //测试二会通过
        (bool success, bytes memory _data) = _test.call{value: 1}( //value为1就是调用这个方法同时也需要传入至少1个主币
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123) //"call foo"和"123"就是要传入的两个变量
        );
        require(success, "call failed");
        data = _data;
    }

    //测试一下fallback，调用不存在的函数
    function callDoesNotExist(address _test) external {
        (bool success, ) = _test.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        require(success, "call failed");
    }
}
