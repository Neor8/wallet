//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "../src/wallet.sol";

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    receive() external payable {}

    function testDeposit() public {
        // Arrange
        address user = address(this);
        uint256 depositAmount = 1 ether;
        vm.deal(user, depositAmount);

        // Act
        vm.prank(user);
        wallet.deposit{value: depositAmount}();

        // Assert
        uint256 userBalance = wallet.balances(user);
        assertEq(userBalance, depositAmount);
    }

    function testWithdraw() public {
        // Arrange
        address user = wallet.owner();  
        uint256 depositAmount = 1 ether;
        uint256 withdrawAmount = 0.5 ether;
        vm.deal(user, depositAmount);

        // Act
        vm.startPrank(user);
        wallet.deposit{value: depositAmount}();
        wallet.withdraw(withdrawAmount);
        vm.stopPrank();

        // Assert
        uint256 userBalance = wallet.balances(user);
        assertEq(userBalance, depositAmount - withdrawAmount);
    }

    function testWithdrawInsufficientBalance() public {

        vm.expectRevert(Wallet.Wallet__InsufficientBalance.selector);
        wallet.withdraw(1 ether);
        
    }

    function testWithdrawAll() public {

        //Arrange
        address user = makeAddr("user");
        uint256 depositAmount = 1 ether;
        uint256 withdrawAmount = 1 ether;
        vm.deal(user, depositAmount);

        //Act
        vm.startPrank(user);
        wallet.deposit{value: depositAmount}();
        wallet.withdraw(withdrawAmount);
        vm.stopPrank();

        //Assert
        uint256 userBalance = wallet.balances(user);
        assertEq(userBalance, 0);
    }

    function testDepositEmitsEvent() public {
        //Arrange
        address user = address(this);
        uint256 depositAmount = 1 ether;
        vm.deal(user, depositAmount);

        //Act
        vm.expectEmit(true, true, false, true);
        emit Wallet.Deposit(user, depositAmount, depositAmount);

        vm.prank(user);
        wallet.deposit{value: depositAmount}();
    }

}
