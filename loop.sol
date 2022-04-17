//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Loops {
    function forLoop() external pure {
        //
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                continue; //跳过下面的内容，继续从i = 4 开始
            }
            if (i == 5) {
                //跳出整个for loop
                break;
            }
        }
    }

    function whileLoop() external pure {
        uint256 j = 0;
        while (j < 10) {
            //code
            j++;
        }
    }

    function sum(uint256 _n) external pure returns (uint256) {
        uint256 s;
        for (uint256 i = 1; i <= _n; i++) {
            s += i;
        }
        return s;
    }
}
