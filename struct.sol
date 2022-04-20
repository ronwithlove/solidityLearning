//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }

    //状态变量，都会保存在合约中
    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner; //一个人可能会有好几辆车

    function exmaple() external {
        //结构体赋值， 临时保存在内存中用memory
        Car memory toyota = Car("Toyota", 1990, msg.sender);
        //方式2:注意有大括号
        Car memory lambo = Car({
            model: "Lamborghini",
            year: 1980,
            owner: msg.sender
        });
        //方式3:
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        //推到Car数组中去
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        //push同时赋值，不用特意去创建一个，这也是在内存中的
        cars.push(Car("Ferrari", 2020, msg.sender));

        //获取结构体的值，因为要把变量放在内存里，所以用memory
        Car memory _car = cars[0];
        _car.model; //具体某个值
        _car.year;
        _car.owner;

        //定义在储存中，可以进行修改和删除
        Car storage _car2 = cars[0];
        _car2.year = 2022;
        delete _car2.owner; //删除一个元素中的变量，删除后恢复类型的默认值，比如uint就是0，address就是0地址

        //删除整个结构体
        delete cars[1];
    }
}
