// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    address public admin;
    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    event VoteCasted(address voter, string candidate);

    constructor(string[] memory _candidateNames) {
        admin = msg.sender;
        for (uint256 i = 0; i < _candidateNames.length; i++) {
            candidates.push(Candidate({name: _candidateNames[i], voteCount: 0}));
        }
    }

    function vote(uint256 _candidateIndex) external {
        require(!hasVoted[msg.sender], "You have already voted and you cannot vote again");
        require(_candidateIndex < candidates.length, "Invalid candidate index, please enter a valid one");

        hasVoted[msg.sender] = true;
        candidates[_candidateIndex].voteCount++;

        emit VoteCasted(msg.sender, candidates[_candidateIndex].name);
    }

    function getWinner() external view returns (string memory) {
        require(candidates.length > 0, "No candidates available");
        uint256 winningVoteCount = 0;
        uint256 winnerIndex = 0;

        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerIndex = i;
            }
        }
        return candidates[winnerIndex].name;
    }
}
