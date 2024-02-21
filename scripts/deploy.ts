import { ethers } from "hardhat";

async function main() {
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const unlockTime = currentTimestampInSeconds + 60;

  // const lockedAmount = ethers.parseEther("0.001");

  const lock = await ethers.deployContract("Lottery", [
    '1000000000000000',
    '10000000000000000',
    '0x805fcab9E2Beb1ECfb95D6a45ef50521B622B33f'
  ]);

  await lock.waitForDeployment();

  console.log(
    `deployed to ${lock.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
