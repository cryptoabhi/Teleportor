pragma solidity >=0.4.22 <0.6.0;

import "./Teleportor.sol";

contract TeleportorOperator is Teleportor {

    function accountIsValid(string memory account) public pure returns (bool){
        bytes memory b = bytes(account);    
        if (b.length != 12) return false;

        for(uint i = 0; i<b.length; i++){
            bytes1 char = b[i];

            // a-z && 1-5 && .
            if(!(char >= 0x61 && char <= 0x7A) && 
               !(char >= 0x31 && char <= 0x35) && 
               !(char == 0x2E)) 
            return  false;
        }
        
        return true;
    }

    constructor(address _erc20Contract, uint _minimumAmount) public 
    Teleportor(_erc20Contract, _minimumAmount)
    {
    }

    /** @dev It deadlocks your tokens and emit an event with amount and EOS account.
     */
    function teleport(string memory eosAccount) public {
        require(accountIsValid(eosAccount), "invalid EOS account");
        super.teleport(eosAccount);
    }
}
