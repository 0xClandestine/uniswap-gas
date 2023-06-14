// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import "forge-std/Test.sol";

import "v3-core/contracts/UniswapV3Pool.sol";
import "v3-core/contracts/UniswapV3Factory.sol";

import "./utils/MockERC20.sol";

contract UniswapV3GasTest is DSTest {
    UniswapV3Pool pair;
    UniswapV3Factory factory;
    MockERC20 tokenA;
    MockERC20 tokenB;

    function setUp() public {
        tokenA = new MockERC20();
        tokenB = new MockERC20();
        factory = new UniswapV3Factory();

        // pair = UniswapV3Pool(
        //     factory.createPool(address(tokenA), address(tokenB), 500)
        // );
    }

    modifier LogGasUsage() {
        uint256 gasBefore = gasleft();
        _;
        uint256 gasAfter = gasleft();

        emit log_string("Gas Usage:");
        emit log_uint(gasBefore - gasAfter);
    }

    // 4,537,328 gas
    function test_CreatePool_GasUsage() public {
        UniswapV3Factory _factory = factory;
        address _tokenA = address(tokenA);
        address _tokenB = address(tokenB);

        uint256 gasBefore = gasleft();
        _factory.createPool(_tokenA, _tokenB, 500);
        uint256 gasAfter = gasleft();

        emit log_string("Gas Usage:");
        emit log_uint(gasBefore - gasAfter);
    }
}
