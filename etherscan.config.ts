export default {
  apiKey: {
    mainnet: process.env.ETHERSCAN || "",
    goerli: process.env.ETHERSCAN || "",
    avalancheFujiTestnet: process.env.ETHERSCAN_AVAX || "",
    polygonMumbai: process.env.ETHERSCAN_POLYGON || "",
    arbitrumGoerli: process.env.ETHERSCAN_ARB || "",
    baseGoerli: process.env.ETHERSCAN_BASE || "",
    bscTestnet: process.env.ETHERSCAN_BSC || "",
    "taiko-testnet": "abc",
    "mantle-testnet": "xyz",
    "manta-testnet": "xyz",
  },
  customChains: [
    {
      network: "taiko-testnet",
      chainId: 167005,
      urls: {
        apiURL: "https://explorer.test.taiko.xyz/api",
        browserURL: "https://explorer.test.taiko.xyz",
      },
    },
    {
      network: "mantle-testnet",
      chainId: 5001,
      urls: {
        apiURL: "https://explorer.testnet.mantle.xyz/api",
        browserURL: "https://explorer.testnet.mantle.xyz",
      },
    },
    {
      network: "manta-testnet",
      chainId: 3441005,
      urls: {
        apiURL: "https://manta-testnet.calderaexplorer.xyz/api",
        browserURL: "https://explorer.testnet.mantle.xyz",
      },
    },
  ],
};
