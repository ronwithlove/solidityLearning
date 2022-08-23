// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RonToken is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 1000;

    address public artist; //royalty fee reciver
    address public txFeeToken; //royalty token type
    uint256 public txFeeAmount; //royalty fee

    constructor(
        address _artist,
        address _txFeeToken,
        uint256 _txFeeAmount
    ) ERC721("RonToken", "RTK") {
        artist = _artist;
        txFeeToken = _txFeeToken;
        txFeeAmount = _txFeeAmount;
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId <= MAX_SUPPLY, "All NFTs have been minted.");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function mintAll(
        address _to,
        uint256 mintNumber,
        string memory uri
    ) external onlyOwner {
        require(totalSupply() < MAX_SUPPLY, "No more tokens are available");
        require(
            totalSupply() + mintNumber <= MAX_SUPPLY,
            "Available token # + Purchase # exceeds the max limit."
        );
        for (uint256 i = 0; i < mintNumber; i++) {
            _safeMint(_to, totalSupply() + 1);
            _setTokenURI(i + 1, uri);
        }
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _payTxFee(from);
        _transfer(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        _payTxFee(from);
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _payTxFee(from);
        _safeTransfer(from, to, tokenId, _data);
    }

    function _payTxFee(address from) internal {
        IERC20 token = IERC20(txFeeToken);
        token.transferFrom(from, artist, txFeeAmount);
    }
}
