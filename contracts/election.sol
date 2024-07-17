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

    struct Candidate{
        uint tdp;
        uint ycp;
        uint jsp;
        uint bjp;
        uint cng;
        uint nota;
    }
    
    Candidate[2] public candidate;

    function mlaVote(string memory str) public {
        if (keccak256(abi.encodePacked("tdp")) == keccak256(abi.encodePacked(str))) {
            candidate[0].tdp++;
        }else if(keccak256(abi.encodePacked("ycp")) == keccak256(abi.encodePacked(str))){
            candidate[0].ycp++;
        }else if(keccak256(abi.encodePacked("jsp")) == keccak256(abi.encodePacked(str))){
            candidate[0].jsp++;
        }else if(keccak256(abi.encodePacked("bjp")) == keccak256(abi.encodePacked(str))){
            candidate[0].bjp++;
        }else if(keccak256(abi.encodePacked("cng")) == keccak256(abi.encodePacked(str))){
            candidate[0].cng++;
        }else{
            candidate[0].nota++;
        }
    }

    function mpVote(string memory str) public {
        if (keccak256(abi.encodePacked("tdp")) == keccak256(abi.encodePacked(str))) {
            candidate[1].tdp++;
        }else if(keccak256(abi.encodePacked("ycp")) == keccak256(abi.encodePacked(str))){
            candidate[1].ycp++;
        }else if(keccak256(abi.encodePacked("jsp")) == keccak256(abi.encodePacked(str))){
            candidate[1].jsp++;
        }else if(keccak256(abi.encodePacked("bjp")) == keccak256(abi.encodePacked(str))){
            candidate[1].bjp++;
        }else if(keccak256(abi.encodePacked("cng")) == keccak256(abi.encodePacked(str))){
            candidate[1].cng++;
        }else{
            candidate[1].nota++;
        }
    }

    function getMla() public view returns(Candidate memory){
        return candidate[0];
    }

    function getMp() public view returns(Candidate memory){
        return candidate[1];
    }

}