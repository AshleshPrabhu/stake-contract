// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/Coin.sol";

contract TestContract is Test {
    Coin c;

    function setUp() public {
        c = new Coin(0x2a6c565c8d83117AdC4c818E1B51e5CEFebd0432);
    }

    function testInitialSupply() public view{
        assert(c.totalSupply()==0);
    }

    function testMint()public{
        vm.prank(0x2a6c565c8d83117AdC4c818E1B51e5CEFebd0432);
        c.mint(address(this),100);
        assert(c.balanceOf(address(this))==100);
    }
    function testMintRevert()public{
        vm.expectRevert();
        c.mint(address(this),100);
    }
    function testChangeStakingContract()public{
        c.changeStakingContract(address(this));
        c.mint(0x2a6c565c8d83117AdC4c818E1B51e5CEFebd0432, 100);
        assert(c.balanceOf(0x2a6c565c8d83117AdC4c818E1B51e5CEFebd0432)==100);
    }

}
