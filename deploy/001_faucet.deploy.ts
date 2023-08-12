import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";

const func: DeployFunction = async function ({
  deployments,
  getNamedAccounts,
}) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("Faucet", {
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
    log: true,
  });
};

func.tags = ["Facuet"];
export default func;
