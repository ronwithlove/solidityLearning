//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//storge 状态变量，memory是局部变量，calldata只能用在输入的参数
contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todoList;

    function create(string calldata _text) external {
        todoList.push(Todo({text: _text, completed: false}));
    }

    function updateText(uint256 _index, string calldata _text) external {
        todoList[_index].text = _text; //更新单个比较省gas

        //如果更新多个，这个比较节省gas
        // Todo storage todo = todoList[_index];
        // todo.text = _text;
    }

    //本事数组就带get方法，但是练习就再写一个
    function get(uint256 _index) external view returns (string memory, bool) {
        Todo memory todo = todoList[_index]; //这里如果用storage gas fee会省点
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint256 _index) external {
        todoList[_index].completed = !todoList[_index].completed;
    }
}
