// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {RealStateNFT} from "../src/RealStateNFT.sol";

contract DeployNFTCollection is Script {
    function run() external {
        string memory name_ = "Real Estate NFT";
        string memory symbol_ = "REALE";
        uint256 totalSupply_ = 2;
        string memory baseUri_ = "ipfs://bafybeie5qx5pml77j5xclt732zy37dzkmwaz6sfods4mtg4qtsplnzjr4e/";

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        RealStateNFT nftCollection = new RealStateNFT(
            name_,
            symbol_,
            totalSupply_,
            baseUri_
        );

        vm.stopBroadcast();

        console.log("Token desplegado en:");
        console.logAddress(address(nftCollection));
    }
}
