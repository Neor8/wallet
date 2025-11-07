//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * 
 * @title A simple wallet contract
 * @author TZ
 * @notice This contract allows users to deposit and withdraw ether
 * 
*/

contract Wallet {

    ////////////////////
    // Events         //
    ////////////////////
    event Deposit(address user, uint256 amount, uint256 balance);
    event Withdraw(address user, uint256 amount, uint256 balance);

    ////////////////////
    // Errors         //
    ////////////////////
    error Wallet__InsuficientBalance(); 
    
    /////////////////////
    // State variables //
    /////////////////////
    mapping(address => uint256) public balances;

    address public owner;

    /////////////////////
    // Modifiers       //
    /////////////////////
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    /////////////////////
    // Functions       //
    /////////////////////
    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value, balances[msg.sender]);
    }

    function withdraw(uint256 amount) public {
       if (balances[msg.sender] < amount) {
            revert Wallet__InsuficientBalance();
       } else {
            balances[msg.sender] -= amount;
            payable(msg.sender).transfer(amount);
       }
       emit Withdraw(msg.sender, amount, balances[msg.sender]);
    }
}