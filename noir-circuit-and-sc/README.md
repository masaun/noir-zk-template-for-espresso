# ZK circuit in Noir and its smart contract integration template

## Overview

This template is consist of two components:
- ZK circuit in Noir.
- Smart contract in Solidity and its script and test in Foundry.
  - In the `/script/util` directory, there are 2 ZK modules (Please see the details in the `"ZK modules under the `/script/util` directory"` paragraph in this README):
    - `poseidon2-hash-generator`
    - `ProofConverter.sol`

This template is designed for integrated with the [Espresson-based project templates](https://github.com/masaun/noir-zk-template-for-espresso/tree/main/espresso), which is particuraly working on [Espresso Decaf Testnet](https://docs.espressosys.com/network/releases/testnets/decaf-testnet). (NOTE: This integration with the ZK template is still in progress)


<br>

## ZK modules for Noir under the `/script/util` directory

In the `/script/util` directory, there are 2 modules:
- `poseidon2-hash-generator`
- `ProofConverter.sol`
    
### ZK module - `poseidon2-hash-generator`
The `poseidon2-hash-generator` is consist of the 
- ZK circuit runner with the `NoirJS` library (`/circuit-runner/circuitRunner.ts`) 
- Poseidon Hash generator with the [zkpassport/poseidon2](https://github.com/zkpassport/poseidon2) library(`poseidon2HashGeneratorWithAsync.ts`)


### ZK module - `ProofConverter.sol`
- This is the smart contract that hash a function to slice extra part from a proof file - because the proof file includes the public inputs at the beginning.



<br>

## Installation
- Install the `foundry-noir-helper` module into the `./lib` directory:
```
forge install foundry-noir-helper
```

<br>

## ZK circuit - Test

- Run the test of ZK circuit in Noir:
```bash
cd circuits
sh circuit_test.sh
```

<br>

## ZK circuit - Compile and Generate a ZK Proof

- Compile and Generate a ZK Proof (UltraPlonk) from a ZK circuit in Noir
```bash
cd circuits
sh build.sh
```

<br>

## Smart contract - Script
- Run the `Verify.s.sol` on the Local Network (NOTE: This could work)
```bash
sh ./script/runningScript_Verify.sh
```

- Run the `Verify.s.sol` on the Espresso Decaf Testnet (NOTE: In progress)
```bash
sh ./script/espresso-decaf-testnet/runningScript_Verify_onEspressoDecafTestnet.sh
```

<br>

## Smart contract - Script / Utils

### Hashing with Poseidon2 Hash (Async)
- Run the `poseidon2HashGeneratorWithAsync.ts`
```bash
sh script/utils/poseidon2-hash-generator/usages/async/runningScript_poseidon2HashGeneratorWithAsync.sh
```
(Ref: https://nodejs.org/en/learn/typescript/run#running-typescript-with-a-runner )

<br>

## Smart contract - Test 
- In progress

<br>

## References

- Noir:
  - Noir's doc: https://noir-lang.org/docs
  - NoirJS: https://noir-lang.org/docs/reference/NoirJS/noir_js
  - foundry-noir-helper: https://github.com/0xnonso/foundry-noir-helper

<br>

- Poseidon Hash:
  - `zkpassport/poseidon2`: https://github.com/zkpassport/poseidon2
