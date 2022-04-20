//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Proxy {
    event Deploy(address);

    fallback() external payable {} //代理合约可能会收到主逼，所以要增加一个回退函数来接收主币，要不然会出错

    function deploy(bytes memory _code) external payable returns (address) {
        address addr;
        assembly {
            //create(v,p,n)
            //v 部署这个合约发送以太坊主币的数量
            //p 内存中机器码开始的位置
            //n 机器码大小
            //从内存p位置开始，读取n字节的代码，然后创建一个新的合约并发送v数量的eth到新合约中，返回合约的地址。
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        require(addr != address(0), "deploy failed"); //如果是0地址就说明出错了，报错
        emit Deploy(addr); //出发事件
        return addr;
    }

    //因为是代理合约部署的，所以需要通过执行方法把管理员改成自己
    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}

contract Helper {
    //助手函数
    //获得机器码
    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract).creationCode;
        return bytecode;
    }

    //调用设置管理员的方法
    function getCalldata(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}

contract TestContract {
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}
