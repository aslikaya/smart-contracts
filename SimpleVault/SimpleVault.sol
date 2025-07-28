//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";
import {BaseVault} from "./BaseVault.sol";
import {SimpleMath} from "./SimpleMath.sol";

contract SimpleVault is BaseVault {
    using SimpleMath for uint256;
    error AmountNotGreaterThanZero();
    error InsufficientBalance();

    modifier onlyGreaterThanZeroAmount(uint256 amount) {
        if (amount <= 0) {
            revert AmountNotGreaterThanZero();
        }
        _;
    }

    function deposit() public payable override onlyGreaterThanZeroAmount(msg.value) {
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        totalDeposits = totalDeposits.add(msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public override onlyGreaterThanZeroAmount(amount) {
        if(amount > balances[msg.sender]) {
            revert InsufficientBalance();
        }
        balances[msg.sender] = balances[msg.sender].subtract(amount);
        totalDeposits = totalDeposits.subtract(amount);
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send ETH");
        emit Withdraw(msg.sender, amount);
    }

}