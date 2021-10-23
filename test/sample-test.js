const { expect } = require("chai");
const { ethers } = require("hardhat");

const valid_signature = '0x04008d265726229b825d0cd2a354b493ec5981ffaaecfb742b8e02760df023452e45330a5b49bb3c108b90cb5e88e1198a2075fcc7046943b0668622b1cd27151c';
const valid_hash = '0xa57dcdb32ba68dd5b6ad0d6e0f4ee7000f25fa614417f242c9361919ca682934';
const valid_score = 111111;
const valid_nonce = 10;

describe("Nftpass", function () {
  it("Should be able to mint with a valid signature", async function () {
    const Nftpass = await ethers.getContractFactory("NFTPASS");
    const nftpass = await Nftpass.deploy();
    await nftpass.deployed();

    expect(await nftpass.name()).to.equal("NFTPASS");
    const mintingTx = await nftpass.mint(valid_hash, valid_signature, valid_nonce, valid_score);

    // wait until the transaction is mined
    await mintingTx.wait();
    expect(await nftpass.ownerOf(0)).to.equal("0x1068b21eC3ae81b4A78354287DF6F93602Ca8848");
  });
  it("Should not be able to mint with different nonce than the one signed", async function () {
    const Nftpass = await ethers.getContractFactory("NFTPASS");
    const nftpass = await Nftpass.deploy();
    await nftpass.deployed();

    const invalid_nonce = 9999;
    const mintingTx = await nftpass.mint(valid_hash, valid_signature, invalid_nonce, valid_score);
    // await mintingTx.wait();
    try {
      await mintingTx.wait();
    } catch (e) {
        expect(e).to.be("Error: VM Exception while processing transaction: reverted with reason string 'HASH_FAIL'");
    }
  });
  it("Should not be able to mint with different score than the one signed", async function () {
    const Nftpass = await ethers.getContractFactory("NFTPASS");
    const nftpass = await Nftpass.deploy();
    await nftpass.deployed();

    const invalid_score = 999;
    const mintingTx = await nftpass.mint(valid_hash, valid_signature, valid_nonce, invalid_score);
    // await mintingTx.wait();
    try {
      await mintingTx.wait();
    } catch (e) {
        expect(e).to.be("Error: VM Exception while processing transaction: reverted with reason string 'HASH_FAIL'");
    }
  });
});
