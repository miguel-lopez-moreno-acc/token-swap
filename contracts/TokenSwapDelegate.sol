// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "./TokenSwapStorageV1.sol";

contract TokenSwapDelegate is Initializable, AccessControl, TokenSwapStorageV1 {
    using SafeERC20 for IERC20;

    event Swap(address indexed user, address tokenIn, address tokenOut, uint amount);

    /**
     * @dev token0 is owanBTC, token1 is wanBTC
     */
    function initialize(address admin, address _token0, address _token1) public payable initializer {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        token0 = _token0;
        token1 = _token1;
    }

    function swap(address _token, uint amount) public {
        require((_token == token0) || (_token == token1), "Not support token");
        address destToken;
        if (_token == token0) {
            destToken = token1;
        } else {
            destToken = token0;
        }

        uint quota = IERC20(destToken).balanceOf(address(this));

        require(amount <= quota, "Swap quota not enough");

        IERC20(_token).safeTransferFrom(msg.sender, address(this), amount);

        IERC20(destToken).safeTransfer(msg.sender, amount);
        
        emit Swap(msg.sender, _token, destToken, amount);
    }

    function deposit(uint amount) public {
        swap(token0, amount);
    }

    function withdraw(uint amount) public {
        swap(token1, amount);
    }
}