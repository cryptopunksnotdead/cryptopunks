#  Query (Read) Crypto Punks Blockchain Contracts / Services via Ethlite


## SyntheticPunks by Stephan Cilliers

_CryptoPunks for everyone_

> A unique, fully on-chain CryptoPunk associated with each Ethereum address.

see
- <https://etherscan.io/address/0xaf9CE4B327A3b690ABEA6F78eCCBfeFFfbEa9FDf>
- <https://github.com/stephancill/synthetic-punks>
- <https://opensea.io/collection/synthetic-cryptopunks>
- <https://syntheticpunks.com>




## CryptoPunksTokenUri by 0xTycoon

_The missing tokenURI() for the CryptoPunks_

> This project implements the `tokenURI` function that is missing in the CryptoPunks
contract.
>
> This contract uses the attributes and image data from
`0x16F5A35647D6F03D5D3da7b35409D65ba03aF3B2`
which is the "CryptoPunks Data" contract, deployed by Larva Labs, 8th of Aug 2021.
https://www.larvalabs.com/blog/2021-8-18-18-0/on-chain-cryptopunks
>
> Marketplaces, Wallets and contracts can use this convenient contract to fetch metadata about each punk.


see
- <https://github.com/0xTycoon/punks-token-uri>
- <https://etherscan.io/address/0x93b919324ec9d144c1c49ef33d443de0c045601e> - v ??? - Sep-26-2022 03:20:35 AM

>  A correction: The tokenURI did not return the json result as a base64-encoded data-URI (duh 😅). I've now pushed a fix and deployed a new contract to 0x4e776fCbb241a0e0Ea2904d642baa4c7E171a1E9
>
>  -- 0xTycoon, Sept/28th 2022

- <https://etherscan.io/address/0x4e776fcbb241a0e0ea2904d642baa4c7e171a1e9> - v ??? - Sep-28-2022 11:58:59 AM

> Ouch, I just found another small bug and will be re-deploying the contract. The parsing function missed the fact that punk attribute name can start with the decimal "3"! Yes... 3D Glasses!! 🤦‍♂️
>
> Version 0.0.3 here we come...
>
> -- 0xTycoon, Dec/4th 2022

- <https://etherscan.io/address/0xD8E916C3016bE144eb2907778cf972C4b01645fC> - v ??? - Dec-04-2022 01:45:59 PM

- <https://twitter.com/0xTycoon/status/1599349090642370565>


>  Version history
>
> - 0.0.0 first release
> - 0.0.1 changes tokenURI to return payload as a base64 encoded json URI
> - 0.0.2 bug fix: correctly parse attribute starting with a number (3D Glasses)


