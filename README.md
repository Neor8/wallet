## Simple wallet 

**A minimalistic, simple Ethereum wallet which supports depositing and withdrawing Ether. Designed as a practice project to demonstrate smart contract fundamentals, testing and security-focused development**

# This wallet consists of:

- **Deposit function**: 
- allows the deposit of funds in Ether to this contract
- The sender’s balance is tracked using a mapping
- emits a Deposit event
  
- **Withdraw function**: 
- allows the withdrawal of funds in Ether from this contract
- Includes a custom error Wallet__InsufficientBalance for clearer revert messages
- emits a Withdraw event
  
- **Tests**

## Tests
  
Covers: 

- successful deposit
- successful withdrawal
- balance updates
- event emission

# How to run

**forge test**

## Events

Deposit(address user, uint256 amount, uint256 balance)

Withdraw(address user, uint256 amount, uint256 balance)

## Future improvements 

- adding "expectRevert()" function
- making this contract reentrant-proof
- adding the other security features as underflow and overflow resistance, delegatecall security etc.
- adding fuzz and invariant tests
