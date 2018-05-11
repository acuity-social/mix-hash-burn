pragma solidity ^0.4.23;

import "ds-test/test.sol";

import "./hash_burn.sol";


/**
 * @title HashBurnTest
 * @author Jonathan Brown <jbrown@mix-blockchain.org>
 * @dev Testing contract for HashBurn.
 */
contract HashBurnTest is DSTest {

    HashBurn hashBurn;

    function setUp() public {
        hashBurn = new HashBurn();
    }

    function testControlBurnNoValue() public {
        hashBurn.burn.value(1)(0x1234);
    }

    function testFailBurnNoValue() public {
        hashBurn.burn(0x1234);
    }

    function testBurn() public {
        assertEq(hashBurn.getBurnt(0x1234), 0);
        assertEq(hashBurn.getBurnt(0x2345), 0);
        assertEq(address(hashBurn).balance, 0);

        hashBurn.burn.value(1)(0x1234);
        assertEq(hashBurn.getBurnt(0x1234), 1);
        assertEq(hashBurn.getBurnt(0x2345), 0);
        assertEq(address(hashBurn).balance, 1);

        hashBurn.burn.value(1)(0x2345);
        assertEq(hashBurn.getBurnt(0x1234), 1);
        assertEq(hashBurn.getBurnt(0x2345), 1);
        assertEq(address(hashBurn).balance, 2);

        hashBurn.burn.value(2)(0x1234);
        assertEq(hashBurn.getBurnt(0x1234), 3);
        assertEq(hashBurn.getBurnt(0x2345), 1);
        assertEq(address(hashBurn).balance, 4);

        hashBurn.burn.value(3)(0x2345);
        assertEq(hashBurn.getBurnt(0x1234), 3);
        assertEq(hashBurn.getBurnt(0x2345), 4);
        assertEq(address(hashBurn).balance, 7);

        hashBurn.burn.value(5)(0x1234);
        assertEq(hashBurn.getBurnt(0x1234), 8);
        assertEq(hashBurn.getBurnt(0x2345), 4);
        assertEq(address(hashBurn).balance, 12);

        hashBurn.burn.value(8)(0x2345);
        assertEq(hashBurn.getBurnt(0x1234), 8);
        assertEq(hashBurn.getBurnt(0x2345), 12);
        assertEq(address(hashBurn).balance, 20);

        hashBurn.burn.value(13)(0x1234);
        assertEq(hashBurn.getBurnt(0x1234), 21);
        assertEq(hashBurn.getBurnt(0x2345), 12);
        assertEq(address(hashBurn).balance, 33);
    }

}
