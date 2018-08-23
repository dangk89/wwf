pragma solidity ^0.4.24;

contract Test {
    
constructor () public payable {
}

function getContractBalance() public constant returns (uint256) {
    return address(this).balance;
}

 function getContractAddress() public constant returns (address) {
    return this;
}

function getBalance(address account) public constant returns (uint256){
    return account.balance;
}

function transfer(address account, uint amount) public payable{
    account.transfer(amount);
}

function send(address account, uint amount) public payable returns (bool) {
    return account.send(amount);
}

function() public payable {
}

}