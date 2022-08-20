//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721 {//部署当前合约前先要部署ERC721合约，并铸造一个NFT，后面nft需要用到这个类型
    function transferFrom(address _from, address _to, uint _nftId) external;
}

contract EnglishAuction {
    event Start();
    event Bid(address indexed sender, uint amount); //加上索引，在链外对这个地址做批量查询
    event Withdraw(address indexed bidder, uint amount); 
    event End(address highestBidder, uint amount); 

    IERC721 public immutable nft; //用IERC721接口合约做为类型定义，后面需要用到这个接口包含的transferFrom方法
    uint public immutable nftId; //哪个nft

    address payable public immutable seller; //销售者,需要接收主币，加上payable
    uint32 public endAt; //时间戳uint32 足够了

    bool public started; //是否开始拍卖
    bool public ended; //是否结束

    address public highestBidder; //最高出价者
    uint public highestBid; //最高出价
    mapping(address => uint) public bids; //所有出价者和价格

    constructor( address _nft, uint _nftId, uint _startingBid){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender); //msg.sender默认不具备payable属性，要加上
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller, "not seller");
        require(!started, "started");

        started = true;
        endAt = uint32(block.timestamp + 60); //设置开始60秒后结束
        nft.transferFrom(seller, address(this), nftId); //从销售者 转到 当前合约地址

        emit Start();
    }

    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "value < highest bid"); //只有大于最大竞拍价才能继续

        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid; //记录把原最高竞价
        }

        highestBid = msg.value; //最高竞价修改为这次的bid
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    function withdraw() external { //即使竞拍结束，仍然可以取回钱
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "not ended");

        ended = true;
        if (highestBidder != address(0)) {//如果有竞拍的人
            nft.transferFrom(address(this), highestBidder, nftId); //才把nft转出去
            seller.transfer(highestBid); //把钱给销售者
        } else {
            nft.transferFrom(address(this), seller, nftId); //没人竞拍 ，就转回给销售者
        }
        
        emit End(highestBidder, highestBid);
    }
}
