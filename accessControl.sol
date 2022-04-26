//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract AccessControl {
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    //role => account => bool
    //role 用bytes32 的hash而不是用string，因为节约gas
    mapping(bytes32 => mapping(address => bool)) public roles;

    //不希望外部获取角色用private，而且定义完也不会修改，所以用constant
    //先公开，拿到hash再设置成private的
    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    constructor() {
        //部署这个函数的时候把部署者设置为ADMIN，这个内部是不需要检查角色的，分两个grantRole写的原因
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes32 _role, address _account) external onlyRole(ADMIN) {
        _grantRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account) external onlyRole(ADMIN) {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }
}
