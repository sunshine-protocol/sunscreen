/// bindings for `libsunshine`

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart' as ffi;

// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names
final DynamicLibrary _dl = _open();
/// Reference to the Dynamic Library, it should be only used for low-level access
final DynamicLibrary dl = _dl;
DynamicLibrary _open() {
  if (Platform.isAndroid) return DynamicLibrary.open('libsunshine.so');
  if (Platform.isIOS) return DynamicLibrary.executable();
  throw UnsupportedError('This platform is not supported.');
}

/// <p class="para-brief"> Approve a Submission using `SubmissionId` Returns the new total amount on that bounty after this operation</p>
int client_bounty_approve(
  int port,
  int submission_id,
) {
  return _client_bounty_approve(port, submission_id);
}
final _client_bounty_approve_Dart _client_bounty_approve = _dl.lookupFunction<_client_bounty_approve_C, _client_bounty_approve_Dart>('client_bounty_approve');
typedef _client_bounty_approve_C = Int32 Function(
  Int64 port,
  Uint64 submission_id,
);
typedef _client_bounty_approve_Dart = int Function(
  int port,
  int submission_id,
);

/// <p class="para-brief"> Contribute to a bounty. Returns the new total bounty amount</p>
int client_bounty_contribute(
  int port,
  int bounty_id,
  int amount,
) {
  return _client_bounty_contribute(port, bounty_id, amount);
}
final _client_bounty_contribute_Dart _client_bounty_contribute = _dl.lookupFunction<_client_bounty_contribute_C, _client_bounty_contribute_Dart>('client_bounty_contribute');
typedef _client_bounty_contribute_C = Int32 Function(
  Int64 port,
  Uint64 bounty_id,
  Uint64 amount,
);
typedef _client_bounty_contribute_Dart = int Function(
  int port,
  int bounty_id,
  int amount,
);

/// <p class="para-brief"> Get a bounty Information by using bounty Id Returns Cbor encoded `BountyInformation` as bytes</p>
int client_bounty_get(
  int port,
  int bounty_id,
) {
  return _client_bounty_get(port, bounty_id);
}
final _client_bounty_get_Dart _client_bounty_get = _dl.lookupFunction<_client_bounty_get_C, _client_bounty_get_Dart>('client_bounty_get');
typedef _client_bounty_get_C = Int32 Function(
  Int64 port,
  Uint64 bounty_id,
);
typedef _client_bounty_get_Dart = int Function(
  int port,
  int bounty_id,
);

/// <p class="para-brief"> Get a submission Information by using submission Id Returns Cbor encoded `BountySubmissionInformation` as bytes</p>
int client_bounty_get_submission(
  int port,
  int submission_id,
) {
  return _client_bounty_get_submission(port, submission_id);
}
final _client_bounty_get_submission_Dart _client_bounty_get_submission = _dl.lookupFunction<_client_bounty_get_submission_C, _client_bounty_get_submission_Dart>('client_bounty_get_submission');
typedef _client_bounty_get_submission_C = Int32 Function(
  Int64 port,
  Uint64 submission_id,
);
typedef _client_bounty_get_submission_Dart = int Function(
  int port,
  int submission_id,
);

/// <p class="para-brief"> Get a list of open bounties. Returns a Cbor encoded list of `BountyInformation` as bytes.</p>
int client_bounty_open_bounties(
  int port,
  int min,
) {
  return _client_bounty_open_bounties(port, min);
}
final _client_bounty_open_bounties_Dart _client_bounty_open_bounties = _dl.lookupFunction<_client_bounty_open_bounties_C, _client_bounty_open_bounties_Dart>('client_bounty_open_bounties');
typedef _client_bounty_open_bounties_C = Int32 Function(
  Int64 port,
  Uint64 min,
);
typedef _client_bounty_open_bounties_Dart = int Function(
  int port,
  int min,
);

/// <p class="para-brief"> Get a list of open submissions on a bounty. Returns a Cbor encoded list of `BountySubmissionInformation` as bytes.</p>
int client_bounty_open_bounty_submissions(
  int port,
  int bounty_id,
) {
  return _client_bounty_open_bounty_submissions(port, bounty_id);
}
final _client_bounty_open_bounty_submissions_Dart _client_bounty_open_bounty_submissions = _dl.lookupFunction<_client_bounty_open_bounty_submissions_C, _client_bounty_open_bounty_submissions_Dart>('client_bounty_open_bounty_submissions');
typedef _client_bounty_open_bounty_submissions_C = Int32 Function(
  Int64 port,
  Uint64 bounty_id,
);
typedef _client_bounty_open_bounty_submissions_Dart = int Function(
  int port,
  int bounty_id,
);

