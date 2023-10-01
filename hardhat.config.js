require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.19",
  networks: {
    swisstronik: {
      url: "https://json-rpc.testnet.swisstronik.com/", //URL of the RPC node for Swisstronik.
      accounts: [
        "0x26c338dbc56221fac88abfa65638bf04b1b4123de7b222a99d22d8f3a824b514",
      ], //Your private key starting with "0x"
      //Make sure you have enough funds in this wallet to deploy the smart contract
    },
  },
};
