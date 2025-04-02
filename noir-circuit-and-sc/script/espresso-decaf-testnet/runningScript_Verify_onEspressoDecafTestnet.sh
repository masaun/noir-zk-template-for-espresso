echo "Load the environment variables from the .env file..."
#source .env
. ./.env

echo "Verifying a proof via the NFTOwnershipVerifier (icl. UltraVerifier) contract on Espresso Decaf testnet..."
forge script script/espresso-decaf-testnet/Verify.s.sol --broadcast --private-key ${ESPRESSO_DECAF_TESTNET_PRIVATE_KEY} --rpc-url ${ESPRESSO_DECAF_TESTNET_RPC} --skip-simulation
