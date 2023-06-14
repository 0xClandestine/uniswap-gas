// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "v4-core/PoolManager.sol";

import "./utils/MockERC20.sol";

contract UniswapV4GasTest is Test {
    PoolManager public poolManager;
    MockERC20 tokenA;
    MockERC20 tokenB;

    function setUp() public {
        tokenA = new MockERC20();
        tokenB = new MockERC20();
        poolManager = new PoolManager(50000);
    }

    modifier LogGasUsage() {
        uint256 gasBefore = gasleft();
        _;
        uint256 gasAfter = gasleft();

        emit log_string("Gas Usage:");
        emit log_uint(gasBefore - gasAfter);
    }

    // 35,579
    function test_CreatePool_GasUsage() public {
        PoolManager _poolManager = poolManager;
        Currency _tokenA = Currency.wrap(address(tokenA));
        Currency _tokenB = Currency.wrap(address(tokenB));

        IPoolManager.PoolKey memory poolKey = IPoolManager.PoolKey(
            _tokenA, _tokenB, 60, 60, IHooks(address(0))
        );

        uint256 gasBefore = gasleft();
        _poolManager.initialize(poolKey, 4295128739);
        uint256 gasAfter = gasleft();

        emit log_string("Gas Usage:");
        emit log_uint(gasBefore - gasAfter);
    }
}
