// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Election {

    struct Voter {
        string name;
        uint age;
        string ano;
        string password;
        bool voted;
    }
    
    mapping (string => Voter) public voters;
    uint public voterCount;

    constructor() {
        voterCount = 0; 
    }

    function getVoterCount() public view returns(uint){
        return voterCount;
    }

    modifier validVoter(string memory _vid, uint _age) {
        require(_age > 18, "Age doesn't meet the requirements to vote");
        require(bytes(voters[_vid].name).length == 0, "Voter already exists");
        _;
    }   

    function addVoter(string memory _name, uint _age, string memory _vid, string memory _ano, string memory _password) public validVoter(_vid, _age) {
        voters[_vid].name = _name;
        voters[_vid].age = _age;
        voters[_vid].ano = _ano;
        voters[_vid].password = _password;
        voters[_vid].voted = false;
        voterCount++;
    }

    function getVoterDetails(string memory _vid) public view returns(Voter memory){
        return voters[_vid];
    }

    modifier checkVoted(string memory _vid) {
        require(bytes(voters[_vid].name).length != 0, "Voter does not exist");
        require(voters[_vid].voted == false, "Already voted");
        _;
    }


    struct Candidate {
        string partyName;
        string candidateName;
        uint voteCount;
    }

    mapping(string => mapping(string => mapping(string => Candidate))) public parties;

    // function getParties() public view returns(mapping(string => mapping(string => mapping(string => Candidate)))){
    //     return parties;
    // }

    function isParty(string memory _symbol, string memory location, string memory position) public view returns(bool) {
        return (bytes(parties[location][position][_symbol].partyName).length != 0);
    }

    function addParty(string memory _name, string memory _symbol, string memory _partyName, string memory location, string memory position) public{
        if(isParty( _symbol, location, position))
            return;
        parties[location][position][_symbol].candidateName = _name;
        parties[location][position][_symbol].partyName = _partyName;        
    }

    function getVoteCount(string memory _symbol, string memory location, string memory position) public view returns(uint) {
        return parties[location][position][_symbol].voteCount;
    }

    function castVote(string memory _vid, string memory _symbol, string memory location, string memory position) public checkVoted(_vid) {
        require(isParty(_symbol, location, position), "Party does not exist");
        voters[_vid].voted = true;
        parties[location][position][_symbol].voteCount++;
    }
}
