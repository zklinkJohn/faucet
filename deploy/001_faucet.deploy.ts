import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";

const func: DeployFunction = async function ({
  deployments,
  getNamedAccounts,
}) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("FaucetUpgradeable", {
    from: deployer,
    proxy: {
      proxyContract: "UUPS",
      proxyArgs: ["{implementation}", "{data}"],
      execute: {
        init: {
          methodName: "initialize",
          args: [],
        },
      },
    },
    // deterministicDeployment: ethers.encodeBytes32String("Faucet"),
    log: true,
  });
};

func.tags = ["FaucetUpgradeable"];
export default func;
