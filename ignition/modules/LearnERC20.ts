import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import * as dotenv from "dotenv";
dotenv.config();

const tokenAddress = process.env.ERC20_TOKEN_ADDRESS||"";

const LearnERC20Module = buildModule("LearnERC20Module", (m) => {


  const learnERC20 = m.contract("LearnERC20", [tokenAddress]);

  return { learnERC20 };
});

export default LearnERC20Module;;
