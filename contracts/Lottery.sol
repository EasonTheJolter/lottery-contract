// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

contract Lottery {
    address public owner;
    address payable[] public players;
    address[] public winners;
    uint public lotteryId;

    uint public ticketPrice;
    uint public handlingFeeRatio; // 1 ether = 100%
    address public cashier; // to receive handling fee
    bool enabled;

    constructor(uint _ticketPrice, uint _handlingFeeRatio, address _cashier) {
        owner = msg.sender;
        lotteryId = 0;
        enabled = true;

        ticketPrice = _ticketPrice;
        handlingFeeRatio = _handlingFeeRatio;
        cashier = _cashier;
    }

    function getWinners() public view returns (address[] memory){
        return winners;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    function enter() public payable {
        require(enabled, "not enabled now");
        require(msg.value == ticketPrice, "sending amout is not equal to ticket price");

        // address of player entering lottery
        players.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function getLotteryId() public view returns(uint) {
        return lotteryId;
    }

    function pickWinner() public onlyOwner {
        require(players.length > 0, "Players array must not be empty");
        uint randomIndex = getRandomNumber() % players.length;
        uint handlingFee = address(this).balance * handlingFeeRatio / (1 ether);
        payable(cashier).transfer(handlingFee); // send handling feee
        players[randomIndex].transfer(address(this).balance); //  send LEFT balance to winner
        winners.push(players[randomIndex]);
        lotteryId++;

        // Clear the players array. ['player1', 'player2'] 👉 []
        players = new address payable[](0);
    }

    function setTicketPrice(uint _ticketPrice) public onlyOwner {
        pickWinner();
        ticketPrice = _ticketPrice;
    }

    function setHandlingFeeRatio(uint _handlingFeeRatio) public onlyOwner {
        handlingFeeRatio = _handlingFeeRatio;
    }

    function setCashier(address _cashier) public onlyOwner {
        cashier = _cashier;
    }

    function setEnabled(bool _enabled) public onlyOwner {
        enabled = _enabled;
    }

    function transferOwner(address _owner) public onlyOwner {
        owner = _owner;
    }

    modifier onlyOwner() {
      require(msg.sender == owner);
      _;
    }
}