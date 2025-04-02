pragma solidity ^0.8.17;

import { Script } from "forge-std/Script.sol";
import { NFTOwnershipVerifier } from "../../contracts/circuit/NFTOwnershipVerifier.sol";
import { UltraVerifier } from "../../contracts/circuit/plonk_vk.sol";
//import { UltraVerifier } from "../../circuits/target/contract.sol";
import { ProofConverter } from "../utils/ProofConverter.sol";

contract VerifyScript is Script {
    NFTOwnershipVerifier public nftOwnershipVerifier;
    UltraVerifier public verifier;

    function setUp() public {}

    function run() public returns (bool) {
        uint256 deployerPrivateKey = vm.envUint("ESPRESSO_DECAF_TESTNET_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        /// @dev - Read the each deployed address from the configuration file.
        address ULTRAVERIFER = vm.envAddress("ULTRAVERIFER_ON_ESPRESSO_DECAF_TESTNET");
        address NFT_OWNERSHIP_VERIFIER = vm.envAddress("NFT_OWNERSHIP_VERIFIER_ON_ESPRESSO_DECAF_TESTNET");

        /// @dev - Create the SC instances /w deployed SC addresses
        verifier = UltraVerifier(ULTRAVERIFER);
        nftOwnershipVerifier = NFTOwnershipVerifier(NFT_OWNERSHIP_VERIFIER);
        // verifier = new UltraVerifier();
        // NFTOwnershipVerifier = new NFTOwnershipVerifier(verifier);

        bytes memory proof_w_inputs = vm.readFileBinary("./circuits/target/nft_ownership_proof.bin");
        bytes memory proofBytes = ProofConverter.sliceAfter64Bytes(proof_w_inputs);
        //string memory proof = vm.readLine("./circuits/target/nft_ownership_proof.bin");
        //bytes memory proofBytes = vm.parseBytes(proof);

        bytes32 merkleRoot = 0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629;
        bytes32 nullifierHash = 0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8;

        bytes32[] memory correctPublicInputs = new bytes32[](2);
        correctPublicInputs[0] = merkleRoot;
        correctPublicInputs[1] = nullifierHash;

        bool isValidProof = nftOwnershipVerifier.verifyNFTOwnership(proofBytes, correctPublicInputs);
        return isValidProof;
    }
}
