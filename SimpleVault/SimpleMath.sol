//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";

library SimpleMath {

    error SubtractionOverflow(uint256 from, uint256 amount);
    error AdditionOverflow(uint256 a, uint256 b);

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;

        if (c < a) { 
            revert AdditionOverflow(a, b);
        }
        return c;
    }

    function subtract(uint256 from, uint256 amount) internal pure returns (uint256) {
        if (amount > from) {
            revert SubtractionOverflow(from, amount);
        }
        return from - amount;
    }
}