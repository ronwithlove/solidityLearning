//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

interface ICounter {
    function count() external view returns (uint256);

    function inc() external;
}

contract CallInterface {
    uint256 public count;

    function examples(address _counter) external {
        ICounter(_counter).inc(); //调用接口，传入合约地址，调用方法
        count = ICounter(_counter).count();
    }
}

//这是被调用的合约，可以分开写到另外一个文件，这方便就写一个sol下了
contract Counter {
    uint256 public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}
