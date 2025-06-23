// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Coin is ERC20{
    address owner;
    address stakingContract;

    constructor (address _stakingContract) ERC20("COIN","C"){
        owner=msg.sender;
        stakingContract = _stakingContract;
    }
    modifier onlyOwner(){
        require(msg.sender==owner,"You dont have the rights to perform the action");
        _;
    }
    modifier onlyContract(){
        require(msg.sender==stakingContract,"only the staking contract can mint");
        _;
    }
    function mint(address user , uint256 amount) public onlyContract {
        _mint(user,amount);
    }
    function changeStakingContract(address _owner) onlyOwner public{
        stakingContract=_owner;
    }
}
