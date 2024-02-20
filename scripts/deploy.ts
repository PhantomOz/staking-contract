import { ethers } from "hardhat";

async function main() {
  const ERC20 = "0x8D34FDbE29c4c60cd76A585372b52b3632C08F57";
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
