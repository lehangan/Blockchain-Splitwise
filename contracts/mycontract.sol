// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
    mapping(address => mapping(address => uint32)) public debt;
    address[] public users;

    function lookup(
        address debtor,
        address creditor
    ) public view returns (uint32 ret) {
        ret = debt[debtor][creditor];
        return ret;
    }

    function add_IOU(address creditor, uint32 amount) public {
        add_IOU_user(msg.sender, creditor, amount);
    }

    function add_IOU_user(
        address debtor,
        address creditor,
        uint32 amount
    ) public {
        debt[debtor][creditor] += amount;
        addUser(creditor);
        addUser(debtor);
    }

    function add_IOU_sub(
        address debtor,
        address creditor,
        uint32 amount
    ) public {
        debt[debtor][creditor] -=amount;
    }

    function addUser(address userAdd) internal {
        for (uint i = 0; i < users.length; i++) {
            if (users[i] == userAdd) return;
        }
        users.push(userAdd);
    }

    function getUsers() public view returns (address[] memory _users) {
        _users = new address[](users.length);
        for (uint i = 0; i < users.length; i++){
            _users[i] = users[i];
        }
    }
}
