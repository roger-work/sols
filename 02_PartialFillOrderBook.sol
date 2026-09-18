// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
SENIOR SOLIDITY LIVE CODING TEST #2
Topic: Signed Orders + Partial Fills
Time: 25-30 minutes

Implement the missing functions.

Requirements:
- EIP-712 signed orders.
- Orders can be partially filled multiple times.
- Cannot overfill.
- Cannot fill after expiry.
- Trader can cancel an order.
- Cancellation prevents future fills.
- Order hash must include every economically relevant field.
- Anyone can submit a valid signed order.
- State must be updated before future external settlement logic.

For this exercise, fillOrder() only records the fill.
*/

contract PartialFillOrderBook {
    enum Side {
        BUY,
        SELL
    }

    struct Order {
        address trader;
        address token;
        address paymentToken;
        Side side;
        uint256 price;
        uint256 quantity;
        uint256 nonce;
        uint256 expiry;
    }

    bytes32 private constant DOMAIN_TYPEHASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

    bytes32 private constant ORDER_TYPEHASH =
        keccak256(
            "Order(address trader,address token,address paymentToken,uint8 side,uint256 price,uint256 quantity,uint256 nonce,uint256 expiry)"
        );

    bytes32 public immutable DOMAIN_SEPARATOR;

    mapping(bytes32 => uint256) public filled;
    mapping(bytes32 => bool) public cancelled;

    event OrderFilled(
        bytes32 indexed orderHash,
        address indexed trader,
        uint256 quantity
    );

    event OrderCancelled(bytes32 indexed orderHash);

    constructor() {
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256("StockX OrderBook"),
                keccak256("1"),
                block.chainid,
                address(this)
            )
        );
    }

    function fillOrder(
        Order calldata order,
        bytes calldata signature,
        uint256 fillQuantity
    ) external {
        // TODO:
        // 1. Validate order.
        // 2. Hash the order using EIP-712.
        // 3. Recover and verify trader signature.
        // 4. Reject cancelled / expired orders.
        // 5. Reject zero or excessive fill.
        // 6. Update filled[orderHash].
        // 7. Emit OrderFilled.
    }

    function cancelOrder(Order calldata order) external {
        // TODO:
        // Only the trader can cancel their own order.
        // Calculate the exact order hash.
        // Mark it cancelled.
        // Emit event.
    }

    function remaining(Order calldata order)
        external
        view
        returns (uint256)
    {
        // TODO:
        // Return quantity still available to fill.
    }

    function hashOrder(Order calldata order)
        public
        view
        returns (bytes32)
    {
        // TODO: Return EIP-712 order digest.
    }

    function recoverSigner(
        bytes32 digest,
        bytes calldata signature
    ) public pure returns (address) {
        // TODO:
        // Recover signer safely.
    }
}
