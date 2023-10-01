// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ToDolist {
    struct TasksItem {
        string task;
        bool isCompleted;
    }

    uint256 public count = 0;
    mapping(string => TasksItem) public tasks;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            owner = msg.sender,
            "you are not allowed to call this function"
        );
    }

    function addTask(string calldata task) public onlyOwner {
        TasksItem memory item = TasksItem({task: task, isCompleted: false});
        tasks[count] = item;
        count++;
    }

    function taskCompleted() public onlyOwner {
        require(!tasks[id].isCompleted, "Task already completed");
        tasks[id].isCompleted = true;
    }
}
