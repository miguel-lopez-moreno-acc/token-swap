// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract TokenSwapStorageV1 {
  using SafeMath for uint256;

  /**
    * @dev token0 is owanBTC, token1 is wanBTC
    */
  address public token0;

  address public token1;
}
