// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


contract SecretRegistry {
    mapping(bytes32 => uint256) private secretToBlock;


    event SecretRevealed(bytes32 indexed secrethash, bytes32 secret);
    
    /**
     * @dev Register the secret that's been used for validation
     */
    function registerSecret(bytes32 secret) public returns (bool) {
        bytes32 secrethash = sha256(abi.encodePacked(secret));
        if (secretToBlock[secrethash] > 0) {
            return false;
        }
        secretToBlock[secrethash] = block.number;
        emit SecretRevealed(secrethash, secret);
        return true;
    }

  

    function getRevealedSecretBlockHeight(bytes32 secrethash) public view returns (uint256) {
        return secretToBlock[secrethash];
    }

}
