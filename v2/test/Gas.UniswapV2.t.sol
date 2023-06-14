// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.16;

import "./utils/DSTest.sol";
import "./utils/MockERC20.sol";

import "v2-core/UniswapV2Pair.sol";
import "v2-core/UniswapV2Factory.sol";

contract UniswapV2GasTest is DSTest {
    UniswapV2Pair pair;
    UniswapV2Factory factory;
    MockERC20 tokenA;
    MockERC20 tokenB;

    function setUp() public {
        tokenA = new MockERC20();
        tokenB = new MockERC20();
        factory = new UniswapV2Factory(address(this));
    }

    modifier LogGasUsage() {
        uint256 gasBefore = gasleft();
        _;
        uint256 gasAfter = gasleft();

        emit log_string("Gas Usage:");
        emit log_uint(gasBefore - gasAfter);
    }

    // 2,011,234 gas
    function test_CreatePair_GasUsage() public {
        // Cache to avoid metering SLOADs
        UniswapV2Factory _factory = factory;
        address _tokenA = address(tokenA);
        address _tokenB = address(tokenB);

        uint256 gasBefore = gasleft();
        _factory.createPair(_tokenA, _tokenB);
        uint256 gasAfter = gasleft();

        emit log_string("Gas Usage (Init):");
        emit log_uint(gasBefore - gasAfter);
    }

    function test_SingleSwap_1Ether_GasUsage() public {
        pair = UniswapV2Pair(factory.createPair(address(tokenA), address(tokenB)));
        createLiquidity(pair);

        // swapping directly via UniswapV2Pair involves transferring the tokens to the contract
        // we'll overpay here to avoid reverts
        tokenA.mint(address(this), 2e18);
        tokenA.transfer(address(pair), 2e18);

        uint256 gasBefore = gasleft();
        // swap for 1e18 of tokenB
        pair.swap(0, 1e18, address(this), hex"");
        uint256 gasAfter = gasleft();
        emit log_string("Gas Usage (Single Swap):");
        emit log_uint(gasBefore - gasAfter);
    }

    // -- Helper Functions -- //
    function createLiquidity(UniswapV2Pair _pair) internal {
        tokenA.mint(address(_pair), 100e18);
        tokenB.mint(address(_pair), 100e18);

        _pair.mint(address(this));
    }

    
}
