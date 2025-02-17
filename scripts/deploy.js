
const hre = require("hardhat");

async function main() {
  // Dapatkan deployer dari ethers
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const balance = await hre.ethers.provider.getBalance(deployer.address);
  console.log("Account balance:", balance.toString());

  // Ambil USDT address dari environment variable (pastikan sudah didefinisikan di .env)
  const usdtAddress = process.env.USDT_ADDRESS || "0xYourUsdtTokenAddressOnSepolia";
  console.log("Using USDT token address:", usdtAddress);

  // Dapatkan contract factory
  const CloudMiningChisachon = await hre.ethers.getContractFactory("CloudMiningChisachon");

  // Deploy kontrak dengan parameter USDT address
  const cloudMiningChisachon = await CloudMiningChisachon.deploy(usdtAddress);
  await cloudMiningChisachon.waitForDeployment();

  console.log("CloudMiningChisachon deployed to:", await cloudMiningChisachon.getAddress());
}

// Jalankan fungsi main() dan tangani error jika terjadi
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error deploying contract:", error);
    process.exit(1);
  });
