//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasGolf {
    
    uint public total;

    // [1,2,3,4,5,100]
    //开始是 50992 gas
    function sumIfEvenAndLessThan99(uint[] memory nums) external {
        for (uint i = 0; i < nums.length; i += 1){
            bool isEven = nums[i] % 2 == 0; //是否是偶数
            bool isLessThan99 = nums[i] < 99; //是否小于100
            if (isEven && isLessThan99) { //求偶数又小于100的数 的和
                total += nums[i]; //答案是2+4 =6
            }
        }
    }

    //Change memory to calldata
    //49163 gas
    function sumIfEvenAndLessThan99CallData(uint[] calldata nums) external {
        for (uint i = 0; i < nums.length; i += 1){
            bool isEven = nums[i] % 2 == 0; //是否是偶数
            bool isLessThan99 = nums[i] < 99; //是否小于100
            if (isEven && isLessThan99) { //求偶数又小于100的数 的和
                total += nums[i]; //答案是2+4 =6
            }
        }
    }

    //total 在loop中，每次都会被写入，这样浪费gas
    //可以使用一个局部变量，计算时候写入在内存中，计算完成后赋值给状态变量total
    //48952 gas
    function sumIfEvenAndLessThan99LocalVal(uint[] calldata nums) external {
        uint _total = total;
        for (uint i = 0; i < nums.length; i += 1){
            bool isEven = nums[i] % 2 == 0; //是否是偶数
            bool isLessThan99 = nums[i] < 99; //是否小于100
            if (isEven && isLessThan99) { //求偶数又小于100的数 的和
                _total += nums[i]; //答案是2+4 =6
            }
        }
        total = _total;
    }

    //称为短路，意思是前面的“nums[i] % 2 == 0 ”判断不满足，就不会继续后面的“nums[i] < 99” 逻辑了
    //48634 gas
    function sumIfEvenAndLessThan99ShortCircuit(uint[] calldata nums) external {
        uint _total = total;
        for (uint i = 0; i < nums.length; i += 1){
            if (nums[i] % 2 == 0 && nums[i] < 99) { //求偶数又小于100的数 的和
                _total += nums[i]; //答案是2+4 =6
            }
        }
        total = _total;
    }

    //循环增量
    //48244 gas
    function sumIfEvenAndLessThan99LoopIncrements(uint[] calldata nums) external {
        uint _total = total;
        for (uint i = 0; i < nums.length; ++i){
            if (nums[i] % 2 == 0 && nums[i] < 99) { //求偶数又小于100的数 的和
                _total += nums[i]; //答案是2+4 =6
            }
        }
        total = _total;
    }

    //缓存数组长度,loop时候每次都要去读取数组长度，可以先把这个长度保存到局部变量里，就不用每次循环都去读一遍数组长度了
    //48209 gas
    function sumIfEvenAndLessThan99CacheArrayLength(uint[] calldata nums) external {
        uint _total = total;
        uint len= nums.length;
        for (uint i = 0; i < len; ++i){
            if (nums[i] % 2 == 0 && nums[i] < 99) { //求偶数又小于100的数 的和
                _total += nums[i]; //答案是2+4 =6
            }
        }
        total = _total;
    }

    //把数组元素存在内存里
    //48035 gas
    function sumIfEvenAndLessThan99LoadArrayElementsToMemory(uint[] calldata nums) external {
        uint _total = total;
        uint len= nums.length;
        for (uint i = 0; i < len; ++i){
            uint _num = nums[i];//因为这里nums[i]被用到了3次。
            if (_num % 2 == 0 && _num < 99) { //求偶数又小于100的数 的和
                _total += _num; //答案是2+4 =6
            }
        }
        total = _total;
    }

    //总结，最好反复被使用的变量加载到内存里的局部变量。
}