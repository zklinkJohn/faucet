// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "zklink-contracts-interface/contracts/IZkLink.sol";

contract FaucetUpgradeable is OwnableUpgradeable, UUPSUpgradeable {
    uint256 public amount = 1000;
    uint32 public delayTimeLang = 6 hours;
    address public zklinkInstance;
    // Mapping from account => token => deplay
    mapping(address => mapping(address => uint256)) private delayedExpiration;
    mapping(address => bool) private whitelist;
    // Mapping from tokenId to mint amount
    mapping(uint16 => uint256) private mintAmount;
    uint256[48] __gap;

    event Mint(address token, address receiver, uint256 amount);
    event UpdateWhiteList(address account, bool isWhiteList);
    event SetMintAmount(uint16 tokenId, uint256 mintAmount);
    event SetZKLink(address zklinkInstance);

    function initialize() public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function mint(address token) public {
        require(
            delayedExpiration[msg.sender][token] + delayTimeLang <
                block.timestamp,
            "time is not up"
        );

        uint16 tokenId = IZkLink(zklinkInstance).tokenIds(token);
        uint256 amountToMint = mintAmount[tokenId];
        IERC20Upgradeable(token).transfer(_msgSender(), amountToMint);

        delayedExpiration[msg.sender][token] = block.timestamp;
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

    function setZKLinkInstance(address _zklinkInstance) public onlyOwner {
        zklinkInstance = _zklinkInstance;

        emit SetZKLink(zklinkInstance);
    }

    function updateMintAllowance(
        uint16[] calldata tokenIds,
        uint256[] calldata mintAmounts
    ) public onlyOwner {
        require(tokenIds.length == mintAmounts.length, "Invalid Params");
        for (uint i = 0; i < tokenIds.length; i++) {
            mintAmount[tokenIds[i]] = mintAmounts[i];
        }
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

    function getMintAmount(
        address token
    ) public view returns (uint16 tokenId, uint256 mintAllowance) {
        tokenId = IZkLink(zklinkInstance).tokenIds(token);
        mintAllowance = mintAmount[tokenId];
    }

    modifier onlyWhitelist() {
        require(whitelist[msg.sender], "Not Whitelist");
        _;
    }
}
