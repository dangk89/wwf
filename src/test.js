var Web3 = require('web3');

if (typeof web3 !== 'undefined') {
    web3 = new Wenpb3(web3.currentProvider)
} else {
    // set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
}


function getAccounts() {
    const ethAccount = web3.eth.accounts[0];

    web3.getBalance('0x628997F794F9aaf1D845CB0f54C607E80D4B0f78').then(
        (res2) => {
            console.log(res2);
        }
    )

    web3.


    // web3.eth.getAccounts().then(
    //     (res) => {
    //         console.log(res[0]);
    //     }
    // );

    // var res = {
    //     account: ethAccount,
    //     balance: balanceInEth(ethAccount)
    // };
    //
    // console.log(res);
}

function balanceInEth(address) {
    return web3.fromWei(web3.eth.getBalance(address).toString(), 'ether')
}


getAccounts();