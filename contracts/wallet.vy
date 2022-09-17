# @version 0.3.6

struct Transaction:
    to: address
    data: Bytes[1024]
    value: uint256

sig_count: uint256

signers: DynArray[address, 10]

pending_transactions: HashMap[uint256, Transaction]

approvals: HashMap[uint256, uint256]

already_approved: HashMap[uint256, HashMap[address, bool]]

tx_id: uint256


event proposal:
      id: indexed(uint256)
      _tx: Transaction
      

@external
def __init__(initial_signers: DynArray[address,10], _sig_count: uint256):
    self.tx_id = 1
    self.sig_count = _sig_count
    for i in range(10):
        if (i >= len(initial_signers)):
           break
        self.signers.append(initial_signers[i])

@payable
@external
def __default__():
    pass
 
@internal
def _is_approved(id: uint256) -> bool:
    if (self.approvals[id] >= self.sig_count):
       return True
    else:
       return False

@internal
def _is_signer(a: address) -> bool:
    assert a != ZERO_ADDRESS
    if (a in self.signers):
       return True
    else:
       return False

@external
def propose(_tx: Transaction):
    assert self._is_signer(msg.sender)
    id: uint256 = self.tx_id
    self.pending_transactions[id] = _tx
    self.approvals[id] += 1
    self.already_approved[id][msg.sender] = True
    log proposal(id, _tx)
    self.tx_id += 1
    
@external
def revoke_proposal(_id: uint256):
    assert self._is_signer(msg.sender)
    self.pending_transactions[_id] = empty(Transaction)
    self.approvals[_id] = 0
    self.already_approved[_id][msg.sender] = False

@external
def approve_tx(_id: uint256):
    assert self._is_signer(msg.sender)
    assert not self.already_approved[_id][msg.sender]
    self.approvals[_id] += 1
    self.already_approved[_id][msg.sender] = True

@external
def unapprove_tx(_id: uint256):
    assert self._is_signer(msg.sender)
    assert self.already_approved[_id][msg.sender]
    self.approvals[_id] -= 1
    self.already_approved[_id][msg.sender] = False


@external
def execute_tx(_id: uint256):
    assert self._is_approved(_id)
    _tx: Transaction = self.pending_transactions[_id]
    r: Bytes[32] = raw_call(_tx.to, _tx.data, max_outsize=32, value=_tx.value, revert_on_failure=True)
    self.approvals[_id] = 0
    self.pending_transactions[_id] = empty(Transaction)
    for signer in self.signers:
        self.already_approved[_id][signer] = False

@external
def add_signer(new_signer: address):
    assert msg.sender == self
    assert not self._is_signer(new_signer)
    self.signers.append(new_signer)

@external
def remove_signer(signer: address):
    assert msg.sender == self
    for i in range(10):
        if (i >= len(self.signers)):
           break
        if (signer == self.signers[i]):
           self.signers[i] = ZERO_ADDRESS
           break

@external
def change_sig_count(new_count: uint256):
    assert msg.sender == self
    self.sig_count = new_count



@external
def onERC721Received(_op: address, _from: address, _id: uint256, _data: Bytes[32]) -> Bytes[4]:
    return method_id("onERC721Received(address,address,uint256,bytes)")


@external
@view
def get_signer(i: uint256) -> address:
    return self.signers[i]
           




    




            


    
    

    
