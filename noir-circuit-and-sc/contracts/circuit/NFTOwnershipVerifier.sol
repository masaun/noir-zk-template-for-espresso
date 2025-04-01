pragma solidity ^0.8.17;

import { UltraVerifier } from "./plonk_vk.sol";
//import "../circuits/target/contract.sol";

contract NFTOwnershipVerifier {
    UltraVerifier public verifier;

    constructor(UltraVerifier _verifier) {
        verifier = _verifier;
    }

    function verifyNFTOwnership(bytes calldata proof, bytes32[] calldata publicInputs) public view returns (bool) {
        bool proofResult = verifier.verify(proof, publicInputs);
        require(proofResult, "Proof is not valid");
        return proofResult;
    }
}
