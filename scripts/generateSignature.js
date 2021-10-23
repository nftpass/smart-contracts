require("dotenv").config()
const API_URL = process.env.ROPSTEN_URL;
const PUBLIC_KEY = process.env.PUBLIC_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

const { createAlchemyWeb3 } = require("@alch/alchemy-web3")
const web3 = createAlchemyWeb3(API_URL)

async function generateSignature (address, score) {
    // TODO Create random nonce, for instance use the nonce from the wallet 
    const nonce = between(0,Number.MAX_SAFE_INTEGER);
    // Create signing message
    console.log('address: %sf, score: %d, nonce: %d', address, score, nonce);
    let hashMessage = web3.utils.soliditySha3(address, score, nonce);
    let signature = web3.eth.accounts.sign(hashMessage, PRIVATE_KEY);
    console.log(signature);    
}

/**
 * Returns a random number between min (inclusive) and max (exclusive)
 */
 function between(min, max) {  
    return Math.floor(
      Math.random() * (max - min) + min
    )
  }

// using public address for server private pk
generateSignature("0x1068b21eC3ae81b4A78354287DF6F93602Ca8848", 111111);

