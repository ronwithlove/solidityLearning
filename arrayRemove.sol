//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract ArrayRemove {
    uint256[] public arr; //动态数组

    //通过remove方法删除数组中的一位数：
    //[1,2,3,4,5] 删除 index =2,得到 [1,2,4,5]
    function remove(uint256 _index) public {
        //检查index，不可以大于超过现在数组的长度
        require(_index < arr.length, "index out of bound");

        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1]; //把数组后一位向前复制一位
        }
        arr.pop(); //弹出最后一位
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        //test2
        arr = [1]; //如果数组就一位，那删除后就空了，长度为0
        remove(0);
        assert(arr.length == 0);
    }
}
