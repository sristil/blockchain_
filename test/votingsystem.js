const { expect } = require("chai");

describe("VotingSystem", function () {
    it("Should deploy with candidates", async function () {
        const VotingSystem = await ethers.getContractFactory("VotingSystem");
        const contract = await VotingSystem.deploy(["Alice", "Bob"]);
        await contract.deployed();

        expect(await contract.candidates(0)).to.have.property("name", "Alice");
        expect(await contract.candidates(1)).to.have.property("name", "Bob");
    });

    it("Should allow voting and track votes", async function () {
        const [owner, voter1] = await ethers.getSigners();
        const VotingSystem = await ethers.getContractFactory("VotingSystem");
        const contract = await VotingSystem.deploy(["Alice", "Bob"]);
        await contract.deployed();

        await contract.connect(voter1).vote(0);
        const candidate = await contract.candidates(0);
        expect(candidate.voteCount).to.equal(1);
    });
});
