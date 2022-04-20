//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7;

contract Proxy {
    function deploy() external payable {
        new TestContract();
    }
}

contract TestContract{
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}