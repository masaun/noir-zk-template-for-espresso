pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - ZK (Ultraplonk) circuit, which is generated in Noir.
import { UltraVerifier } from "../../../contracts/circuit/plonk_vk.sol"; /// @dev - Deployed-Verifier SC, which was generated based on the main.nr
import { NFTOwnershipVerifier } from "../../../contracts/circuit/NFTOwnershipVerifier.sol";

//import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


/**
 * @notice - Deployment script to deploy all SCs at once - on Sonic Blaze Testnet
 * @dev - [CLI]: Using the CLI, which is written in the bottom of this file, to deploy all SCs
 */
contract DeploymentAllContracts is Script {
    //using SafeERC20 for MockRewardToken;
    UltraVerifier public verifier;
    NFTOwnershipVerifier public nftOwnershipVerifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("espresso-decaf-testnet");
        uint256 deployerPrivateKey = vm.envUint("ESPRESSO_DECAF_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();

        /// @dev - Deploy SCs
        verifier = new UltraVerifier();
        nftOwnershipVerifier = new NFTOwnershipVerifier(verifier);

        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on EDU Chain Testnet
        console.logString("Logs of the deployed-contracts on EDU Chain Testnet");
        console.logString("\n");
        console.log("%s: %s", "UltraVerifier SC", address(verifier));
        console.logString("\n");
        console.log("%s: %s", "NFTOwnershipVerifier SC", address(nftOwnershipVerifier));
        console.logString("\n");
    }
}



/////////////////////////////////////////
/// CLI (icl. SC sources) - New version
//////////////////////////////////////

// forge script script/DeploymentAllContracts.s.sol --broadcast --private-key ${EDU_CHAIN_TESTNET_PRIVATE_KEY} \
//     ./circuits/target/contract.sol:UltraVerifier \
//     ./Starter.sol:Starter --skip-simulation
