import brownie
from brownie import accounts, wallet

def main():


    #testing adding/removing signers
    
    # signers = [accounts[0], accounts[1]]
    # w = wallet.deploy(signers, {"from": accounts[0]})
    # for i in range(3):
    #     try:
    #         print(w.get_signer(i))
    #     except:
    #         pass

    # to = w.address
    # data = "0x38e96b160000000000000000000000000063046686E46Dc6F15918b61AE2B121458534a5"
    # value = 0
    # w.propose((to, data, value), {"from": accounts[0]})

    # w.approve_tx(1, {"from": accounts[1]})
    # w.execute_tx(1, {"from": accounts[0]})
    # for i in range(3):
    #     try:
    #         print(w.get_signer(i))
    #     except:
    #         pass
    
    # w.propose((accounts[0], b"", "1 ether"), {"from": accounts[2]})

    # to = w.address
    # data = "0x3d7c6ded0000000000000000000000000063046686E46Dc6F15918b61AE2B121458534a5"
    # value = 0

    # w.propose((w.address, data, value), {"from": accounts[0]})
    # w.approve_tx(3, {"from": accounts[1]})

    # w.execute_tx(3, {"from": accounts[0]})
    # for i in range(3):
    #     try:
    #         print(w.get_signer(i))
    #     except:
    #         pass


    #simple transfer test

    # signers = [accounts[0], accounts[1]]
    # w = wallet.deploy(signers, {"from": accounts[0]})

    # print(w.balance())

    # accounts[0].transfer(w.address, "1 ether")

    # print(w.balance())

    # to = accounts[3]
    # data = b""
    # value = "1 ether"
    
    # w.propose((to, data, value), {"from": accounts[0]})

    # w.approve_tx(1, {"from": accounts[1]})

    # print(to.balance())
    
    # w.execute_tx(1, {"from": accounts[0]})
    
    # print(w.balance())
