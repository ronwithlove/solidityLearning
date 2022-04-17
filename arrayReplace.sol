//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayReplace {
    uint256[] public arr; //动态数组

    //[1,2,3,4,5] 删除 index =2,得到 [1,5,3,4]
    function remove(uint256 _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop(); //弹出最后一位
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(1);
        assert(arr[0] == 1);
        assert(arr[1] == 5);
        assert(arr[2] == 3);
        assert(arr[3] == 4);
        assert(arr.length == 4);

        //test2
        remove(1);
        assert(arr[0] == 1);
        assert(arr[1] == 5);
        assert(arr[2] == 3);
        assert(arr.length == 3);
    }
}
