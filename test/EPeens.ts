import { expect } from "chai";
import { ethers } from "hardhat";

describe("Test EPeens", function () {
  let EPeens: any
  let EPeenDesc: any
  let owner: any
  let addr1: any
  let addr2: any
  let addrs: any

  beforeEach(async function () {

    EPeens = await ethers.getContractFactory("EPeens");
    EPeenDesc = await ethers.getContractFactory("EPeenDescriptorLogic");

    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    //Deploy DoomsDay.sol
    EPeenDesc = await EPeenDesc.deploy();
    await EPeenDesc.deployed();

    EPeens = await EPeens.deploy(EPeenDesc.address);
    await EPeens.deployed();
  });

  describe("Verify Deployment", function () {
    it("Verify Token", async function () {
      expect(await EPeens.name()).to.equal("EPeens");
      expect(await EPeens.symbol()).to.equal("EPEEN");
    });
  });

  describe("Mint", function () {
    it("Mint an EPEEN", async function () {
      expect(await EPeens.totalSupply()).to.equal(0);
      await EPeens.setMinting(true);
      await EPeens.mint(1);
      expect(await EPeens.totalSupply()).to.equal(1);
    });
  });
});