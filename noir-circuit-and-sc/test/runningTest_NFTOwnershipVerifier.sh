echo "Load the environment variables from the .env file..."
source .env
#. ./.env

echo "Running the test of the NFTOwnershipVerifierTest..."
forge test --optimize --optimizer-runs 5000 --evm-version cancun --match-contract NFTOwnershipVerifierTest -vvv
