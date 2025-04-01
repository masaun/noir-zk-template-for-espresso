// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { NFTOwnershipVerifier } from "./circuit/NFTOwnershipVerifier.sol";
import { ERC721URIStorage } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/**
 * @title - IP NFT contract
 */
contract NFT is ERC721URIStorage {
    NFTOwnershipVerifier public nftOwnershipVerifier;

    mapping(uint256 => bytes32) private metadataHashes; // Store a "metadata hash" into the "private" storage.
    mapping(bytes32 => bool) private nullifiers;        // Store a "nullifier" into the "private" storage.

    uint256 private nextTokenId = 1;

    constructor() ERC721("NFT", "NFT") {}

    function mintNFT(string memory metadataURI, bytes32 metadataHash) public {
        uint256 tokenId = nextTokenId;
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, metadataURI);
        metadataHashes[tokenId] = metadataHash; // Store a "metadata hash (as a secret) into the "private" storage
        nextTokenId++;
    }

    function verifyNFTOwnership(bytes calldata proof, bytes32 merkleRoot, bytes32 nullifierHash) public view returns (bool isValidProof) {
        //require(ownerOf(tokenId) != address(0), "This NFT does not exist");

        require(!nullifiers[nullifierHash], "This ZK Proof has been already submitted"); // Prevent from 'double-spending' of a ZK Proof.
        nullifiers[nullifierHash] = true;

        bytes32[] memory publicInputs = new bytes32[](2);
        publicInputs[0] = merkleRoot;
        publicInputs[1] = nullifierHash;
        return nftOwnershipVerifier.verifyNFTOwnership(proof, publicInputs); // If "False", this proof is invalid
    }
}
