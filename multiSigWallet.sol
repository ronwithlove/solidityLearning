//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner, uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);

    struct Transaction {
        address to;
        uint value;
        bytes data; //如果是合约还可以执行其中的一些函数
        bool executed; //是否被执行
    }

    address[] public owners;
    mapping(address => bool) public isOwner;//可查询某个address是否存在
    uint public required; //同意转帐必须的确认人数

    Transaction[] public transactions; //index就是交易的id号
    mapping(uint => mapping(address => bool)) public approved;//交易id号，某个地址，是否批准这笔交易

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");//如果存在于这个map中，那就是owner
        _;
    }

    modifier txExists(uint _txId) {//可以通过交易的长度来判断这个交易
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }



    constructor(address[] memory _owners, uint _required){//创建的时候就必须输入所有owner,和最少批准人数
        require(owners.length > 0, "owners required");
        //批准人数必须大于0，并且也不可能超过所有owner的人数
        require(_required > 0 && _required <= _owners.length, "invalid required number of owners");
    
        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];//不直接使用_owners[i]是为了节约gas

            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");//排除重复

            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    //提交一笔转账
    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner {
        transactions.push(Transaction({to: _to, value: _value, data: _data, executed: false}));
        emit Submit(transactions.length -1);//这笔交易的ID，肯定是数组中最后一个
    }

    //某个owner批准_txId序号的交易
    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function _getApprovelCount(uint _txId) private view returns (uint count) {
        for (uint i; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovelCount(_txId) >= required, "approvals < required");
        Transaction storage transaction = transactions[_txId];
        
        transaction.executed = true;

        (bool success, ) = transaction.to.call{value: transaction.value}(//给目标地址打钱
            transaction.data
        );
        require(success, "tx failed");
        emit Execute(_txId);
    }

    //某个owner撤销批准
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}