// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../test/utils/UniswapV1.sol";

import "solady/test/utils/mocks/MockERC20.sol";

contract UniswapV1GasTest is Test {
    MockERC20 asset;
    IUniswapV1Factory factory;
    IUniswapV1Exchange exchange;

    function setUp() public {
        asset = new MockERC20("DAI Stablecoin", "DAI", 18);
        factory = IUniswapV1Factory(deployFactory());
        exchange = IUniswapV1Exchange(deployExchange());
        factory.initializeFactory(address(exchange));
        assertEq(factory.exchangeTemplate(), address(exchange));
    }

    modifier LogGasUsage() {
        uint256 gasBefore = gasleft();
        _;
        uint256 gasAfter = gasleft();

        unchecked {
            console.log("Gas Usage:", gasBefore - gasAfter);
        }
    }

    // 251,388 gas
    function test_CreateExchange_GasUsage() public {
        // Cache to avoid metering SLOADs
        IUniswapV1Factory _factory = factory;
        address _asset = address(asset);

        uint256 gasBefore = gasleft();
        _factory.createExchange(_asset);
        uint256 gasAfter = gasleft();

        emit log_string("Gas Usage:");
        emit log_uint(gasBefore - gasAfter);
    }
}
