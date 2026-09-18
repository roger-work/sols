// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
Topic: Atomic Delivery-vs-Payment Settlement


Implement settle() and the helper functions.

Requirements:
- Buyer and seller must both sign the exact trade.
- Use EIP-712.
- Prevent replay.
- Reject expired trades.
- Settlement must be atomic.
- Protect against reentrancy.
- Caller may be a relayer.

Hidden edge cases:
- Signature replay
- Wrong signer
- Same nonce with different trade data
- Expired trade
- Reentrant token
- Cross-contract / cross-chain replay
- ECDSA malleability
*/

interface IERC20Minimal {
    function transferFrom(address from, address to, uint256 amount)
        external
        returns (bool);
}

contract DvPSettlement {
    bytes32 private constant EIP712_DOMAIN_TYPEHASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

    bytes32 private constant TRADE_TYPEHASH =
        keccak256(
            "Trade(address buyer,address seller,address securityToken,address paymentToken,uint256 securityAmount,uint256 paymentAmount,uint256 nonce,uint256 deadline)"
        );

    bytes32 private immutable DOMAIN_SEPARATOR;

    mapping(address => mapping(uint256 => bool)) public usedNonces;

    bool private locked;

    struct Trade {
        address buyer;
        address seller;
        address securityToken;
        address paymentToken;
        uint256 securityAmount;
        uint256 paymentAmount;
        uint256 nonce;
        uint256 deadline;
    }

    constructor() {
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                EIP712_DOMAIN_TYPEHASH,
                keccak256("StockX DvP Settlement"),
                keccak256("1"),
                block.chainid,
                address(this)
            )
        );
    }

    modifier nonReentrant() {
        require(!locked, "REENTRANT");
        locked = true;
        _;
        locked = false;
    }

    function settle(
        Trade calldata trade,
        bytes calldata buyerSignature,
        bytes calldata sellerSignature
    ) external nonReentrant {
        // TODO:
        // 1. Validate trade.
        // 2. Build EIP-712 digest.
        // 3. Recover both signers.
        // 4. Verify signatures.
        // 5. Prevent nonce replay.
        // 6. Transfer security token seller -> buyer.
        // 7. Transfer payment token buyer -> seller.
        // 8. Make sure failed transfers revert the entire settlement.
    }

    function _hashTrade(Trade calldata trade)
        internal
        view
        returns (bytes32)
    {
        // TODO: Return EIP-712 digest.
    }

    function _recover(bytes32 digest, bytes calldata signature)
        internal
        pure
        returns (address)
    {
        // TODO:
        // Recover the signer.
        // Senior candidate should handle malformed and malleable signatures.
    }

    function _safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 amount
    ) internal {
        // TODO:
        // Safely perform transferFrom.
        // Consider ERC20 tokens that return false or return no data.
    }
}
