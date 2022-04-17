//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ReturnExample {
    //这里用public 而不用external是因为合约里有函数需要调用这个函数
    function multiReturn() public pure returns (uint256, bool) {
        return (1, true);
    }

    function named() public pure returns (uint256 x, bool b) {
        return (1, true);
    }

    //隐式返回
    function assigned() public pure returns (uint256 x, bool b) {
        x = 1;
        b = true;
    }

    function getReturns() public pure {
        (uint256 x, bool b) = multiReturn(); //接收返回值
        (, bool b2) = multiReturn(); //不接收x，只需要b
    }
}
