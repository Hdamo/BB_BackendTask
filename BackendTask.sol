// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract BB_Task{
    struct Task{
        string info;
        bool condition;
        uint256 priority;
        string category;
        uint256 dueDate;
    }

    struct indexandTask{
        string description;
        bool condition;
        uint index;
    }

    mapping (address => Task[]) public taskManager;

    function addTask (string memory description, bool completed, uint256 priorityLevel, string memory Genre, uint256 finalDate) public{
        taskManager[msg.sender].push(Task({
            info: description,
            condition: completed,
            priority: priorityLevel,
            category: Genre,
            dueDate: finalDate
        }));
    }

    function markTaskCompleted(uint256 index) public{
        require(index< taskManager[msg.sender].length, "Task does not exist");
        taskManager[msg.sender][index].condition=true;
    }

    function editTask(uint256 index, string memory newDescription) public{
        require(index< taskManager[msg.sender].length, "Task does not exist");
        taskManager[msg.sender][index].info=newDescription;
    }

    function removeTask(uint256 index) public{
        require(index< taskManager[msg.sender].length, "Task does not exist anyways man!!");
        uint256 totalTasks = taskManager[msg.sender].length;
        taskManager[msg.sender][index] = taskManager[msg.sender][totalTasks - 1];
        taskManager[msg.sender].pop();
    }

    function setdueDate(uint256 index,uint256 date) public{
        require(index< taskManager[msg.sender].length, "Task does not exist");
        taskManager[msg.sender][index].dueDate = date;
    }
    function changePriority(uint256 index, uint256 newPriority) public{
        require(index< taskManager[msg.sender].length, "Task does not exist");
        taskManager[msg.sender][index].priority = newPriority;
    }

    function getIndexandTask() view public returns(indexandTask[] memory){
        indexandTask[] memory data = new indexandTask[](taskManager[msg.sender].length);
        Task[] memory userTasks = taskManager[msg.sender];
        for(uint i=0; i<taskManager[msg.sender].length; i++){
            data[i] = indexandTask(userTasks[i].info, userTasks[i].condition, i);
        }

        return data;
    }

    function getCompletedTasks() public view returns(Task[] memory){
        uint256 taskNumber = taskManager[msg.sender].length;
        uint256 completedNumber = 0;
        Task[] memory userData = taskManager[msg.sender];
        for(uint i=0; i<taskNumber; i++){
            if(taskManager[msg.sender][i].condition){
                completedNumber+=1;
            }
        }

        Task[] memory completedTasks = new Task[](completedNumber);
        uint index = 0;
        for(uint i=0; i< taskManager[msg.sender].length; i++){
            if(userData[i].condition){
                completedTasks[index] = userData[i];
                index++;
            }
        }
        return completedTasks;
    }

    function getPendingTasks() public view returns(Task[] memory){
        uint256 taskNumber = taskManager[msg.sender].length;
        uint256 pendingNumber = 0;
        Task[] memory userData = taskManager[msg.sender];
        for(uint i=0; i<taskNumber; i++){
            if(!(taskManager[msg.sender][i].condition)){
                pendingNumber+=1;
            }
        }

        Task[] memory pendingTasks = new Task[](pendingNumber);
        uint index = 0;
        for(uint i=0; i< taskManager[msg.sender].length; i++){
            if(!(userData[i].condition)){
                pendingTasks[index] = userData[i];
                index++;
            }
        }

        return pendingTasks;
    }

    function getTasksbyCategory(string memory requiredCategory) public view returns(Task[] memory){
        uint totalTasks = taskManager[msg.sender].length;
        uint categoryNumber = 0;
        Task[] memory userData= taskManager[msg.sender];
        for(uint i=0;i<totalTasks;i++){
            if(keccak256(abi.encodePacked(userData[i].category)) == keccak256(abi.encodePacked(requiredCategory))){
                categoryNumber++;
            }
        }

        Task[] memory categorizedTasks = new Task[](categoryNumber);
        uint index=0;
        for(uint i = 0; i<totalTasks; i++){
            if(keccak256(abi.encodePacked(userData[i].category)) == keccak256(abi.encodePacked(requiredCategory))){
                categorizedTasks[index] = userData[i];
                index++;
            }
        } 

        return categorizedTasks;
    }

    function gettaskssortedbyDate() public view returns(Task[] memory){
        Task[] memory userData = taskManager[msg.sender];
        uint totalTasks = userData.length;
        for(uint i =0; i<totalTasks; i++ ){
            for(uint j=i+1; j<totalTasks; j++){
                if(userData[i].dueDate>userData[j].dueDate){
                    Task memory temp = userData[i];
                    userData[i] = userData[j];
                    userData[j] = temp;
                }
            }
        }

        return userData;
    }

    function ascendsortbyPriority() public view returns(Task[] memory){
        Task[] memory userData = taskManager[msg.sender];
        uint totalTasks = userData.length;
        for(uint i =0; i<totalTasks; i++ ){
            for(uint j=i+1; j<totalTasks; j++){
                if(userData[i].priority>userData[j].priority){
                    Task memory temp = userData[i];
                    userData[i] = userData[j];
                    userData[j] = temp;
                }
            }
        }

        return userData;
    }
}

