class Account {
  const Account({
    this.firstName,
    this.lastName,
    this.address,
  });
  String get name => '$firstName $lastName';
  final String firstName;
  final String lastName;
  final String address;
}
