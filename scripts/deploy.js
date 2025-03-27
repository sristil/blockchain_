const hre = require("hardhat");

async function main() {
    const VotingSystem = await hre.ethers.getContractFactory("VotingSystem");
    const contract = await VotingSystem.deploy(["Alice", "Bob", "Charlie"]);
    await contract.deployed();
    console.log(`Contract deployed to: ${contract.address}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
