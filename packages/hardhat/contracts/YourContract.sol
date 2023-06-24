// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract YourContract is Ownable {

    event Received(address from, uint amount);
    event Distributed(address to, uint amount);

    // This function allows anyone to deposit funds to the contract
    function depositFunds() external payable {
        require(msg.value > 0, "Must send some value");
        emit Received(msg.sender, msg.value);
    }

    // This function allows the contract owner to distribute funds to a specified address
    function distributeFunds(address payable recipient, uint amount) external onlyOwner {
        require(address(this).balance >= amount, "Not enough funds in contract");
        recipient.transfer(amount);
        emit Distributed(recipient, amount);
    }

    // Returns the balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // To support receiving ETH directly to the contract
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable {}
}
