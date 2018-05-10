pragma solidity ^0.4.23;


/**
 * @title HashBurn
 * @author Jonathan Brown <jbrown@mix-blockchain.org>
 * @dev Burn MIX in association with a 32 byte hash.
 */
contract HashBurn {

    /**
     * @dev Mapping of hash to MIX wei burnt.
     */
    mapping (bytes32 => uint) hashBurnt;

    /**
     * @dev Some MIX has been burnt.
     * @param hash The hash associated with the burn.
     * @param value How much MIX was burnt (wei).
     */
    event Burn(bytes32 indexed hash, uint value);

    function burn(bytes32 hash) external payable {
        hashBurnt[hash] += msg.value;
        emit Burn(hash, msg.value);
    }

    function getBurnt(bytes32 hash) external constant returns (uint) {
        return hashBurnt[hash];
    }

}
