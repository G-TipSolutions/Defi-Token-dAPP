//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Tether {
    string public name = 'Mock Tether Token';
    string public symbol = 'mUSDT';
    uint256 public totalSupply =  1000000000000000000; // 1 million tokens
    uint8 public decimals = 18;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint _value

    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint _value

    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // require that the value is greater or equal for transfer
        require(balanceOf[msg.sender] >= _value);
        // transfer the amount and subtract the balance
        balanceOf[msg.sender] -= _value;        
        // add the balance
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // require that the value is smaller or equal to value before transfer
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        // add the balance
        balanceOf[msg.sender] += _value;        
        // subtract the balance from transferFrom
        balanceOf[_to] -= _value;
        allowance[msg.sender][_from] -= _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
// // event example....
// // Declare event and then emit even Example

// contract LearnEvents { 
//     event NewTrade(
//         uint256 indexed date;
//         address from;
//         addres to;
//         uint amount;
//     )

//     function trade(address to, uint amount) external {
//         //outside consumer can see the event through web3js
//         //blocktimestamp is a global variable that gives the current timestamp
//         emit NewTrade(block.timestamp, to, amount);
//     }
// }