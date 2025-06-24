// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/StakingContract.sol";

contract TestContract is Test {
    StakingContract c;

    function setUp() public {
        c = new StakingContract();
    }

    function testStake() public {
        vm.deal(address(1), 1 ether);
        vm.prank(address(1));
        c.stake{value:1 ether}();
        // assert(c.balances(address(1)) == 1 ether);
    }
    function testUnstake() public{
        vm.deal(address(1), 1 ether);
        vm.prank(address(1));
        c.stake{value:1 ether}();
        // assert(c.balances(address(1)) == 1 ether);
        vm.prank(address(1));
        c.unstake(0.5 ether);
        // assert(c.balances(address(1))==0.5 ether);

    }




}
