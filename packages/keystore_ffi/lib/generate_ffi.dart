import 'dart:io';
import 'package:ffi_tool/c.dart';

void main() {
  generateFile(File('generated.dart'), library);
}

const library = Library(
  dynamicLibraryPath: 'libkeystore.so',
  elements: [
    Func(
      name: 'last_error_length',
      parameterTypes: [],
      returnType: 'int32',
    ),
    Func(
      name: 'error_message_utf8',
      parameterTypes: ['*utf8', 'int32'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_new',
      parameterTypes: [],
      returnType: '*void',
    ),
    Func(
      name: 'keystore_from_keyfile',
      parameterTypes: ['*utf8'],
      returnType: '*void',
    ),
    Func(
      name: 'keystore_destroy',
      parameterTypes: ['*void'],
      returnType: 'void',
    ),
    Func(
      name: 'keystore_status',
      parameterTypes: ['*void'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_generate',
      parameterTypes: ['*void', '*utf8'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_import',
      parameterTypes: ['*void', '*utf8', '*utf8'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_unlock',
      parameterTypes: ['*void', '*utf8'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_lock',
      parameterTypes: ['*void'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_paper_backup',
      parameterTypes: ['*void'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_set_paper_backup',
      parameterTypes: ['*void'],
      returnType: 'int32',
    ),
    Func(
      name: 'keystore_phrase',
      parameterTypes: ['*void', '*utf8'],
      returnType: '*utf8',
    ),
    Func(
      name: 'phrase_destroy',
      parameterTypes: ['*utf8'],
      returnType: 'void',
    ),
    Func(
      name: 'keystore_account',
      parameterTypes: ['*void'],
      returnType: '*AccountStruct',
    ),
    Func(
      name: 'account_destroy',
      parameterTypes: ['*AccountStruct'],
      returnType: 'void',
    ),
    Struct(
      name: 'AccountStruct',
      fields: [
        Field(
          name: 'name',
          type: '*utf8',
        ),
        Field(
          name: 'ss58',
          type: '*utf8',
        ),
        Field(
          name: 'identicon_ptr',
          type: '*char',
        ),
        Field(
          name: 'identicon_len',
          type: 'int32',
        ),
        Field(
          name: 'qrcode_ptr',
          type: '*char',
        ),
        Field(
          name: 'qrcode_len',
          type: 'int32',
        ),
      ],
    ),
  ],
);
