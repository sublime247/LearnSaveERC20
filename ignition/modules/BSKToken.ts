import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const BSKTokenModule = buildModule("BSKTokenModule", (m) => {

    const erc20Token = m.contract("BSKToken");

  return { erc20Token };
});

export default BSKTokenModule;