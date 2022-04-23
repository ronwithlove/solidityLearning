//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract father {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    function beer() public pure virtual returns (string memory) {
        return "A";
    }
}

contract son is father {
    //override 是重写
    function foo() public pure override returns (string memory) {
        return "B";
    }

    function bar() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract grandson is son {
    function bar() public pure override returns (string memory) {
        return "grandson";
    }
}
