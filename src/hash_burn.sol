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

    /**
     * @dev Revert if the call is not transferring MIX.
     */
    modifier hasValue() {
        require (msg.value > 0);
        _;
    }

    /**
     * @dev Burn some MIX in association with a 32 byte hash.
     * @param hash The hash associated with the burn.
     */
    function burn(bytes32 hash) external payable hasValue {
        hashBurnt[hash] += msg.value;
        emit Burn(hash, msg.value);
    }

    /**
     * @dev Get the amount of MIX burnt in association with a hash.
     * @param hash The hash to query.
     */
    function getBurnt(bytes32 hash) external view returns (uint) {
        return hashBurnt[hash];
    }

}
