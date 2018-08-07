# Teleportor - Cross chain token transfer

Transfers ERC20 tokens from Ethereum to EOS chain via a trusted Teleportor Oracle and set of smart contracts on EOS and Ethereum blockchain.


This project is in test phase, don't use it on mainnet yet!.

There are 3 major components to the teleportor system -

* Ethereum smart contracts for ERC20 and teleportor in truffle development environment. These contracts deployed on Ethereum blockchain will be the source of the tokens.
* EOS token smart contract. These contracts deployed on EOSIO chain will be the destination for the tokens.
* Teleportor Oracle client written in NodeJs. 

## Setup Guide

### Step 0 - Clone this repo

* `git clone <url>`

### Step 1: Truffle Deployment of Ethereum Contracts (ERC20 token + Teleportor contract)

* Change dir to eth
    *  `cd eth`

* Install truffle infrastructure
    * `npm install -g truffle`

* Npm install dependencies
    * `npm install`

* Compile the ethereum contracts
    * `truffle compile`

* setup the network specs in data/config.json

* Deploy ERC20 and teleportor contracts
    * `truffle migrate`

### Step 2: Deploy Oracle

* Change dir to eos from project root
    *  `cd eos`

* Npm install dependencies
    * `npm install`

* Start the oracle service
  * `npm start`

### Step 3: Deploy EOS Token Contract

* compile the contracts using EOSIO Contract Development Toolkit (CDT)-
    * Install and use CTD from [here](https://github.com/eosio/eosio.cdt)

* Create an account to deploy eos contract on -
    * `cleos create account eosio eosio.token <EOSTokenCreatorAccount>` 

* Deploy standard EOSIO.token contract
  * `cleos -u <EOS_URL> set contract <EOSTokenCreatorAccount> ./eosio.token`

* Issue custom EOS Token via eosio.token contract
    *  `cleos -u <EOS_Url> push action <EOSTokenCreatorAccount> create '["<EOSTokenCreatorAccount>","4.0000 <EOSTokenName>"]' -p <EOSTokenCreatorAccount>@active`

And we're good to go!