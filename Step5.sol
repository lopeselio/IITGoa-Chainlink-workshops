// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

// Step 1: importing Chainlink Automation contracts and Counters library 
import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";

// Step2: add the `AutomationCompatibleInterface` contract as an imported contract
contract DynamicNFT is ERC721, ERC721URIStorage, KeeperCompatibleInterface {

// Step3: Next, under the contract definition, we’re going to define a new `Counters` variable. This variable will track at which stage of the flower the NFT is at

    using Counters for Counters.Counter;
    Counters.Counter public tokenIdCounter;
// Step 4: add a string array that stores all the metadata for each stage of the dynamic NFT. For this NFT we have three different states possible
    string[] IpfsUri = [
        "https://ipfs.io/ipfs/QmYaTsyxTDnrG4toc8721w62rL4ZBKXQTGj9c9Rpdrntou/seed.json",
        "https://ipfs.io/ipfs/QmYaTsyxTDnrG4toc8721w62rL4ZBKXQTGj9c9Rpdrntou/purple-sprout.json",
        "https://ipfs.io/ipfs/QmYaTsyxTDnrG4toc8721w62rL4ZBKXQTGj9c9Rpdrntou/purple-blooms.json"
    ]; 

// Step 5: create a couple of variables to define the current time, and time since the NFT was last updated or checked

    uint256 lastTimeStamp;
    uint256 interval;


    constructor() ERC721("Dynamic NFT", "DNFT") {}

    function safeMint(address to, uint256 tokenId, string memory uri)
        public
        onlyOwner
    {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
