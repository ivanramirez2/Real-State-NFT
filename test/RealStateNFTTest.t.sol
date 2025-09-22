// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/RealStateNFT.sol";

contract RealStateNFTTest is Test {
    RealStateNFT nft;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    function setUp() public {
        nft = new RealStateNFT(
            "Real Estate NFT",
            "REALE",
            2,
            "ipfs://bafybeie5qx5pml77j5xclt732zy37dzkmwaz6sfods4mtg4qtsplnzjr4e/"
        );
    }

    function testMintAssignsOwner() public {
        vm.prank(randomUser);
        nft.mint();

        assertEq(nft.ownerOf(0), randomUser);
        assertEq(nft.currentTokenId(), 1); // debe avanzar el contador
    }

    function testCanNotMintBeyondTotalSupply() public {
        vm.prank(randomUser);
        nft.mint();

        vm.prank(randomUser);
        nft.mint();

        // ahora debería estar en sold out
        assertEq(nft.currentTokenId(), 2);

        vm.prank(randomUser);
        vm.expectRevert();
        nft.mint();
    }


    function testTokenUriCorrect() public {
        vm.prank(randomUser);
        nft.mint();
        
        string memory expected = "ipfs://bafybeie5qx5pml77j5xclt732zy37dzkmwaz6sfods4mtg4qtsplnzjr4e/0.json";
        string memory actual = nft.tokenURI(0);

        assertEq(actual, expected);
    }


}
