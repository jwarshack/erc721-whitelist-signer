//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

/*  
 * This contract uses an 
 *
 *
 */
contract ChowderPals is ERC721 {

  uint256 public totalSupply;
  
  uint256 private constant MAX_SUPPLY = 100;

  string private constant baseURI = "www.example.com/api/";


  bytes32 private immutable DOMAIN_SEPARATOR;
  bytes32 private TYPEHASH = keccak256("presale(address buyer,uint256 limit)");


  address public immutable whitelistSigner;


  constructor() ERC721("Chowder Pals", "CP") {

    uint256 chainId;

    assembly {
      chainId := chainId()
    }
    // Prevents this signature from working on another contract/dapp
    DOMAIN_SEPARATOR = keccak256(
      abi.encode(
        keccak256(
          "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        ),
        keccak256(bytes("ChowderPals")).
        keccak256(bytes(1)),   // Version
        chainId,
        address(this)
      )
    );
  }

  /*
   * @dev signature is an array of bytes
   * 
   */
  function whitelistMint(
    bytes calldata signature,
    uint256 amount,
    uint256 approvedLimit
  ) external {
    require(totalSupply + amount < MAX_SUPPLY, "Max supply exceeded");

    bytes32 digest = keccak256(
      abi.encodePacked(
        "\x19\x01",
        DOMAIN_SEPARATOR,
        keccak256(abi.encode(TYPEHASH, msg.sender, approvedLimit))
      )
    );
  }

  function _baseURI() internal override view returns(string memory) {
    return baseURI;
  }

}
