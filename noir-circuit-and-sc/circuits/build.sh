echo "Load the environment variables from the .env file..."
source ../.env
#. ./.env

echo "Compiling circuit..."
nargo compile
if [ $? -ne 0 ]; then
  exit 1
fi

echo "Generate witness..."
nargo execute

echo "Proving and generating a ZK Proof..."
bb prove -b ./target/nft_ownership.json -w ./target/nft_ownership.gz -o ./target/nft_ownership_proof.bin

echo "Generating vkey..."
bb write_vk -b ./target/nft_ownership.json -o ./target/nft_ownership_vk.bin

echo "Link vkey to the zkProof"
bb verify -k ./target/nft_ownership_vk.bin -p ./target/nft_ownership_proof.bin

echo "Check a zkProof"
head -c 32 ./target/nft_ownership_proof.bin | od -An -v -t x1 | tr -d $' \n'

echo "Copy and paste vk for generating a Solidity Verifier contract"
cp ./target/nft_ownership_vk.bin ./target/vk

echo "Generate a Solidity Verifier contract"
bb contract

echo "Copy a Solidity Verifier contract-generated into the ./contracts/borrower/circuit directory"
cp ./target/contract.sol ../contracts/circuit

echo "Rename the contract.sol with the plonk_vk.sol in the ./contracts/borrower/circuit directory"
mv ../contracts/circuit/contract.sol ../contracts/circuit/plonk_vk.sol

echo "Done"