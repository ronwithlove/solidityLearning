//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//只是多重调用合约，msg.sender看到的是多重调用合约。
//通过多重委托合约，msg.sender看到调用者信息
contract MultiDelegatecall {
    error DelegatecallFailed();

    function multiDelegatecall(bytes[] calldata data) external payable returns (bytes[] memory results) {
        //返回值的长度和输入值长度一样
        results = new bytes[](data.length);
        for (uint i; i < data.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);
            if (!success) {
                revert DelegatecallFailed();
            }
            results[i] = result;
        }


    }
}

contract TestMultiDelegatecall is MultiDelegatecall {
    event Log(address caller, string func, uint i);

    function func1(uint x, uint y) external {
        emit Log(msg.sender, "func1", x+y);
    }

    function func2() external returns (uint) {
        emit Log(msg.sender, "func2", 2);
        return 111;
    }

    //可能存在漏洞演示
    mapping(address => uint) public balanceOf;

    function mint() external payable {
        balanceOf[msg.sender] += msg.value;
    }

}

//获取TestMultiDelegatecall两个函数的data数据
contract Helper {
    function getFunc1Data(uint x, uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func1.selector, x, y);
    }

    function getFunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func2.selector);
    }   

    function getMintData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.mint.selector);
    }
}