//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract B {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

//已知参数的时候，可以这样来向继承的父合约传参
contract AB is A("a"), B("b") {

}

//方法二
contract AB2 is A, B {
    constructor(string memory _name, string memory _text) A(_name) B(_text) {}
}

//方法三, 混合方法一和方法二
contract AB3 is A("a"), B {
    constructor(string memory _text) B(_text) {}
}
