// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

 import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
 import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
   
contract Wallet{
    
    using SafeMath for uint;

    struct Token{
        bytes32 ticker;
        address tokenAddress;
    }

    mapping(bytes32 => Token ) public tokenMapping;
    bytes32[] public tokenList;
    mapping(address => mapping(bytes32 =>uint)) public balances;


    function addToken(bytes32 ticker,address tokenAddress) public{
        tokenMapping[ticker]=Token(ticker,tokenAddress);
        tokenList.push(ticker);
    }

    function deposit(uint units,bytes32 ticker) external{

        balances[msg.sender][ticker]+=units;
    }

    
    function withdraw(uint units,bytes32 ticker) external{

        require(balances[msg.sender][ticker]>=units,"Balance not sufficient");
        require(tokenMapping[ticker].tokenAddress!=address(0));

        balances[msg.sender][ticker]=balances[msg.sender][ticker].sub(units);
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender, units);
       }



}