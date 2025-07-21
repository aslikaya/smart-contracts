// SPDX-License-Identifier: MIT
pragma solidity > 0.8.18;

contract UserOperations {

    struct User{
        string name;
        uint8 age;
        string email;
        uint256 registrationTimestamp;
    }

    User[] public users;
    mapping (string => User) emailToUser;
    mapping (string => bool) registeredEmails;
    mapping (string => uint256) emailToIndex;

    function register(string memory _name, uint8 _age, string memory _email) public {
    require(!registeredEmails[_email], "User already registered!");
        User memory user = User(_name, _age, _email, block.timestamp);
        users.push(user);
        emailToUser[_email] = user;
        registeredEmails[_email] = true;
        emailToIndex[_email] = users.length - 1;
    }

    function updateProfile(string memory newName, uint8 newAge, string memory newEmail, string memory oldEmail) public {
        require(registeredEmails[oldEmail], "User does not exist!");
        User memory user = emailToUser[oldEmail];
        user.name = newName;
        user.age = newAge;
        if(keccak256(bytes(newEmail)) != keccak256(bytes(oldEmail))) {
            user.email = newEmail;
            emailToUser[newEmail] = user;
            emailToIndex[newEmail] = emailToIndex[oldEmail];
            delete emailToUser[oldEmail];
            registeredEmails[oldEmail] = false;
            registeredEmails[newEmail] = true;
        } else {
            emailToUser[oldEmail] = user;
        }
        
        users[emailToIndex[oldEmail]] = user;

    }

    function getProfile(string calldata email) public view returns(User memory){
        return emailToUser[email];
    }

}