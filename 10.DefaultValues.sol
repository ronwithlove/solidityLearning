//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DefaultValues {
    bool public b; //false
    uint public u; //0
    int public i; //0
    address public a;//默认0地址，十六进制20个0 0x00000000000000000000，十进制40个0
    bytes32 public b32; //默认十六进制32个0，十进制64个0

}
