import { ethers } from "hardhat";

async function main() {
  const ADDR = "0x0233Bd6572657EfBb85e849416BCF7211408F470";
  const Amount = 100000000
  const Staking = await ethers.getContractAt("Staking", ADDR);
  // const staking = Staking.attach("0x5Be076443EdbCc10cE604BF43aBfFF5968534aad");

  const stake = await Staking.stake(Amount);
  console.log("Staked:", await Staking.viewStakes("0x4a3aF8C69ceE81182A9E74b2392d4bDc616Bf7c7"));

  const viewReward = await Staking.viewReward("0x4a3aF8C69ceE81182A9E74b2392d4bDc616Bf7c7");
  console.log("Rewards:", viewReward);

  // const withdraw = await Staking.unstake();
  // console.log("Rewards:", viewReward);


  // console.log(
  //   `deployed to ${staking.target}`
  // );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
