# Blockchain-based Decentralized Talent Discovery Platform

This project implements a decentralized talent discovery platform using Clarity smart contracts on the Stacks blockchain. The platform allows talented individuals to showcase their skills, create portfolio NFTs, and enables recruiters to discover and verify talent.

## Features

1. User Profiles
    - Create and manage user profiles
    - Add and endorse skills

2. Portfolio NFTs
    - Create portfolio items as non-fungible tokens (NFTs)
    - Transfer ownership of portfolio items

3. Interview Scheduling
    - Schedule interviews between recruiters and candidates
    - Update interview status

## Smart Contract Functions

### Profile Management

- `create-profile`: Create a new user profile
- `add-skill`: Add a skill to a user's profile
- `endorse-skill`: Endorse a skill for a specific user

### Portfolio Management

- `create-portfolio`: Create a new portfolio item as an NFT
- `transfer`: Transfer ownership of a portfolio NFT
- `get-owner`: Get the owner of a portfolio NFT
- `get-last-token-id`: Get the ID of the last minted portfolio NFT

### Interview Management

- `schedule-interview`: Schedule an interview between a recruiter and a candidate
- `update-interview-status`: Update the status of a scheduled interview

### Read-only Functions

- `get-profile`: Retrieve a user's profile information
- `get-portfolio`: Retrieve a portfolio item's information
- `get-interview`: Retrieve interview details
- `get-token-uri`: Get the token URI for a portfolio NFT (returns none in this implementation)

## Testing

The project includes a comprehensive test suite that covers the main functionalities of the smart contract. To run the tests, use the Clarinet testing framework.

## Next Steps

1. Implement a frontend application to interact with the smart contract
2. Add more advanced search and filtering capabilities for talent discovery
3. Implement a reputation system based on endorsements and successful collaborations
4. Integrate with decentralized identity solutions for enhanced verification
5. Implement privacy controls for user data and portfolio items

## License

This project is licensed under the MIT License.

