import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";

const func: DeployFunction = async function ({
  deployments,
  getNamedAccounts,
}) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const block = await ethers.provider.getBlock("latest");
  const unlockTime = block.timestamp + 24 * 60 * 60;

  await deploy("Lock", {
    from: deployer,
    args: [unlockTime],
    log: true,
  });
};

func.tags = ["Lock"];
export default func;
