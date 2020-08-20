# Sunshine Flutter Frontend

This project uses [cargo make](https://github.com/sagiegurari/cargo-make) to combine the build commands for compiling the Rust `sunshine` module and linking it to the Flutter interface. This structure will eventually enable our substrate light client to talk directly to the Flutter interface (with no dependency on polkadot-js).

[`shekohex/flutterust`](https://github.com/shekohex/flutterust) is a generic template for Rust to Dart FFI

## Build Instructions

1. **[Install Flutter](https://flutter.dev/docs/get-started/install)**.

It is common for developers to get stuck setting the path to the Dart and Flutter SDKs after installation so take careful note of where these are installed. See the Dart docs: [Configure PATH and environment variables](https://dartcode.org/docs/configuring-path-and-environment-variables/) for more info.

2. Run `flutter doctor` to verify that you have everything needed to build and run a flutter application.

You probably won't have a connected device and that's OK, you can pick your emulator in step (5) below.

3. Install Cargo Make, Dart Bindgen and CBindgen (skip if you already have them installed)

```
$ cargo install cargo-make cbindgen
$ cargo install dart-bindgen --features cli
```

4. Clone this repository.

### Android

_These instructions assume that you have installed Android Studio or the flutter plugins for Android Studio._

5. [Open the Android emulator](https://developer.android.com/studio/run/emulator).

6. Run the following commands in the root of the cloned repository.

```
$ cargo make android-dev # for android only using x86_64 emulator (run cargo make android to build for all android targets)
$ flutter run
```

### iOS

_These instructions assume that you may NOT have installed Android Studio nor the flutter plugins for Android Studio._

5. [Open the iOS emulator](https://stackoverflow.com/questions/10379622/how-to-run-iphone-emulator-without-starting-xcode). This could be as simple as invoking the following command if you've set this alias before.

```
$ open -a simulator
```

You may have to specify File -> Open Device -> `$MODEL` once the simulator opens.

6. In the root of the cloned repo, run the following commands.

```
$ cargo make ios --profile release # Release Build is Required since debug build is very big.
$ flutter run
```

After you run the application, all changed state is saved in the directory. To restart from the `Generate Your Account` screen, you must reset the cloned repo to head (`git reset --hard HEAD`), delete the app from the simulator and do the last three commands listed above again.

# License

Copyright 2020 Sunshine Protocol

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
