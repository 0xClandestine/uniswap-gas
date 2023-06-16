# 🦄 Uniswap Gas Comparison

## Overview

A comprehensive gas report comparing all four versions of Uniswap, a popular decentralized exchange protocol.

To ensure consistency, the gas cost calculations in this report assume a gas price of *40 GWEI*, and the corresponding USD cost calculations assume an exchange rate of *1 ETH = $1750*.

*Formulas used:*

<div>
  <img src="assets/formulas.png" alt="Formulas"/>
</div>

&nbsp;
### TODO:

- Deposit Liquidity
- Withdraw Liquidity
- Single-hop Token Swap
- Multi-hop Token Swap

&nbsp;

## Pool Creation

| Version | Method          | Gas        | Cost in ETH (40 gwei) | Cost in USD (1 ETH = $1750) | % Change from previous version|
| ------- | --------------- | ---------- | --------------------- | --------------------------- | ----------------------------- |
| V1      | createExchange  | 251,388    | 0.01005552            | $17.61                      | -                             |
| V2      | createPair      | 2,011,234  | 0.08044936            | $140.79                     | 699.55%                       |
| V3      | createPool      | 4,586,736  | 0.18346944            | $321.25                     | 128.95%                       |
| V4      | initialize      | 35,579     | 0.00142316            | $2.49                       | -99.22%                       |

&nbsp;

## Deposit Liquidity

| Version | Method          | Gas        | Cost in ETH (40 gwei) | Cost in USD (1 ETH = $1750) | % Change from previous version|
| ------- | --------------- | ---------- | --------------------- | --------------------------- | ----------------------------- |
| V1      | addLiquidity    | 84,689     | 0.00338756            | $5.93                       | -                             |
| V2      | mint            | 132,806    | 0.00531224            | $9.30                       | 64.89%                        |
| V3      | mint            | 272,401    | 0.01089604            | $19.06                      | 77.87%                        |
| V4      | -               | -          | -                     | -                           | -                             |

&nbsp;

## Withdraw Liquidity

| Version | Method          | Gas        | Cost in ETH (40 gwei) | Cost in USD (1 ETH = $1750) | % Change from previous version|
| ------- | --------------- | ---------- | --------------------- | --------------------------- | ----------------------------- |
| V1      | -               | -          | -                     | -                           | -                             |
| V2      | -               | -          | -                     | -                           | -                             |
| V3      | -               | -          | -                     | -                           | -                             |
| V4      | -               | -          | -                     | -                           | -                             |

&nbsp;

## Single-hop Token Swap

| Version | Method          | Gas        | Cost in ETH (40 gwei) | Cost in USD (1 ETH = $1750) | % Change from previous version|
| ------- | --------------- | ---------- | --------------------- | --------------------------- | ----------------------------- |
| V1      | -               | -          | -                     | -                           | -                             |
| V2      | swap            | 82,703     | 0.00330812            | $5.78                       | -                             |
| V3      | -               | -          | -                     | -                           | -                             |
| V4      | lock            | 230,015    | 0.0092006             | $16.10                      | -                             |

&nbsp;

## Multi-hop Token Swap

| Version | Method          | Gas        | Cost in ETH (40 gwei) | Cost in USD (1 ETH = $1750) | % Change from previous version|
| ------- | --------------- | ---------- | --------------------- | --------------------------- | ----------------------------- |
| V1      | -               | -          | -                     | -                           | -                             |
| V2      | -               | -          | -                     | -                           | -                             |
| V3      | -               | -          | -                     | -                           | -                             |
| V4      | -               | -          | -                     | -                           | -                             |