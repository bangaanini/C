require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,  // URL RPC dari Infura atau Alchemy
      accounts: [process.env.PRIVATE_KEY]  // Private key wallet deployer
    }
  }
};
