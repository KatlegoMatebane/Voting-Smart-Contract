// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract VotingSystem {
    address private owner;
    
    // Define a struct to represent a voter
    struct Voter {
        bool isRegistered;
        bool hasVoted;
    }
    
    // Mapping to store registered voters
    mapping(address => Voter) private voters;
    
    // Mapping to store vote counts for each option
    mapping(bytes32 => uint256) private voteCounts;

    // Event to log when a new voter is registered
    event VoterRegistered(address indexed voterAddress);

    // Event to log when a vote is cast
    event VoteCast(address indexed voterAddress, bytes32 option);

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }
    
    // Modifier to ensure that only the contract owner can execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    // Modifier to ensure that only registered voters can interact with voting-related functions
    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].isRegistered, "Only registered voters can use this function");
        _;
    }

    // Function for the contract owner to register new voters
    function registerVoter(address _voterAddress) private onlyOwner {
        require(!voters[_voterAddress].isRegistered, "Voter is already registered");
        voters[_voterAddress].isRegistered = true;
        emit VoterRegistered(_voterAddress);
    }

    // Function for registered voters to cast their votes
    function castVote(bytes32 _option) private onlyRegisteredVoter {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        voteCounts[_option]++;
        voters[msg.sender].hasVoted = true;
        emit VoteCast(msg.sender, _option);
    }

    // Function to retrieve the current vote count for an option
    function getVoteCount(bytes32 _option) private view returns (uint256) {
        return voteCounts[_option];
    }
}
