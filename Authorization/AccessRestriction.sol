// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessRestriction {
    /**
     * @dev public variables in global, visible to everyone
     */
    address public treasury = msg.sender;
    uint256 public creationTime = block.timestamp;
    uint256 public minimumDonation;
    /**
     * @dev private visibility of winner address
     */
    address private winner;

    /**********Modifier Blocks********/
    modifier onlyBefore(uint256 _time) {
        require(block.timestamp < _time);
        _;
    }

    modifier onlyAfter(uint256 _time) {
        require(block.timestamp > _time);
        _;
    }

    modifier isHigherDonation() {
        require(msg.value > minimumDonation, "Please send higher amount");
        winner = msg.sender;
        minimumDonation = msg.value;
        _;
    }

    function sendDonation()
        external
        payable
        onlyBefore(creationTime + 1 weeks)
        isHigherDonation
    {
        payable(treasury).transfer(msg.value);
    }

    function revealHighestDonor()
        external
        view
        onlyAfter(creationTime + 1 weeks)
        returns (address)
    {
        return winner;
    }
}
