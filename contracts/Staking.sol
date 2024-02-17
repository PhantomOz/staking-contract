// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./IERC20.sol";

error AMOUNT_CANT_BE_ZERO();
error INSUFFICIENT_FUNDS();

contract Staking {
    IERC20 token;
    mapping(address => uint256) private addressToStakedAmount;
    mapping(address => uint256) private addressToStakedTime;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function stake(uint256 _amount) external {
        if (_amount <= 0) {
            revert AMOUNT_CANT_BE_ZERO();
        }
        if (_amount > token.balanceOf(msg.sender)) {
            revert INSUFFICIENT_FUNDS();
        }
        token.transferFrom(msg.sender, address(this), _amount);
        addressToStakedAmount[msg.sender] += _amount;
        addressToStakedTime[msg.sender] = block.timestamp;
    }
}
