<div align="center">

# 🏠 Real Estate NFT — ERC-721 Collection (Foundry + OpenZeppelin)

![Solidity](https://img.shields.io/badge/Solidity-0.8.24-2c2c2c?logo=solidity&logoColor=white)
![Foundry](https://img.shields.io/badge/Foundry-Framework-FFB800)
![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-ERC721-4E5EE4)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow)

</div>

A minimal, production-style **ERC-721** project that tokenizes real-estate properties as NFTs.  
Each property is a unique token; metadata (name, image, attributes) is stored on **IPFS** and resolved via `tokenURI`.

---

## ✨ What recruiters should know
- Clean, **standards-based** NFT implementation (OpenZeppelin ERC-721).
- **Deterministic metadata** scheme: `ipfs://<CID>/<tokenId>.json`.
- **Explicit supply control** and **event logging** for traceability.
- Fully tested and **deployable with Foundry** (local + testnet).
- Clear structure and documentation, ready to extend (roles, royalties, marketplace).

---

## 📦 Project Structure
real-estate-nft/
├─ src/
│ └─ RealEstateNFT.sol # Main ERC-721 contract
├─ script/
│ └─ DeployRealEstateNFT.s.sol # Foundry deployment script
├─ test/
│ └─ RealEstateNFT.t.sol # Unit tests (Foundry + forge-std)
├─ foundry.toml # Foundry config (compiler, remappings)
└─ README.md


---

## 🔐 Smart Contract Overview

**Standard:** ERC-721 (OpenZeppelin)  
**Compiler:** Solidity `0.8.24`  

**Core fields:**
- `uint256 public currentTokenId` — auto-incremented token id (starts at 0)
- `uint256 public totalSupply` — hard cap for collection size
- `string public baseUri` — IPFS folder base, e.g. `ipfs://<CID>/`

**Key functions:**
- `constructor(name_, symbol_, totalSupply_, baseUri_)`
- `mint()` → mints to `msg.sender`, enforces `Sold out` when reaching `totalSupply`
- `tokenURI(tokenId)` → returns `ipfs://<CID>/<tokenId>.json`
- `_baseURI()` → returns `baseUri`

**Events:**
- `event MintNFT(address indexed user, uint256 indexed tokenId)`

---

## 🖼️ Metadata (IPFS) — Expected JSON

Place one JSON per token id inside the IPFS folder referenced by `baseUri`.

**`0.json`**
```json
{
  "name": "Property #0 - City Loft",
  "description": "Modern loft apartment in Madrid.",
  "image": "ipfs://<IMAGE_CID>/house0.png",
  "attributes": [
    { "trait_type": "Location", "value": "Madrid" },
    { "trait_type": "Size", "value": "80 m2" },
    { "trait_type": "Type", "value": "Loft" },
    { "trait_type": "Bedrooms", "value": "1" }
  ]
}
```

Contract will resolve:

tokenId 0 → ipfs://<CID>/0.json  
tokenId 1 → ipfs://<CID>/1.json  
...

## ⚙️ Quickstart (Foundry)

### 1) Requirements

- Foundry installed (`foundryup`)  
- Node running locally (optional): `anvil`

---

### 2) Install deps

```bash
forge install openzeppelin/openzeppelin-contracts foundry-rs/forge-std --no-commit
```

✅ Testing Scope (suggested)

Deploy: constructor params stored (totalSupply, baseUri)

Mint happy path: ownerOf(0) == minter, currentTokenId increments

Sold-out path: third mint reverts with "Sold out"

tokenURI(id): exact match ipfs://<CID>/<id>.json

Event: MintNFT(minter, tokenId) emitted


🔭 Next Steps (nice to have)

Ownable mint (admin-only) or paid/public mint

setBaseURI (admin) + pinning strategy on IPFS

ERC-2981 (royalties) for secondary sales

Simple listing & purchase (on-chain marketplace) with reentrancy guards

CI (GitHub Actions): build + test on PR

📄 License

MIT — free to use, modify, and distribute.
Author: @ivanramirez2




