// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;



import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BSKToken is ERC20("BSKToken", "BSK"){
    address public owner;


  constructor(){
    owner=msg.sender;
    _mint(msg.sender, 200000e18);
  }

function mint(uint _amount ) external{
    require(msg.sender==owner, "You are not authorize to mint new Token");

    _mint(msg.sender, _amount * 1e18);
}
}
