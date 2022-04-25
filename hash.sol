//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract HashFunc {
    function hash(
        string memory text,
        uint256 num,
        address addr
    ) external pure returns (bytes32) {
        return keccak256(abi.encode(text, num, addr));
    }

    function encode(string memory text0, string memory text1)
        external
        pure
        returns (
            bytes memory //不定长度
        )
    {
        return abi.encode(text0, text1);
    }

    function encodePacked(string memory text0, string memory text1)
        external
        pure
        returns (
            bytes memory //不定长度
        )
    {
        return abi.encodePacked(text0, text1); //不会补0，容易出现漏洞
        //比如打包 AAA 和BBB，结果与 AA和ABBB是一样的,那么这两个情况的哈希值也会相同
    }
}
