// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract Faucet is Ownable {
    uint256 public amount = 1000;
    uint32 public delayTimeLang = 6 hours;
    // Mapping from account => token => deplay
    mapping(address => mapping(address => uint256)) private delayedExpiration;
    mapping(address => bool) private whitelist;

    uint256[49] __gap;

    event Mint(address token, address receiver, uint256 amount);
    event UpdateWhiteList(address account, bool isWhiteList);

    function mint(address token) public {
        require(
            delayedExpiration[msg.sender][token] < block.timestamp,
            "time is not up"
        );

        uint256 amountToMint = amount * 10 ** IERC20Metadata(token).decimals();
        IERC20Metadata(token).transfer(_msgSender(), amountToMint);

        delayedExpiration[msg.sender][token] = block.timestamp + delayTimeLang;
        emit Mint(token, msg.sender, amountToMint);
    }

    function mintTo(
        address token,
        address receiver,
        uint256 _amount
    ) public onlyWhitelist {
        IERC20(token).transfer(receiver, _amount);

        emit Mint(token, receiver, _amount);
    }

    function updateWhiteList(
        address[] calldata toAdd,
        address[] calldata toRemove
    ) public onlyOwner {
        for (uint i = 0; i < toAdd.length; i++) {
            whitelist[toAdd[i]] = true;
            emit UpdateWhiteList(toAdd[i], true);
        }

        for (uint i = 0; i < toRemove.length; i++) {
            whitelist[toRemove[i]] = false;
            emit UpdateWhiteList(toRemove[i], false);
        }
    }

    function setAmountToMint(uint256 _amount) public onlyOwner {
        amount = _amount;
    }

    function setDelayTimeLong(uint32 _delayTimeLong) public onlyOwner {
        delayTimeLang = _delayTimeLong;
    }

    function checkIsInWhiteList(address account) public view returns (bool) {
        return whitelist[account];
    }

    function getDelayExpiration(
        address account,
        address token
    ) public view returns (uint256) {
        return delayedExpiration[account][token];
    }

    modifier onlyWhitelist() {
        require(whitelist[msg.sender], "Not Whitelist");
        _;
    }
}
