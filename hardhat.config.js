require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.19",
  networks: {
    mainnet: {
      url: process.env.MAINNET_RPC_URL,  // URL RPC dari Infura atau Alchemy untuk mainnet
      accounts: [process.env.PRIVATE_KEY]  // Private key wallet deployer
    }
  }
};
