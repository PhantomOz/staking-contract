import { ethers } from "hardhat";

async function main() {
  const ERC20 = "";
  const staking = await ethers.deployContract("Staking", [ERC20]);

  await staking.waitForDeployment();

  console.log(
    `deployed to ${staking.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
