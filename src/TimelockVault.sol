// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimelockVault {
    uint256 public immutable delaySeconds;

    constructor(uint256 _delaySeconds) {
        require(_delaySeconds > 0, "delay=0");
        delaySeconds = _delaySeconds;
    }
}
