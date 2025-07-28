# VulnerableBank Contract

The contract's original state was this

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VulnerableBank {
    address public owner;
    
    constructor() { 
        owner = msg.sender 
    }
    
    function deposit() public payable {}
    
    function withdraw() public { 
        payable(msg.sender).transfer(address(this).balance); 
    }
    
    function attack() public { }
}
```

## Vulnerabilities and problems in the contract
- Anyone can call withdraw and get all the money in the contract - not just the address who deposited
- Noone can withdraw what they deposits because their balances are not kept
- No semicolon after the line `owner = msg.sender`
- `transfer()` can be exploited through reentrancy attack

## `attack()` function could simply be
```solidity
    // Anyone can call this function to drain all funds from the contract
    function attack() public { 
        withdraw();
    }
```

## Fixed Version of the contract (SimpleBank.sol)

- **`deposit()`**: Allows users to deposit ETH into the contract
- **`withdraw()`**: Allows users to withdraw ETH up to the amount they deposited
- `withdraw()` function is vulnerable to attacks, therefore made it non reentrant
- **`owner`**: Public variable storing the contract deployer's address, made it immutable so making sure it won't change
- Added checks for amounts to deposit and withdraw 

