[TOC]

# Sample Hardhat-Foundry Project

this project integrated hardhat and foundry as a template to fastly create a project.

## Getting Started

```
npm install
forge install
```

## Config `.env`

```
cp .env.example .env
```

replace configs in `.env` file

## Run test

- with foundry

```
forge test
```

- with hardhat

```
npx hardhat test
```

## Notice

Whenever you install new libraries using Foundry, make sure to update your remappings.txt file by running forge `remappings > remappings.txt`

[Remapping dependencies](https://book.getfoundry.sh/projects/dependencies#remapping-dependencies)

```
forge remappings > remappings.txt
```
