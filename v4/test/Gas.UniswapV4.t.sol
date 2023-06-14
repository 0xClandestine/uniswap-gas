// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "v4-core/PoolManager.sol";
import "./utils/MockERC20.sol";
import {TickMath} from "v4-core/libraries/TickMath.sol";
import {PoolModifyPositionTest} from "v4-core/test/PoolModifyPositionTest.sol";
import {PoolSwapTest} from "v4-core/test/PoolSwapTest.sol";
import {Deployers} from "@uniswap/v4-core/test/foundry-tests/utils/Deployers.sol";


contract UniswapV4GasTest is Test, Deployers {
    PoolManager public poolManager;
    PoolModifyPositionTest modifyPositionRouter;
    PoolSwapTest swapRouter;

    MockERC20 tokenA;
    MockERC20 tokenB;

    function setUp() public {
        tokenA = new MockERC20();
        tokenB = new MockERC20();
        poolManager = new PoolManager(50000);

        // Helpers for interacting with the pool
        modifyPositionRouter = new PoolModifyPositionTest(IPoolManager(address(poolManager)));
        swapRouter = new PoolSwapTest(IPoolManager(address(poolManager)));
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

        emit log_string("Gas Usage (Init):");
        emit log_uint(gasBefore - gasAfter);
    }

    function test_SingleSwap_1Ether_GasUsage() public {
        PoolManager _poolManager = poolManager;
        IPoolManager.PoolKey memory _poolKey = createPoolKey();
        _poolManager.initialize(_poolKey, SQRT_RATIO_1_1);
        createLiquidity(_poolKey);

        tokenA.mint(address(this), 1e18);
        tokenA.approve(address(swapRouter), 1e18);

        IPoolManager.SwapParams memory params = IPoolManager.SwapParams({
            zeroForOne: true,
            amountSpecified: 1e18,
            sqrtPriceLimitX96: SQRT_RATIO_1_2
        });

        PoolSwapTest.TestSettings memory testSettings = PoolSwapTest.TestSettings({
            withdrawTokens: true,
            settleUsingTransfer: true
        });

        uint256 gasBefore = gasleft();
        swapRouter.swap(_poolKey, params, testSettings);
        uint256 gasAfter = gasleft();
        
        emit log_string("Gas Usage (Single Swap):");
        emit log_uint(gasBefore - gasAfter);
    }

    // -- Helpers -- //
    function createPoolKey() internal view returns (IPoolManager.PoolKey memory) {
        // 0.30% (30 bps) pool
        return IPoolManager.PoolKey(
            Currency.wrap(address(tokenA)), Currency.wrap(address(tokenB)), 3000, 60, IHooks(address(0))
        );
    }

    function createLiquidity(IPoolManager.PoolKey memory poolKey) internal {        
        // Provide liquidity to the pool
        tokenA.approve(address(modifyPositionRouter), 100 ether);
        tokenB.approve(address(modifyPositionRouter), 100 ether);
        tokenA.mint(address(this), 100 ether);
        tokenB.mint(address(this), 100 ether);
        modifyPositionRouter.modifyPosition(poolKey, IPoolManager.ModifyPositionParams(-60, 60, 10 ether));
        modifyPositionRouter.modifyPosition(poolKey, IPoolManager.ModifyPositionParams(-120, 120, 10 ether));
        modifyPositionRouter.modifyPosition(
            poolKey, IPoolManager.ModifyPositionParams(TickMath.minUsableTick(60), TickMath.maxUsableTick(60), 10 ether)
        );
    }
}
