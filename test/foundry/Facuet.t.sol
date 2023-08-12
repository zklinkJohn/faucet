// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "contracts/Faucet.sol";
import {MockERC20} from "contracts/mock/MockERC20.sol";

contract FacuetTest {
    Faucet faucet;
    ERC20 usdc;
    address owner = address(1);
    address user = address(2);

    function setUp() public {
        usdc = new MockERC20("USDC Token","USDC")
        faucet = new Faucet();

        vm.prank(owner);
        usdc.mint(owner,1000000 ether);
        faucet.initialize();
        vm.stopPrank();
    }

    function test_MintTo() public {
        vm.prank(owner);
        usdc.transfer(address(faucet),100 ether);
        faucet.mintTo(user,10 ether);
    }
}
