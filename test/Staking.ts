import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { deployMockContract } from "ethereum-waffle";
import ERC20ABI from "./mocks/ERC20TokenMockAbi.json";

describe("Staking", function () {
  async function deployStaking() {

    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const ERC20TokenMock = await deployMockContract(owner, ERC20ABI);
    const Staking = await ethers.getContractFactory("Staking");
    const staking = await Staking.deploy(ERC20TokenMock.getAddress());

    return { staking, ERC20TokenMock, owner, otherAccount };
  }
  
});