// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0 ;

contract Auction {
    address public owner;
    uint public startBlock;
    uint public endBlock;
    string public ipfsHash;
    
    enum State { Started, Running, Ended, Canceled }
    State public auctionState;
    
    uint public highestBindingBid;
    address payable public highestBidder;
    
    mapping(address => uint) public bids;
    uint bidIncrement;

    constructor(
        address _owner,
        uint _startBlock,
        uint _endBlock,
        string memory _ipfsHash,
        uint _bidIncrement
    ) {
        owner = _owner;
        startBlock = _startBlock;
        endBlock = _endBlock;
        ipfsHash = _ipfsHash;
        bidIncrement = _bidIncrement;
        auctionState = State.Running;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier notOwner() {
        require(msg.sender != owner);
        _;
    }
    
    modifier afterStart() {
        require(block.number >= startBlock);
        _;
    }
    
    modifier beforeEnd() {
        require(block.number <= endBlock);
        _;
    }

    function cancelAuction() public onlyOwner {
        auctionState = State.Canceled;
    }

    function placeBid() public payable notOwner afterStart beforeEnd {
        require(auctionState == State.Running);
        require(msg.value >= 0.01 ether);

        uint currentBid = bids[msg.sender] + msg.value;
        require(currentBid > highestBindingBid);

        bids[msg.sender] = currentBid;

        if (currentBid <= bids[highestBidder]) {
            highestBindingBid = min(currentBid + bidIncrement, bids[highestBidder]);
        } else {
            highestBindingBid = min(currentBid, bids[highestBidder] + bidIncrement);
            highestBidder = payable(msg.sender);
        }
    }

   function finalizeAuction() public {
    require(auctionState == State.Canceled || block.number > endBlock);
    require(msg.sender == owner || bids[msg.sender] > 0);

    address payable recipient;
    uint value;

    if (auctionState == State.Canceled) {
        recipient = payable(msg.sender);
        value = bids[msg.sender];
    } else {
        if (msg.sender == owner) {
            recipient = payable(owner);
            value = highestBindingBid;
        } else {
            if (msg.sender == highestBidder) {
                recipient = highestBidder;
                value = bids[highestBidder] - highestBindingBid;
            } else {
                recipient = payable(msg.sender);
                value = bids[msg.sender];
            }
        }
    }
    bids[recipient] = 0;
    recipient.transfer(value);
}

    function min(uint a, uint b) private pure returns (uint) {
        return a <= b ? a : b;
    }
}
