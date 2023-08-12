// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";

contract FaucetUpgradeable is OwnableUpgradeable, UUPSUpgradeable {
    uint256 public amount = 1000;
    uint32 public delayTimeLang = 6 hours;
    mapping(address => uint256) private delayedExpiration;
    mapping(address => bool) private whitelist;

    uint256[49] __gap;

    event Mint(address token, address receiver, uint256 amount);
    event UpdateWhiteList(address account, bool isWhiteList);

    function initialize() public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function mint(address token) public {
        require(
            delayedExpiration[msg.sender] < block.timestamp,
            "time is not up"
        );

        uint256 amountToMint = amount *
            10 ** IERC20MetadataUpgradeable(token).decimals();
        IERC20Upgradeable(token).transfer(_msgSender(), amountToMint);

        delayedExpiration[msg.sender] = block.timestamp + delayTimeLang;
        emit Mint(token, msg.sender, amountToMint);
    }

    function mintTo(
        address token,
        address receiver,
        uint256 _amount
    ) public onlyWhitelist {
        IERC20Upgradeable(token).transfer(receiver, _amount);

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

    function getDelayExpiration(address account) public view returns (uint256) {
        return delayedExpiration[account];
    }

    modifier onlyWhitelist() {
        require(whitelist[msg.sender], "Not Whitelist");
        _;
    }
}
