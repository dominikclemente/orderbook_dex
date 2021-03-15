pragma solidity >=0.6.0 < 0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/math/SafeMath.sol";

contract Wallet {
    using SafeMath for uint256;
    struct Token {
        bytes32 ticker;
        address tokenAddress;
    }

    mapping(bytes32 => Token) public tokenMapping;
    bytes32[] public tokenList;

    mapping(address => mapping(bytes32 => uint256)) public balances;

    function addToken(bytes32 ticker, address tokenAddress) external {
        tokenMapping[ticker] = Token(ticker, tokenAddress);
    }

    function deposit(uint amount, bytes32 ticker) external payable{

    }

    function withdraw(uint amount, bytes32 ticker) external {
        require(balances[msg.sender][ticker] >= amount, "You do not have enough balance to withdraw this amount.");
        balances[msg.sender][ticker] = balances[msg.sender][ticker].sub(amount);
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender, amount);
    }
}