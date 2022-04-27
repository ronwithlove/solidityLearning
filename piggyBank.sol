//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract PiggyBank {
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    address public owner = msg.sender; //合约拥有者

    receive() external payable {
        //回退函数，收款
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender)); //这里用msg.sender而不是状态变量owner是为了节约gas
    }
}
