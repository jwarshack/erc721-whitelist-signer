# ERC721 Whitelist Signer

This contract utilizes the EIP712 standard for creating and signing a message offchain then verifying onchain. 

Domain Separator 

## ECDSA Signatures

- Uses the secp256k1 algorithm
- Allows you to prove to verify that a message was signed by a private key without revealing the private key
- Consist of two numbers `r` and `s`
- Ethereum uses an addition `v` (recovery identifier) variable
- Signature can be notated as `{r, s, v}`

### Signing process
1. Calculate hash (`e`) from the message to sign
2. Generate a secure random value for `k`
3. Calculate point <code>(x<sub>1</sub>, y<sub>1</sub></code> on the elliptic curve by multiplying `k` with the `G` constant of the elliptic curve
4. Calculate <code>r = x<sub>1</sub> mod n </code>. If r equals zero, go back to step 2
5. Calculate <code>s = k<sup>-1</sup>(e + rd<sub>a</sub>) mod n</code>

