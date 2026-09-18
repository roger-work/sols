// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
SENIOR SOLIDITY LIVE CODING TEST #4
Topic: Token Custody Vault + Accounting Invariants
Time: 25-30 minutes

Implement deposit() and withdraw().

Core invariant:
    sum of internal balances <= actual token balance held by vault

Important:
- Tokens may charge transfer fees.
- Tokens may return false.
- Tokens may return no return data.
- Token transfers may invoke callbacks / reenter.
- Accounting must not be increased before confirming what arrived.
*/

interface IERC20Vault {
    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount)
        external
        returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract CustodyVaultAccounting {
    mapping(address => mapping(address => uint256)) public balances;

    bool private locked;

    event Deposited(
        address indexed token,
        address indexed from,
        address indexed beneficiary,
        uint256 requested,
        uint256 credited
    );

    event Withdrawn(
        address indexed token,
        address indexed owner,
        address indexed recipient,
        uint256 amount
    );

    modifier nonReentrant() {
        require(!locked, "REENTRANT");
        locked = true;
        _;
        locked = false;
    }

    function deposit(
        address token,
        uint256 amount,
        address beneficiary
    ) external nonReentrant {
        // TODO:
        // 1. Validate inputs.
        // 2. Read vault token balance BEFORE transfer.
        // 3. transferFrom(msg.sender, address(this), amount).
        // 4. Read vault token balance AFTER transfer.
        // 5. Credit only the amount actually received.
        // 6. Emit Deposited.
        //
        // This is intentionally designed to handle fee-on-transfer tokens.
    }

    function withdraw(
        address token,
        uint256 amount,
        address recipient
    ) external nonReentrant {
        // TODO:
        // 1. Validate recipient.
        // 2. Check caller's internal balance.
        // 3. Decrease accounting BEFORE external token transfer.
        // 4. Safely transfer token.
        // 5. Emit Withdrawn.
        //
        // If transfer fails, the whole transaction must revert and
        // the balance decrease must be rolled back.
    }

    function _safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 amount
    ) internal {
        // TODO:
        // Handle:
        // - normal ERC20 returning true
        // - tokens returning no data
        // - tokens returning false
    }

    function _safeTransfer(
        address token,
        address to,
        uint256 amount
    ) internal {
        // TODO: Same return-value considerations as above.
    }
}
