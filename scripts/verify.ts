import hardhat from "hardhat";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import logger from "../logger";
async function verify({ deployments, run }: HardhatRuntimeEnvironment) {
  const { get } = deployments;
  const { implementation } = await get("FaucetUpgradeable");

  try {
    await run("verify:verify", {
      address: implementation,
      constructorArguments: [],
    });
  } catch (error) {
    logger.error(`verify failed: ${error}`);
  }
}

verify(hardhat);
