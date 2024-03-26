const { time } = require("console");
const { setServers } = require("dns");
const { ethers } = require("hardhat");
const { run } = require("hardhat");
async function verify(address, constructorArguments) {
  console.log(
    `verify  ${address} with arguments ${constructorArguments.join(",")}`
  );
  await run("verify:verify", {
    address,
    constructorArguments,
  });
}
async function main() {
  let _usdtTokenAddress = "0xDb592b20B4d83D41f9E09a933966e0AC02E7421B";
  let _ethPrice = "110000000000000000";
  let _usdtPrice = "1000000";

  //   const NftBuyWithUsdt = await ethers.deployContract( 'NftBuyWithUsdt' , [_usdtTokenAddress, _ethPrice, _usdtPrice]);

  //     console.log("Deploying NftBuyWithUsdt...");
  //     await NftBuyWithUsdt.waitForDeployment()

  //     console.log("NftBuyWithUsdt deployed to:", NftBuyWithUsdt.target);

  //     await new Promise(resolve => setTimeout(resolve, 10000));
  verify("0x285373EaE9E0112e84d6dCa0201398B87aBF284c", [
    _usdtTokenAddress,
    _ethPrice,
    _usdtPrice,
  ]);
}
main();
