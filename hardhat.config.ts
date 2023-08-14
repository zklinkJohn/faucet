import * as dotenv from "dotenv";
dotenv.config();
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-verify";
import "hardhat-deploy";

import testnetConfig from "./testnet.config";
import etherscanConfig from "./etherscan.config";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  namedAccounts: {
    deployer: process.env.DEPLOYER || "",
  },
  networks: testnetConfig,
  etherscan: etherscanConfig,
};

export default config;
