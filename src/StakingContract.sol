// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

contract StakingContract{
    mapping(address => uint256) balances;
    mapping(address => uint256) unclaimedRewards;
    mapping(address => uint256) lastUpdateTime;
    uint256 multiplier = 1; // currently we are not setting multiplier
    constructor(){

    }

    function stake() public payable {
        require(msg.value>0);
        if(lastUpdateTime[msg.sender] == 0){
            lastUpdateTime[msg.sender]=block.timestamp;
        }else{
            unclaimedRewards[msg.sender]+=(block.timestamp-lastUpdateTime[msg.sender]) * balances[msg.sender];
            lastUpdateTime[msg.sender]=block.timestamp;
        }
        balances[msg.sender]+=msg.value;
    }

    function unstake(uint256 _amount ) public {
        require(_amount<=balances[msg.sender] && _amount>0,"insufficient balance");
        unclaimedRewards[msg.sender]+=(block.timestamp-lastUpdateTime[msg.sender]) * balances[msg.sender];
        lastUpdateTime[msg.sender]=block.timestamp;
        // payable(msg.sender).transfer(_amount);
        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Failed to send Ether");
        balances[msg.sender]-=_amount;


    }

    function getRewards(address _address) public view returns(uint256){
        uint256 currentReward = unclaimedRewards[_address];
        uint256 updateTime = lastUpdateTime[_address];
        uint256 newReward =  (block.timestamp - updateTime) * balances[_address] * multiplier;
        return currentReward + newReward;
    }

    function claimRewards() public payable{
        uint256 currentReward = unclaimedRewards[msg.sender];
        uint256 updateTime = lastUpdateTime[msg.sender];
        uint256 newReward =  (block.timestamp - updateTime) * balances[msg.sender] * multiplier;
    

        // mint new orca token of curr + new;


        unclaimedRewards[msg.sender] = 0;
        lastUpdateTime[msg.sender] = block.timestamp;
    }

}