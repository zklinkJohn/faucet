import { execSync } from "child_process";

import testnetConfig from "./testnet.config";

const networks = Object.keys(testnetConfig);

async function batchVerify() {
  for (const network of networks) {
    if (network === "zksync-era-testnet") continue;
    try {
      execSync(`npx hardhat run scripts/verify.ts --network ${network}`);
      console.log("verify success");
    } catch (error) {
      console.log("verify failed", error);
    }
  }
}

batchVerify();
