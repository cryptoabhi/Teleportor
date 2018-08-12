pragma solidity >=0.4.22 <0.6.0;

import "./ERC20.sol";


/** @title Teleportor 
 * 
 * @dev Implementation of the Teleportor contract.
 * It deadlocks ERC20 tockens and emit events on success.
 */
contract Teleportor {
    event Opened();
    event Teleport(uint amount, string note);
    event Closed();

    bool public closed = false;
    ERC20 public erc20Contract;
    uint public minimumAmount;

    /** @dev Construction of the ETH Teleportor contract.
     * @param _erc20Contract The address of the ERC20 contract to attract tockens from.
     * @param _minimumAmount the smallest amount Teleportor can attract.
     */
    constructor(address _erc20Contract, uint _minimumAmount) public {
        erc20Contract = ERC20(_erc20Contract);
        minimumAmount = _minimumAmount;
        emit Opened();
    }

    /** @dev It closes the Teleportor
     */
    function close() public {
        require(!closed, "This Teleportor contract has expired.");
        closed = true;
        emit Closed();
    }

    /** @dev teleport attracts tokens and emit Teleport event
     * @param note Teleport event note.
     */
    function teleport(string memory note) public {
        uint amount = attract();
        emit Teleport(amount, note);
    }

    function attract() private returns (uint amount){
        require(!closed, "Teleportor closed");
        uint balance = erc20Contract.balanceOf(msg.sender);
        uint allowed = erc20Contract.allowance(msg.sender, address(this));
        require(allowed >= minimumAmount, "less than minimum amount");
        require(balance == allowed, "Teleportor must attract all your tokens");
        require(erc20Contract.transferFrom(msg.sender, address(this), balance), "Teleportor can't attract your tokens");
        return balance;
    }
}
