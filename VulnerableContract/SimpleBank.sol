// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SimpleBank is ReentrancyGuard {
    address public immutable i_owner;
    mapping(address => uint256) public balances;
    
    constructor() { 
        i_owner = msg.sender; 
    }

    function deposit() public payable {
        require(msg.value > 0, "Amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public nonReentrant { 
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send ETH");    
    }
} 