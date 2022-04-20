//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Enum {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status; //声明了一个枚举变量

    struct Order {
        address buyer;
        Status status; //也可以用在结构体中
    }

    Order[] public orders;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    function setToShipped() external {
        status = Status.Shipped;
    }

    //恢复默认，就是恢复到它的第一个值，在这里例子中就是None
    function reset() external {
        delete status;
    }
}
