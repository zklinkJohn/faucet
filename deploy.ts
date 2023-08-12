import { exec } from "child_process";
import testnetConfig from "./testnet.config";
import logger from "./logger";

/**
 * Executes a shell command and return it as a Promise.
 * @param cmd {string}
 * @return {Promise<string>}
 */
function execShellCommand(cmd: string) {
  const exec = require("child_process").exec;
  return new Promise((resolve, reject) => {
    exec(cmd, (error: Error, stdout: any, stderr: any) => {
      if (error) {
        reject(error);
      }
      resolve(stdout ? stdout : stderr);
    });
  });
}

async function batchDeploy() {
  const networks = Object.keys(testnetConfig);
  // const networks = [
  //   "mantle-testnet",
  //   "manta-testnet",
  //   "base-testnet",
  //   "taiko-testnet",
  // ];
  for (const network of networks) {
    if (network !== "zksync-era-testnet") {
      logger.info(`npx hardhat deploy --network ${network}`);
      //   exec(`npx hardhat deploy --network ${network}`);
      try {
        const result = await execShellCommand(
          `npx hardhat deploy --network ${network}`
        );
        console.log(`success: npx hardhat deploy --network ${network}`, result);
      } catch (error) {
        console.error(`error: npx hardhat deploy --network ${network}`, error);
      }
    }
  }
}

batchDeploy();
