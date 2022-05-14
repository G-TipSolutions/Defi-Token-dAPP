const RWD = artifacts.require('RWD')
const Tether = artifacts.require('Tether')
const DecentralBank = artifacts.require('DecentralBank')

require('chai')
.use(require('chai-as-promised'))
.should()

contract('DecentralBank', ([owner, customer]) => {
    let tether, rwd, decentralBank

    function tokens(number) {
        return web3.utils.toWei(number, 'ether')
    }

    before(async () => {
        // Load Contracts
        tether = await Tether.new()
        rwd = await RWD.new()
        decentralBank = await DecentralBank.new(rwd.address, tether.address)

        // Transfer all tokens to DecentralBank (1 million)
        await rwd.transfer(decentralBank.address, tokens('1000000'))
        
        // Transfer 100 mock Tethers to Customer
        await tether.transfer(customer, tokens('100000000000000'), {from: owner})
    })
    

    describe('Mock Tether Deployment', async () => {
        it('matches name successfully', async () => {
            const name = await tether.name()
            assert.equal(name, 'Mock Tether Token') 
        })
    })

    describe('Reward Token Deployment', async () => {
        it('matches name successfully', async () => {
            const name = await rwd.name()
            assert.equal(name, 'Reward Token') 
        })
    })

    describe('Decentral Bank Deployment', async () => {
        it('matches name successfully', async () => {
            const name = await decentralBank.name()
            assert.equal(name, 'Decentral Bank') 
        })
    })
})
