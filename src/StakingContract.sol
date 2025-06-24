// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

contract StakingContract{
    mapping(address => uint256) balances;
    constructor(){

    }

    function stake() public payable {
        require(msg.value>0);
        balances[msg.sender]+=msg.value;
    }

    function unstake(uint256 _amount ) public {
        require(_amount<=balances[msg.sender] && _amount>0,"insufficient balance");
        // payable(msg.sender).transfer(_amount);
        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Failed to send Ether");
        balances[msg.sender]-=_amount;
    }

    function getRewards() public view{

    }

    function claimRewards() public payable{

    }

}