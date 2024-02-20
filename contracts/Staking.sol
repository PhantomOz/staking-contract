// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./IERC20.sol";

error AMOUNT_CANT_BE_ZERO();
error INSUFFICIENT_FUNDS();
error NO_STAKED_AMOUNT();
error UNABLE_TO_DISPENSE();

contract Staking {
    IERC20 immutable token;
    mapping(address => uint256) private addressToStakedAmount;
    mapping(address => uint256) private addressToStakedTime;
    mapping(address => uint256) private addressToReward;

    event StakeSuccessfull(address indexed _staker, uint256 _amount);
    event UnstakeSuccessfull(address indexed _staker, uint256 _amount);

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
        addressToReward[msg.sender] += _calculateReward(msg.sender);
        addressToStakedAmount[msg.sender] += _amount;
        addressToStakedTime[msg.sender] = block.timestamp;

        emit StakeSuccessfull(msg.sender, _amount);
    }

    function unstake() external {
        if (addressToStakedAmount[msg.sender] <= 0) {
            revert NO_STAKED_AMOUNT();
        }
        uint256 _amount = addressToReward[msg.sender] +
            _calculateReward(msg.sender) +
            addressToStakedAmount[msg.sender];
        if (token.balanceOf(address(this)) < _amount) {
            revert UNABLE_TO_DISPENSE();
        }
        addressToReward[msg.sender] = 0;
        addressToStakedAmount[msg.sender] = 0;
        addressToStakedTime[msg.sender] = 0;

        token.transfer(msg.sender, _amount);

        emit UnstakeSuccessfull(msg.sender, _amount);
    }

    function _calculateReward(
        address _staker
    ) internal view returns (uint256 _reward) {
        uint256 _userStake = addressToStakedAmount[_staker];
        uint256 _stakedTimeSeconds = (addressToStakedTime[msg.sender] / 1000);
        uint256 _currentTimeSeconds = (block.timestamp / 1000);
        _reward =
            (_userStake / 10000) *
            (_currentTimeSeconds / _stakedTimeSeconds);
    }

    function viewReward(
        address _staker
    ) external view returns (uint256 _reward) {
        _reward = addressToReward[_staker] + _calculateReward(_staker);
    }

    function viewStakes(
        address _staker
    ) external view returns (uint256 _stake) {
        _stake = addressToStakedAmount[_staker];
    }
}
