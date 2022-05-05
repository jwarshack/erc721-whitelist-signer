//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract VerifySig {

  function verify(
    address _signer,
    string memory _message,
    bytes memory _sig
  ) external pure returns (bool) {

    // Hash the message
    bytes32 messageHash = getMessageHash(_message);
    bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

    return recover(ethSignedMessageHash, _sig) == _signer;

  }

  function getMessageHash(string memory _message) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(_message));
  } 

  function getEthSignedMessageHash(bytes32  _messageHash) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(
      "\x19Ethereum Signed Message:\n32",
      _messageHash
    ));
  } 


  function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns (address) {
    (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
    return ecrecover(_ethSignedMessageHash, v, r, s);
  }

  function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
    require(_sig.length == 65, "Invalid signature length"); // 32 + 32 + 1

    assembly {
      // _sig is a dynamic data array with variable length
      // first 32 bytes store the length of data
      // loads memory 32 bytes from the sig point (first 32 bytes are the length)
      r := mload(add(_sig, 32))
      // skip first 32 again, then next 32 because that holds r
      s := mload(add(_sig, 64))
      // skip first 64, then another 32 to get start of v
      // get the first byte beacuse uint8 is one byte
      v := byte(0, mload(add(_sig, 96)))
    }
  }
  

}