pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract transfer_token is Ownable {
    struct Transfer {
        address contract_; //Erc20 token address
        address to_; //receiving account
        uint256 amount_; // number of token transfer
        bool check; //  if transfer was sucessfull
    }

    mapping(address => uint256[]) public transactionIndexesToSender;
    // owner can create several transaction from sender address

    Transfer[] public transactions;

    address public owner;

    mapping(bytes32 => address) public tokens;
    //list of all suported token to transfer

    ERC20 public ERC20Interface;

    event TransferSuccessful(
        address indexed from_,
        address indexed to_,
        uint256 amount_
    );
    //if transfer token is sucessfull

    event TransferFailed(
        address indexed from_,
        address indexed to_,
        uint256 amount_
    );

    //if transfer token is unsecessfull

    constructor() public {
        owner = msg.sender;
    }

    // constructor mention that msg.sender is owner

    function addToken(bytes32 symbol_, address address_)
        public
        onlyOwner
        returns (bool)
    {
        tokens[symbol_] = address_;

        return true;
    }

    // adding address to token that we are sending by token symbol

    function transferTokens(
        bytes32 symbol_,
        address to_,
        uint256 amount_
    ) public {
        require(tokens[symbol_] != 0x0);
        require(amount_ > 0);
        // amount should be greater tahn 0 and the token should start with 0x to be valid token
        address contract_ = tokens[symbol_];
        address from_ = msg.sender;

        uint256 transactionId = transactions.push(
            Transfer({
                contract_: contract_,
                to_: to_,
                amount_: amount_,
                check: true
            })
        );
    }

    function withdraw(address beneficiary) public payable onlyOwner {
        beneficiary.transfer(address(this).balance);
    }
    //the beneficiary can withdraw all the money transfer
}
