// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import './RWD.sol';
import './Tether.sol';

contract DecentralBank {
  address public owner = msg.sender;
  string public name = 'Decentral Bank';
  Tether public tether;
  RWD public rwd;

constructor(RWD _rwd,Tether _tether) {
  rwd = _rwd;
  tether = _tether;
}
}