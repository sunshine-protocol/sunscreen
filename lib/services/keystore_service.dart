import 'package:keystore/keystore.dart' as keystore;

// A hack to make a type alias
mixin ToAlias {}

class KeystoreService = keystore.Keystore with ToAlias;
