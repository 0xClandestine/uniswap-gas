# 🦄 Uniswap Gas Comparison

## Overview

A comprehensive gas report comparing all four versions of Uniswap, a popular decentralized exchange protocol.

To ensure consistency, the gas cost calculations in this report assume a gas price of *40 GWEI*, and the corresponding USD cost calculations assume an exchange rate of *1 ETH = $1750*.

&nbsp;

## Market Creation

###### *The table below shows the gas costs for creating markets in different Uniswap versions:*

<table align="left" style="width: 75%;">
   <tr>
      <th>Version</th>
      <th>Method</th>
      <th>Gas</th>
      <th>Cost in ETH (40 gwei)</th>
      <th>Cost in USD (1 ETH = $1750)</th>
   </tr>
   <tr>
      <td>V1</td>
      <td>'createExchange()'</td>
      <td>251,388</td>
      <td>0.01005552</td>
      <td>$17.61</td>
   </tr>
   <tr>
      <td>V2</td>
      <td>'createPair()'</td>
      <td>2,011,234</td>
      <td>0.08044936</td>
      <td>$140.79</td>
   </tr>
   <tr>
      <td>V3</td>
      <td>'createPool()'</td>
      <td>4,537,328</td>
      <td>0.18149312</td>
      <td>$318.37</td>
   </tr>
   <tr>
      <td>V4</td>
      <td>'initialize()'</td>
      <td>35,579</td>
      <td>0.00142316</td>
      <td>$2.49</td>
   </tr>
</table>