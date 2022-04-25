//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

//例1
library Math {
    function max(uint256 x, uint256 y) internal pure returns (uint256) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint256 x, uint256 y) external pure returns (uint256) {
        return Math.max(x, y); //调用Math的max方法
    }
}

//例2
library ArrayLib {
    //这里必须是storage，因为传入的是状态变量，位置就是在storage里
    function find(uint256[] storage arr, uint256 x)
        internal
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    using ArrayLib for uint256[]; //using for语法，所有的uint256[]都具备了ArraryLib的功能
    uint256[] public arr = [3, 2, 1];

    function testFind() external view returns (uint256) {
        //return ArrayLib.find(arr, 2); //一般写法
        return arr.find(2); //using for
    }
}
