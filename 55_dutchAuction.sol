//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721 {//部署当前合约前先要部署ERC721合约，并铸造一个NFT
    function transferFrom(address _from, address _to, uint _nftId) external;
}

contract DutchAuction {
    uint private constant DURATION = 7 days;//持续7天结束

    IERC721 public immutable nft; //用IERC721接口合约做为类型定义
    uint public immutable nftId; //哪个nft

    address payable public immutable seller; //销售者，卖nft的人，需要接收主币，所以要payable属性
    uint public immutable startingPrice; //起拍价格 合约部署后再输入的不可变量都用 immutable
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate; //每秒折扣率

    constructor(uint _startingPrice, uint _discountRate, address _nft, uint _nftId){
        seller = payable(msg.sender); //msg.sender默认不具备payable属性，要加上
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;

        require(_startingPrice >= _discountRate * DURATION, "starting price < discount");//防止折扣率太高，在拍卖期间商品出现负数
        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt, "auction expired");//购买时合约不能过期

        uint price = getPrice();
        require(msg.value >= price, "ETH < price");//购买价格必须大于售卖价格

        nft.transferFrom(seller, msg.sender, nftId); //把nft从卖家转给买家
        uint refund = msg.value - price; //够买时候的价格可能会比打包时候的价格高，退还了高的部分
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller); //购买完成，销毁此合约，这样合约中所有的钱也会直接退回到创建合约的人这里
    }

}