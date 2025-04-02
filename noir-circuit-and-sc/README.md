# ZK circuit in Noir and its smart contract integration template

## Overview

This template is consist of two components:
- ZK circuit in Noir.
- Smart contract in Solidity and its script and test in Foundry.
  - In the `./script/util` directory, 



This template is designed for integrated with the [Espresson-based project templates](https://github.com/masaun/noir-zk-template-for-espresso/tree/main/espresso). (NOTE: This integration with the ZK template is still in progress)
  

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
- Run the `Verify.s.sol` on the Local Network
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
