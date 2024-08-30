import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("@nomicfoundation/hardhat-toolbox");
import * as dotenv from "dotenv";
dotenv.config();

const LISK_SEPOLIA_PRIVATE_KEY = process.env.LISK_SEPOLIA_PRIVATE_KEY||"";
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY||"";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    // for testnet
    'lisk-sepolia': {
      url: 'https://rpc.sepolia-api.lisk.com',
      accounts: [LISK_SEPOLIA_PRIVATE_KEY],
      gasPrice: 1000000000,
    },
  },
  etherscan: {
    apiKey: {
      "lisk-sepolia": ETHERSCAN_API_KEY
    },
    customChains: [
      {
          network: "lisk-sepolia",
          chainId: 4202,
          urls: {
              apiURL: "https://sepolia-blockscout.lisk.com/api",
              browserURL: "https://sepolia-blockscout.lisk.com"
          }
      }
    ]
  },
  sourcify: {
    enabled: false
  },
};



export default config;
