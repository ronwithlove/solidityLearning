//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC20.sol";

contract CrowdFund {
    struct Campaign {
        address creator;
        uint goal;
        uint32 startAt;
        uint32 endAt;
        bool claimed;
    }

    IERC20 public immutable token;
    uint public count; //用来做筹款活动的ID
    mapping(uint => Campaign) public campaigns; //活动ID count =>众筹项目
    mapping(uint => mapping(address => uint)) public pledgeAmount; //活动ID =>参与人的地址 => 参与的金额



    function launch(uint _goal, uint32 _start, uint32 _endAt) external {

    }

    function cancel(uint _id) external {

    }

    function pledge(uint _id, uint _amount) external {
        
    }

    function unpledge(uint _id, uint _amount) external {
        
    }

    function claim(uint _id) external { //众筹成功，一次性取走钱
        
    }
    
    function refund(uint _id) external { //没有成功，退回所有的钱
        
    }
}