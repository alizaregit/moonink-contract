// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC1155.sol";
import "./Strings.sol";
import "./Ownable.sol";

contract MoonInkMedals is ERC1155, Ownable {
    string name_;
    string symbol_;
    bool[] AllmintedData;

    mapping(address => mapping(uint256 => bool)) minted;

    constructor(string memory _name, string memory _symbol)
        ERC1155(
            "https://ipfs.io/ipfs/QmVHFbsN1iwPDmKZtUARW4WDRSRSTb9oM9EeaSn2wVk5yp/{id}.json"
        )
    {
        name_ = _name;
        symbol_ = _symbol;
    }

    function name() public view returns (string memory) {
        return name_;
    }

    function symbol() public view returns (string memory) {
        return symbol_;
    }

    function mintReward() public returns (bool mintResult) {
        uint256 id;
        for (uint256 i = 1; i <= 5; i++) {
            if (!getminted(_msgSender(), i)) {
                id = i;
                break;
            }
        }
        require(id != 0, "max mint triggred");
        _mint(_msgSender(), id, 1, "");
        minted[_msgSender()][id] = true;
        return (true);
    }

    function getminted(address user, uint256 id) public view returns (bool) {
        return (minted[user][id]);
    }

    function getAllMinted(address user) public returns (bool[] memory) {
        for (uint256 i = 1; i <= 5; i++) {
            AllmintedData.push(minted[user][i]);
        }
        return AllmintedData;
    }

    function uri(uint256 _tokenid)
        public
        pure
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "https://ipfs.io/ipfs/QmVHFbsN1iwPDmKZtUARW4WDRSRSTb9oM9EeaSn2wVk5yp/",
                    Strings.toString(_tokenid),
                    ".json"
                )
            );
    }
}
