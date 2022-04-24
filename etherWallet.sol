//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdra(uint256 _amount) external {
        require(msg.sender == owner, "caller is not owner");
        //owner.transfer(_amount);
        payable(msg.sender).transfer(_amount); //这样节约gas，因为owner是举报变量，msg.sender已经在内存中了
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
