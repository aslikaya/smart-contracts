//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";

interface IVault {
    function deposit() external payable;
    function withdraw(uint256 _amount) external;
}

 abstract contract BaseVault is IVault {

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    mapping(address => uint256) public balances;
    uint256 public totalDeposits;
}