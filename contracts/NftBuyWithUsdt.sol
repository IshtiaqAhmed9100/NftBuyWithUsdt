// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NftBuyWithUsdt is Ownable, ERC721 {
    address public usdtTokenAddress;

    uint256 public ethPrice;
    uint256 public usdtPrice;

    mapping(uint256 => bool) private _tokenExists;

    constructor(
        address _usdtTokenAddress,
        uint256 _ethPrice,
        uint256 _usdtPrice
    ) Ownable(msg.sender) ERC721("NFTUSDT", "UNF") {
        usdtTokenAddress = _usdtTokenAddress;
        ethPrice = _ethPrice;
        usdtPrice = _usdtPrice;
    }

    function buyWithEther() external payable {
        require(msg.value >= ethPrice);

        uint256 tokenId = totalToken() + 1;
        _mint(msg.sender, tokenId);
    }

    function buyWithUSDT(uint256 amount) external {
        require(amount >= usdtPrice);
        require(
            IERC20(usdtTokenAddress).allowance(msg.sender, address(this)) >=
                amount
        );
        require(IERC20(usdtTokenAddress).balanceOf(msg.sender) >= amount);

        uint256 tokenId = totalToken() + 1;
        _mint(msg.sender, tokenId);
    }

    function withdrawETH() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0);
        payable(owner()).transfer(balance);
    }

    function withdrawUSDT(uint256 amount) external onlyOwner {
        uint256 balance = IERC20(usdtTokenAddress).balanceOf(address(this));
        require(balance >= amount);
        IERC20(usdtTokenAddress).transfer(owner(), amount);
    }

    function totalToken() public view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 1; _tokenExists[i]; i++) {
            total++;
        }
        return total;
    }
}
