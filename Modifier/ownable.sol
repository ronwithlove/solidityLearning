//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender; //合约的部署者
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    //更换ownwer
    function serOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "invalid address"); //输入的地址不可以是0地址
        owner = _newOwner;
    }

    function ownerCallFunc() external onlyOwner {
        //code
    }

    function anyOneCallFunc() external {
        //code
    }
}
