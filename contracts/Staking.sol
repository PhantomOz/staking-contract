// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./IERC20.sol";

contract Staking {
    IERC20 token;

    constructor(address _token) {
        token = IERC20(_token);
    }
}
