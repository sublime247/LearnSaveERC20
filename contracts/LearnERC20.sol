// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LearnERC20{
    address public owner;
    address public  bskTokenAddress;

    mapping (address => uint256) balances;

    constructor(address _tokenAddress){
        owner = msg.sender;
        bskTokenAddress=_tokenAddress;
    }

    modifier Onlyowner {
        require(owner==msg.sender, "You are not Authorize");
        _;
    }

    // event

    event DepositSuccesful(address indexed user,   uint256 _tokenAmount);
    event WithDrawalSuccessful(address indexed user, uint256 _tokenAmount);
    event TransferSuccessful(address indexed user, address indexed to,  uint _tokenAmount);

  
    function depositToken(uint256 _tokenAmount) external {
      require(_tokenAmount>0, "Can't deposit a zero Token");
      uint256 _userTokenbalance = IERC20(bskTokenAddress).balanceOf(msg.sender);
      require(_userTokenbalance>=_tokenAmount, "Insufficient Tokenbalance");

     IERC20(bskTokenAddress).transferFrom(msg.sender, address(this), _tokenAmount);
      balances[msg.sender]+=_tokenAmount;

    emit DepositSuccesful(msg.sender,  _tokenAmount);
    }


    function withdrawToken(uint256 _tokenAmount) external {
        require(msg.sender!=address(0), "zero Address detected");
        require(_tokenAmount!=0, "can't withdraw a zero amount");
        uint _userbalance= balances[msg.sender];
        require(_userbalance>=_tokenAmount, "You can't withdraw more than you have");

        balances[msg.sender]-=_tokenAmount;

        IERC20(bskTokenAddress).transfer(msg.sender, _tokenAmount);
        emit WithDrawalSuccessful(msg.sender, _tokenAmount);
    }



    function transferToken(uint256 _tokenAmount, address _to) external {
        require(msg.sender!=address(0), "zero Address detected");
        require(_tokenAmount!=0, "can't withdraw a zero amount");
        require(_to!=address(0), "Can't transfer to address zero!!");

        balances[msg.sender]-=_tokenAmount;

        IERC20(bskTokenAddress).transfer(_to, _tokenAmount); 

      emit  TransferSuccessful(msg.sender, _to,  _tokenAmount); 
    } 



  function depositForAnotheruserWithin(uint256 _tokenAmount, address _to) external {
      
      require(_tokenAmount!=0, "Can't deposit zero balances");
      require(_to !=address(0), "Can't deposit to an address zero");
      require(balances[msg.sender]>=_tokenAmount, "You don't have enough token");

      balances[msg.sender]-=_tokenAmount;
      balances[_to] += _tokenAmount;

   }

   function depositForAnotherUser(uint256 _tokenAmount, address _to) external{
     require(_tokenAmount!=0, "Can't deposit zero balances");

      require(_to !=address(0), "Can't deposit to an address zero");

      uint256 _userTokenbalance =  IERC20(bskTokenAddress).balanceOf(msg.sender);

      require(_userTokenbalance>=_tokenAmount, "You can't deposit more than you have");

     IERC20(bskTokenAddress).transferFrom(msg.sender, address(this), _tokenAmount);

      balances[_to]+=_tokenAmount;
   }

   function getMybalance() external view returns(uint256){
    return balances[msg.sender];
   }

   function getAnybalance(address _user) external view  Onlyowner returns(uint256){
    return balances[_user];
   }

   function getContractbalance() external view Onlyowner returns(uint256){
    return  IERC20(bskTokenAddress).balanceOf(address(this));
   }

   function ownerWithdraw(uint256 _amt) external Onlyowner{
    require(IERC20(bskTokenAddress).balanceOf(address(this))>0, "The contract token has finished");
     IERC20(bskTokenAddress).transfer(owner, _amt);
   }
}

