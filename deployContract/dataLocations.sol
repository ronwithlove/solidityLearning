//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//storge 状态变量，memory是局部变量，calldata只能用在输入的参数
contract DataLocations {
  struct MyStruct {
    uint foo;
    string text;
  }
   
   mapping(address => MyStruct) public myStructs;

    //输入和返回如果有数组、字符串、结构体 都需要用到memory
    //输入产数还可以用calldata
   function exmaples(uint[] calldata y, string calldata s) external returns (uint[] memory){
     myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"}); //把内容加入mapping里

     MyStruct storage myStruct = myStructs[msg.sender];//把mapping里的这个赋值给 myStruct变量，这个是会被保存在链上的
     myStruct.text = "foo"; //修改myStructs内容

     MyStruct memory readOnly = myStructs[msg.sender];//合约调用晚就消失了。
     readOnly.foo = 456;//也可以修改，但是运行结束后这个也就消失了，不会保持在链上。

    _internal(y); //用calldata就可以直接把y传入到这个函数中，如果是用memory就得拷贝一次，浪费gas

     uint[] memory memArr = new uint[](3);//内存中必须是固定数组
     memArr[0] = 234;//因为固定，当然也就不可以用push添加
     return memArr;
   }

   function _internal(uint[] calldata y) private {
     uint x = y[0];
   }
  
}