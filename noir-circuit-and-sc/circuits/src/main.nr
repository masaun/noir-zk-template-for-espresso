use std::hash::poseidon2;
mod tests;      // tests/mod.nr
mod data_types; // data_types.nr

use data_types::NftData; // @dev - NftData struct



fn main(
    root: pub Field, // @dev - Merkle Root
    hash_path: [Field; 2],
    index: Field,
    secret: Field,   // @dev - A hidden metadata hash (private)
    expected_nullifier: Field,
    nft_data: NftData
) -> pub Field {
    println(expected_nullifier); // [Log]: 0x168758332d5b3e2d13be8048c8011b454590e06c44bce7f702f09103eef5a373

    let inputs_for_note_commitment: [Field; 1] = [secret];
    let note_commitment = poseidon2::Poseidon2::hash(inputs_for_note_commitment, inputs_for_note_commitment.len());

    //let inputs_for_nullifier: [Field; 1] = [nft_data.nft_token_id];
    let inputs_for_nullifier: [Field; 5] = [root, secret, nft_data.nft_owner, nft_data.nft_token_id, nft_data.metadata_cid_hash];
    let nullifier = poseidon2::Poseidon2::hash(inputs_for_nullifier, inputs_for_nullifier.len());
    
    // Constraint: nullifier (hash) == expected_nullifier (hash)
    assert(nullifier == expected_nullifier);

    // [TODO]: Constraint - [NOTE]: The std::merkle::compute_merkle_root() can be used with only a "Pedersen" hash.
    //let check_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    //assert(root == check_root);

    nullifier
}
