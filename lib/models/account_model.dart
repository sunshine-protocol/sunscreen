enum AccountState {
  unknown,
  noAccount,
  locked,
  unlocked,
}

class Account {
  const Account({
    this.firstName,
    this.lastName,
    this.address,
    this.state,
  });
  String get name => '$firstName $lastName';
  final String firstName;
  final String lastName;
  final String address;
  final AccountState state;
}

class AccountBackup {
  const AccountBackup({
    this.account,
    this.phrase,
  });
  final String phrase;
  final Account account;
}

class AccountDetails {
  const AccountDetails({
    this.firstName,
    this.lastName,
    this.password,
  });
  final String firstName;
  final String lastName;
  final String password;

  AccountDetails copyWith({
    String firstName,
    String lastName,
    String password,
  }) {
    return AccountDetails(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.lastName,
    );
  }
}
