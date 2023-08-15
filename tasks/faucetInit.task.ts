import { task } from "hardhat/config";
import { HardhatRuntimeEnvironment } from "hardhat/types";

task("faucetInit", "initialize amount and delayTimeLong").setAction(
  async (taskArgs, hre: HardhatRuntimeEnvironment) => {
    const { deployments, ethers } = hre;
    const { get } = deployments;
    const faucet = await get("FaucetUpgradeable");
    const contract = await ethers.getContractAt(faucet.abi, faucet.address);
    await (await contract.setAmountToMint(1000)).wait();
    await (await contract.setDelayTimeLong(21600)).wait();

    const amount = await contract.amount();
    console.log(`amount: ${amount.toString()}`);
    const timeLong = await contract.delayTimeLang();
    console.log(`timeLong: ${timeLong.toString()}`);
  }
);
