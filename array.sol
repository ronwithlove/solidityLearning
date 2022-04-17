//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Array {
    uint256[] public nums = [1, 2, 3]; //动态数组
    uint256[3] public numsFixed = [4, 5, 6]; //固定数组

    function example1() external {
        nums.push(4); //向动态数组插值 [1,2,3,4]
        uint256 x = nums[1]; //获取数组中的值 [1,2,777,4]
        nums[2] = 777; //修改
        //直接使用删除是不会改变数组长度的
        delete nums[1]; //删除  [1,0,777,4]
        nums.pop(); //删除最后一个值 [1,0,777]
        uint256 len = nums.length; //获取长度

        //创建一个局部数组，在内存中创建,只能是固定数组
        //因为是固定的，所以无法使用push和pop，这两个操作都会改变数组长度
        uint256[] memory a = new uint256[](5);
    }

    //获取数组所有内容需要使用一个函数返回
    function returnArray() external view returns (uint256[] memory) {
        return nums;
    }

    function returnArray2() external view returns (uint256[3] memory) {
        return numsFixed;
    }
}
