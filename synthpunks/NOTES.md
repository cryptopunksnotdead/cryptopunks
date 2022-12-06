# Notes


## Try to Decipher the Random Punk Generator / Formula in Synthetic Punks - Why? Why Not?


``` solidity

enum Gender { Male, Female }

// ...

function tokenURI(uint256 id) public view override returns (string memory) {
    uint256[] memory layers = getAttributes(id);
  // ...
}

// Entropy 0
  function getGender(uint256 id) public view returns (Gender) {
    return randomUint(id, 0) % 2 == 0 ? Gender.Male : Gender.Female;
  }

  // Entropy 1,2-9
  function getAttributeCategories(uint256 id) public view returns (uint256[] memory) {
    uint256[4][9] memory spritesheetRanges = assets.spritesheetRanges();
    uint256 checks = 2 + randomUint(id, 1) % (spritesheetRanges.length - 3); // Number of bytes to check
    uint256[] memory attributes = new uint256[](checks);
    uint256 length = 0;
    for (uint256 i; i < checks; i++) {
      uint256 newAttribute = randomUint(id, 2+i) % (spritesheetRanges.length - 2) + 1; // Skip base category

      bool added = contains(attributes, newAttribute);

      if (added) {
        continue;
      }

      if (getGender(id) == Gender.Female) {
        if (!(spritesheetRanges[newAttribute][3] - spritesheetRanges[newAttribute][1] == 0)) {
          attributes[length] = newAttribute;
          length++;
        }
      } else {
        if (!(spritesheetRanges[newAttribute][2] - spritesheetRanges[newAttribute][0] == 0)) {
          attributes[length] = newAttribute;
          length++;
        }
      }
    }

    uint256[] memory attributesResized = new uint256[](length+1);
    attributesResized[0] = 0;
    for (uint256 i; i < length; i++) {
      attributesResized[i+1] = attributes[i];
    }

    return attributesResized;
  }

  // Entropy 10
  function getAttribute(uint256 id, uint256 _attributeId) public view returns (uint256) {
    uint256[4] memory ranges = assets.spritesheetRanges()[_attributeId];
    Gender gender = getGender(id);
    if (gender == Gender.Female) {
      return ranges[1] + randomUint(id, 10+_attributeId) % (ranges[3] - ranges[1]);
    } else {
      return ranges[0] + randomUint(id, 10+_attributeId) % (ranges[2] - ranges[0]);
    }
  }

  function _getAttributes(address _address) public view returns (uint256[] memory) {
    return getAttributes(getTokenID(_address));
  }

  function getAttributes(uint256 id) public view returns (uint256[] memory) {
    uint256[] memory attributeCategories = getAttributeCategories(id);
    uint256[] memory layers = new uint256[](attributeCategories.length);
    for (uint256 i = 0; i < attributeCategories.length; i++) {
      layers[i] = getAttribute(id, attributeCategories[i]);
    }
    return layers;
  }



// note:
//  address(this) is the address of the contract itself.
//   this keyword refers to the instance of a Contract.

function randomUint(uint256 seed, uint256 offset) public view returns (uint256) {
    require(offset < 32, "Offset out of bounds");
    bytes32 entropy = keccak256(abi.encodePacked(address(this), seed));
    bytes32 mask = bytes32(0xff << (offset * 8));
    uint256 out = uint256((entropy & mask) >> (offset * 8));
    return out;
  }

```

