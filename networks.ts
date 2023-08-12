import { NetworksUserConfig } from "hardhat/types";

export default function getNetworks(accounts: string[]) {
  const config: NetworksUserConfig = {
    hardhat: {
      chainId: 1337,
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_KEY}`,
      chainId: 1,
      accounts,
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_KEY}`,
      chainId: 11155111,
      accounts,
    },
    goerli: {
      url: "https://rpc.ankr.com/eth_goerli",
      chainId: 5,
      accounts,
    },
    "bsc-mainnet": {
      url: "https://rpc.ankr.com/bsc",
      chainId: 56,
      accounts: accounts,
    },
    "bsc-testnet": {
      url: "https://bsc-testnet.public.blastapi.io",
      chainId: 97,
      accounts,
    },
  };
  return config;
}
