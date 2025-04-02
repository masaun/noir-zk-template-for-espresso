echo "Load the environment variables from the .env file..."
. ./.env

echo "Deploying the UltraVerifier and the NFTOwnershipVerifier contract on Espresso Decaf testnet Testnet..."
forge script script/espresso-decaf-testnet/deployment/DeploymentAllContracts.s.sol --broadcast --private-key ${ESPRESSO_DECAF_TESTNET_PRIVATE_KEY} \
    ./contracts/circuit/plonk_vk.sol:UltraVerifier \
    ./NFTOwnershipVerifier.sol:NFTOwnershipVerifier \
    --skip-simulation