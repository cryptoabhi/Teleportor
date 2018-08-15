const fs = require('fs');

var ERC20Token = artifacts.require("./ERC20.sol");
var Teleportor = artifacts.require("./TeleportorOperator.sol")

module.exports = function (deployer) {
  const config = JSON.parse(fs.readFileSync("../data/config.json"));
  const name = "ERC20 Test";
  const symbol = config.eth.symbol;
  const decimals = config.eth.decimals;
  const tokens = config.eth.tokens;
  const minimumAmount = config.eth.minimum_amount;

  deployer.deploy(ERC20Token, name, symbol, tokens, decimals).then(() => {
    return deployer.deploy(Teleportor, ERC20Token.address, minimumAmount);
  })
    .then(() => {
     console.log(ERC20Token.address);
     console.log(Teleportor.address);
    fs.writeFileSync('../data/erc20_address', ERC20Token.address);
    fs.writeFileSync('../data/teleportor_address', Teleportor.address);
    })
};