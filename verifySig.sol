//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract VerifySig {
    function verify(
        address _signer, //签名人
        string memory _message, //签名内容
        bytes memory _sig //签名结果
    ) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message); //对内容做hash
        bytes32 ethSignedMessageHash = getEthSignedMEssageHash(messageHash); //再做一次eth签名hash

        return recover(ethSignedMessageHash, _sig) == _signer; //使用“eth签名hash”和“签名”可以恢复出“签名人”
    }

    function getMessageHash(string memory _message) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMEssageHash(bytes32 _messageHash) public pure returns(bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns(address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure returns(bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}
