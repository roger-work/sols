// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
SENIOR SOLIDITY LIVE CODING TEST #3
Topic: Compliance-Controlled Security Token
Time: 25-30 minutes

Implement the missing compliance logic.

Assume this contract is an ERC20-like token. You may replace the
minimal balance/allowance implementation with OpenZeppelin ERC20
if desired, but preserve the required behavior.

Rules:
- Sender must be verified.
- Recipient must be verified.
- Frozen accounts cannot send or receive.
- Global freeze blocks transfers.
- Each investor has a daily transfer limit.
- transferFrom must obey exactly the same rules as transfer.
- Daily accounting must reset automatically when the UTC day changes.
- Admin-only compliance functions.
*/

contract CompliantSecurityToken {
    string public name = "StockX Security Token";
    string public symbol = "STK";
    uint8 public constant decimals = 18;

    address public admin;
    bool public globalFreeze;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    mapping(address => bool) public verified;
    mapping(address => bool) public frozen;

    mapping(address => uint256) public dailyLimit;
    mapping(address => uint256) public dailyTransferred;
    mapping(address => uint256) public lastTransferDay;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event VerificationUpdated(address indexed investor, bool verified);
    event FrozenUpdated(address indexed investor, bool frozen);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "NOT_ADMIN");
        _;
    }

    function setVerified(address investor, bool value) external onlyAdmin {
        // TODO
    }

    function setFrozen(address investor, bool value) external onlyAdmin {
        // TODO
    }

    function setGlobalFreeze(bool value) external onlyAdmin {
        // TODO
    }

    function setDailyLimit(address investor, uint256 limit)
        external
        onlyAdmin
    {
        // TODO
    }

    function mint(address to, uint256 amount) external onlyAdmin {
        // TODO:
        // Decide whether minting should require the recipient to be verified.
        // For this test, minting MUST NOT bypass recipient compliance.
    }

    function transfer(address to, uint256 amount)
        external
        returns (bool)
    {
        // TODO:
        // Apply the complete compliance check.
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        // TODO:
        // Must apply exactly the same compliance rules as transfer().
        // Then consume allowance safely.
    }

    function _beforeTransfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        // TODO:
        // Centralize compliance logic here.
        //
        // Important edge cases:
        // - day rollover
        // - limit exceeded
        // - frozen sender / recipient
        // - global freeze
        // - zero addresses
        // - insufficient balance
    }

    function _consumeDailyLimit(address investor, uint256 amount)
        internal
    {
        // TODO:
        // Use block.timestamp to derive the current UTC day.
        // Avoid loops and avoid requiring an admin transaction at midnight.
    }
}
