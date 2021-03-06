// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// TestToken
contract TestWBTC is ERC20("owanBTC", "owanBTC"), Ownable {
  /// @notice Creates `_amount` token to `_to`. Must only be called by the owner (WanSwapFarm).
  function mint(address _to, uint256 _amount) public onlyOwner {
    _mint(_to, _amount);
  }

  function burn(uint256 _amount) public {
    _burn(msg.sender, _amount);
  }
}
