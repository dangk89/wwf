if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    // set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}

web3.eth.defaultAccount = web3.eth.accounts[0];



var CoursetroContract = web3.eth.contract([
    {
        "constant": false,
        "inputs": [
            {
                "name": "_fName",
                "type": "string"
            },
            {
                "name": "_age",
                "type": "uint256"
            }
        ],
        "name": "setInstructor",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "getInstructor",
        "outputs": [
            {
                "name": "",
                "type": "string"
            },
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }
]);

var Coursetro = CoursetroContract.at('0x223ef4228e44fd2f1011308984d1afec2e4b7627');
console.log(Coursetro);

Coursetro.getInstructor(function(error, result){
    if(!error)
    {
        $("#instructor").html(result[0]+' ('+result[1]+' years old)');
        console.log(result);
    }
    else
        console.error(error);
});

$("#button").click(function() {
    Coursetro.setInstructor($("#name").val(), $("#age").val(), function(error, result){
        if(!error) {
            console.log(result);
        }else{
            console.error(error);
        }
    });
});