/// <p class="para-brief"> Create a new Bounty Returns the `BountyId` as `u64`</p>
int client_bounty_post(
  int port,
  Pointer<ffi.Utf8> repo_owner,
  Pointer<ffi.Utf8> repo_name,
  int issue_number,
  int amount,
) {
  return _client_bounty_post(port, repo_owner, repo_name, issue_number, amount);
}
final _client_bounty_post_Dart _client_bounty_post = _dl.lookupFunction<_client_bounty_post_C, _client_bounty_post_Dart>('client_bounty_post');
typedef _client_bounty_post_C = Int32 Function(
  Int64 port,
  Pointer<ffi.Utf8> repo_owner,
  Pointer<ffi.Utf8> repo_name,
  Uint64 issue_number,
  Uint64 amount,
);
typedef _client_bounty_post_Dart = int Function(
  int port,
  Pointer<ffi.Utf8> repo_owner,
  Pointer<ffi.Utf8> repo_name,
  int issue_number,
  int amount,
);

/// <p class="para-brief"> Create a submission on a bounty Returns the `SubmissionId` as `u64`</p>
int client_bounty_submit(
  int port,
  int bounty_id,
  Pointer<ffi.Utf8> repo_owner,
  Pointer<ffi.Utf8> repo_name,
  int issue_number,
  int amount,
) {
  return _client_bounty_submit(port, bounty_id, repo_owner, repo_name, issue_number, amount);
}
final _client_bounty_submit_Dart _client_bounty_submit = _dl.lookupFunction<_client_bounty_submit_C, _client_bounty_submit_Dart>('client_bounty_submit');
typedef _client_bounty_submit_C = Int32 Function(
  Int64 port,
  Uint64 bounty_id,
  Pointer<ffi.Utf8> repo_owner,
  Pointer<ffi.Utf8> repo_name,
  Uint64 issue_number,
  Uint64 amount,
);
typedef _client_bounty_submit_Dart = int Function(
  int port,
  int bounty_id,
  Pointer<ffi.Utf8> repo_owner,
  Pointer<ffi.Utf8> repo_name,
  int issue_number,
  int amount,
);

/// <p class="para-brief"> Setup the Sunshine Client using the provided path as the base path and with chainspec</p><p> ### Safety This assumes that the path and chain_spec is non-null c string.</p>
int client_init(
  int port,
  Pointer<ffi.Utf8> path,
  Pointer<ffi.Utf8> chain_spec,
) {
  return _client_init(port, path, chain_spec);
}
final _client_init_Dart _client_init = _dl.lookupFunction<_client_init_C, _client_init_Dart>('client_init');
typedef _client_init_C = Int32 Function(
  Int64 port,
  Pointer<ffi.Utf8> path,
  Pointer<ffi.Utf8> chain_spec,
);
typedef _client_init_Dart = int Function(
  int port,
  Pointer<ffi.Utf8> path,
  Pointer<ffi.Utf8> chain_spec,
);

/// <p class="para-brief"> Check if the Logger is already initialized to prevent any errors of calling init again. return 1 if initialized before, 0 otherwise.</p>
int frusty_logger_is_initialized() {
  return _frusty_logger_is_initialized();
}
final _frusty_logger_is_initialized_Dart _frusty_logger_is_initialized = _dl.lookupFunction<_frusty_logger_is_initialized_C, _frusty_logger_is_initialized_Dart>('frusty_logger_is_initialized');
typedef _frusty_logger_is_initialized_C = Int32 Function();
typedef _frusty_logger_is_initialized_Dart = int Function();

/// <p class="para-brief"> a hack to make iOS link to this lib</p>
void link_me_please() {
  _link_me_please();
}
final _link_me_please_Dart _link_me_please = _dl.lookupFunction<_link_me_please_C, _link_me_please_Dart>('link_me_please');
typedef _link_me_please_C = Void Function();
typedef _link_me_please_Dart = void Function();

/// Binding to `allo-isolate` crate
void store_dart_post_cobject(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
) {
  _store_dart_post_cobject(ptr);
}
final _store_dart_post_cobject_Dart _store_dart_post_cobject = _dl.lookupFunction<_store_dart_post_cobject_C, _store_dart_post_cobject_Dart>('store_dart_post_cobject');
typedef _store_dart_post_cobject_C = Void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);
typedef _store_dart_post_cobject_Dart = void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);
