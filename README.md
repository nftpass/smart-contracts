## NFT Smart Contracts

NFT Pass smart contract with the following features:
TODO

### Requirements

The following programs have to be installed:

- npm
- hardhat

### Getting Started

The following commands will install dependencies and run the tests.

1.) Install Dependencies:

```
npm install
```

2.) Compile smart contracts

```
npx hardhat compile
```

### Deploy testnet (rinkeby available)

#### Requirements

In order to deploy to a testnet the following API keys are required

- Alchemy api key (get it one from alchemyapi.io)
- Etherscan api key (if you want to verify the contract code)
- Private and public key for the ethereum account that is used

Create a file ".env" in the root directory with those keys

#### Deploy commands (only testnet for instance)

For deploying Nftpass:

```
npx hardhat run scripts/deploy.js --network rinkeby
```

# Advanced Sample Hardhat Project

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat help
REPORT_GAS=true npx hardhat test
npx hardhat coverage
npx hardhat run scripts/deploy.js
node scripts/deploy.js
npx eslint '**/*.js'
npx eslint '**/*.js' --fix
npx prettier '**/*.{json,sol,md}' --check
npx prettier '**/*.{json,sol,md}' --write
npx solhint 'contracts/**/*.sol'
npx solhint 'contracts/**/*.sol' --fix
```

# Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as rinkeby.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your rinkeby node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
npx hardhat run --network rinkeby scripts/deploy.js
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network rinkeby DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```
