// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimelockVault {
    /// @notice Fixed delay that will be required before withdrawals are allowed
    /// @dev Immutable saves gas vs storage and cannot be changed after deployment
    uint256 public immutable DELAY_SECONDS;

    /// @notice Tracks how much ETH each user has deposited into the vault
    mapping(address => uint256) public balanceOf;

    /// @notice Emitted whenever a user deposits ETH into the vault
    event Deposited(address indexed user, uint256 amount);

    /**
     * @param _delaySeconds Number of seconds users must wait before withdrawals.
     *                      This cannot be changed after deployment.
     */
    constructor(uint256 _delaySeconds) {
        require(_delaySeconds > 0, "Delay must be greater than 0");
        DELAY_SECONDS = _delaySeconds;
    }

    /**
     * @notice Deposit ETH into the vault.
     * @dev Increases sender's internal balance.
     */
    function deposit() external payable {
        require(msg.value > 0, "Must deposit more than 0");
        balanceOf[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    /**
     * @notice Deposit ETH into the vault.
     * @dev Increases sender's internal balance.
     */
    receive() external payable {
        balanceOf[msg.sender] = msg.value;
        emit Deposited(msg.sender, msg.value);
    }
}
