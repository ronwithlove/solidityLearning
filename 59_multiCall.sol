//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract TestMultiCall {
    function func1() external view returns (uint, uint) {
        return (1, block.timestamp);
    }

    function func2() external view returns (uint, uint) {
        return (2, block.timestamp);
    }    

    //拿到函数的方法
    function getfunc1Data() external pure returns (bytes memory) {
        //方法一
        //return abi.encodeWithSignature("func1()");
        return abi.encodeWithSelector(this.func1.selector);//方法二
    }

    function getfunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.func2.selector);
    }   
}

contract MultiCall {
    //tragets调用的合约地址，data调用对合约发出的数据
    function multiCall(address[] calldata tragets, bytes[] calldata data) external view returns (bytes[] memory) {
        require(tragets.length == data.length, "target length != data length");
        //定义返回值
        bytes[] memory results = new bytes[](data.length);

        for (uint i; i < tragets.length; i++) {
            //返回值result是调用后返回的数据，abi编码形式
            (bool success, bytes memory result) = tragets[i].staticcall(data[i]);//函数用的是view,所以使用静态调用
            require(success, "call failed");
            results[i] = result;
        }

        return results;
    }
}