const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ChowderPals", function () {
  let contract
  let deployer, validWL, invalidWL

  before(async function () {
    // Deploy contract
    const Contract = await ethers.getContractFactory("ChowderPals")
    contract = await Contract.deploy()
    await contract.deployed();

    // Get global signers
    [deployer, validWL, invalidWL] = await ethers.getSigners()

  })
  
  it("Should mint whitelist according to singature", async function () {

   
  });
});
