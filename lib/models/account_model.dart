enum AccountState {
  unknown,
  noAccount,
  locked,
  unlocked,
}

class Account {
  const Account({
    this.uid,
    this.state,
  });
  final String uid;
  final AccountState state;
}
