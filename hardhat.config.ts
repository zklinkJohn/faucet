import * as dotenv from "dotenv";
dotenv.config();
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "@nomiclabs/hardhat-etherscan";
import "hardhat-deploy";

import "./tasks";
import getNetworks from "./networks";

const accounts = process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [""];

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
  networks: Object.assign({}, getNetworks(accounts), {}),
  etherscan: {
    apiKey: {
      mainnet: process.env.ETHERSCAN || "",
    },
  },
};

export default config;
