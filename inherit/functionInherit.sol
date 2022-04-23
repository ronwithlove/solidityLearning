//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
father      Level1
           /       \
son    Level2A    Level2B
           \       /
grandson     Level3 
*/
contract Level1 {
    event Log(string message);

    function foo() public virtual {
        emit Log("Level1.foo");
    }

    function bar() public virtual {
        emit Log("Level1.bar");
    }
}

contract Level2A is Level1 {
    function foo() public virtual override {
        emit Log("Level2A.foo");
        Level1.foo(); //调用父级合约  方法一
    }

    function bar() public virtual override {
        emit Log("Level2A.bar");
        super.bar(); //自动找父级合约的方法调用  方法二
    }
}

//和Level2A一模一样
contract Level2B is Level1 {
    function foo() public virtual override {
        emit Log("Level2B.foo");
        Level1.foo(); //调用父级合约  方法一
    }

    function bar() public virtual override {
        emit Log("Level2B.bar");
        super.bar(); //自动找父级合约的方法调用  方法二
    }
}

contract Level3 is Level2B, Level2A {
    function foo() public override(Level2A, Level2B) {
        Level2A.foo();
    }

    function bar() public override(Level2A, Level2B) {
        //这个时候Level2A.bar() 和 Level2B.bar()都会被调用
        //因为这两个方法里又都继承了Level1.bar()，重复了，所以只会运行一次
        super.bar();
    }
}
