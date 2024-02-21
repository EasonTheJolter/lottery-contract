import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config()

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    bscTestnet: {
      url: 'https://data-seed-prebsc-1-s1.binance.org:8545/',
      accounts: [process.env.PRI_KEY!]
    },
    bsc: {
      url: 'https://bsc-dataseed1.binance.org/',
      accounts: [process.env.PRI_KEY!]
    },
    mainnet: {
      url: 'https://ethereum.publicnode.com',
      accounts: [process.env.PRI_KEY!]
    },
    goerli: {
      url: 'https://rpc.ankr.com/eth_goerli',
      accounts: [process.env.PRI_KEY!]
    },
    ethDevnet: {
      url: 'http://5.75.250.252:8546',
      accounts: [process.env.PRI_KEY_TEST!]
    },
    joltEvm: {
      url: 'http://65.109.48.184:8555',
      accounts: [process.env.PRI_KEY!]
    }
  },
  etherscan: {
    apiKey: { // https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan#multiple-api-keys-and-alternative-block-explorers
      mainnet: process.env.ETHERSCAN_API_KEY!, // to verify the source code
      bscTestnet: process.env.BSCSCAN_API_KEY!, // npx hardhat verify --list-networks
      bsc: process.env.BSCSCAN_API_KEY!,
      goerli: process.env.ETHERSCAN_API_KEY!
    }
  },
  sourcify: {
    enabled: true
  }
};

export default config;
