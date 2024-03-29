// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {EventNFT} from "https://github.com/navdiya-nikunj/Solidity-Contracts/blob/main/event.sol";
contract OrganizationContract {
    // Structure to store social channels and description
    struct Description {
        string discord;
        string linkedin;
        string twitter;
        string description;
    }
    
    // Structure to store event details
    struct Event {
        string eventName;
        string eventDescription;
        uint256 dateTime;
        uint256 numOfTickets;
        string venueLink;
        string nftURI;
        address eventContractAddress;
    }
    
    // Organization details
    string public organizationName;
    address public organizationAddress;
    Description public organizationDescription;
    mapping(address => Event) public events; // Mapping to store events by their id
    address[] public eventaddresses; // Array to store event ids
    
    // Constructor to initialize organization details
    constructor(string memory _name, address _address, string memory _discord, string memory _linkedin, string memory _twitter, string memory _desc) {
        organizationName = _name;
        organizationAddress = _address;
        organizationDescription = Description(_discord, _linkedin, _twitter, _desc);
    }
    
    // Function to get public storage stats
    function getStorageStats() public view returns (string memory, address, address[] memory) {
        return (organizationName, organizationAddress, eventaddresses);
    }
    
    // Function to create events
    function createEvent(string memory _eventName, string memory _eventDescription, uint256 _dateTime, uint256 _numOfTickets, string memory _venueLink, string memory _nftURI) public {
        // Check if caller is the deployer address
        
        // Deploy event contract
        EventNFT newEvent = new EventNFT(_eventName, _eventDescription, _dateTime, _numOfTickets, _venueLink, _nftURI);
        
        // Store event details

        events[address(newEvent)] = Event(_eventName, _eventDescription, _dateTime, _numOfTickets, _venueLink, _nftURI, address(newEvent));
        eventaddresses.push(address(newEvent));
    }
    
    // Function to get all event addresses
    function getEvents() public view returns (address[] memory) {
        return eventaddresses;
    }
    
    // Function to update organization profile
    function updateProfile(string memory _name, string memory _discord, string memory _linkedin, string memory _twitter, string memory _desc) public {
        organizationName = _name;
        organizationDescription = Description(_discord, _linkedin, _twitter, _desc);
    }
}
