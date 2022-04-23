//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}

contract Y is X {
    //override 是重写
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }

    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

contract Z is
    X,
    Y //这里必须是先X再Y
{
    //这里override里的x,y没顺序讲究
    function foo() public pure override(X, Y) returns (string memory) {
        return "Z";
    }

    function bar() public pure override(X, Y) returns (string memory) {
        return "Z";
    }
}
