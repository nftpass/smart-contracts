// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

// TODO
// Update score if we do another off chain calculation
// TODO: add more detailed data from scoring (%humanity, badge (OG, FLIPPER)..)
// Enrich score fields
// Add minting timestamp

contract NFTPASS is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using ECDSA for bytes32;

    Counters.Counter private _tokenIdCounter;

    // review this
    uint256 public constant LIMIT_NFT_AMOUNT = 1;

    // TODO change signer address with the api backend public key
    address private _signerAddress = 0x7e3999B106E4Ef472E569b772bF7F7647D8F26Ba;
    // Mapping signatures hash used
    mapping(string => bool) private _usedNonces;
    // Mapping owner address to global score
    mapping(address => uint256) public globalScores;

    constructor() ERC721("NFTPASS", "NFTPASS") {}

    function _baseURI() internal pure override returns (string memory) {
        return "TODO";
    }

    function hashTransaction(
        address sender,
        uint256 qty,
        string memory nonce
    ) private pure returns (bytes32) {
        bytes32 hash = keccak256(
            abi.encodePacked(
                "\x19Ethereum Signed Message:\n32",
                keccak256(abi.encodePacked(sender, qty, nonce))
            )
        );

        return hash;
    }

    function addresSignerMatch(bytes32 hash, bytes memory signature)
        private
        view
        returns (bool)
    {
        return _signerAddress == hash.recover(signature);
    }

    function mint(
        bytes32 hash,
        bytes memory signature,
        string memory nonce,
        uint256 score
    ) external payable {
        require(addresSignerMatch(hash, signature), "FORBIDDEN_EXTERNAL_MINT");
        require(!_usedNonces[nonce], "HASH_ALREADY_USED");
        require(hashTransaction(msg.sender, score, nonce) == hash, "HASH_FAIL");

        _safeMint(msg.sender, totalSupply() + 1);
        _usedNonces[nonce] = true;
        globalScores[msg.sender] = score;
    }

    function safeMint(address to) private onlyOwner {
        _safeMint(to, _tokenIdCounter.current());
        _tokenIdCounter.increment();
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
}
