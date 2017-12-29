# launchapp

Launch iOS applications from the command line (jailbreak only).

Launchapp allows you to launch any app on iOS from the command line (connected via SSH). You can even launch apps that are hidden by default.

## Usage

`launchapp com.apple.mobilesafari`

That's it :)

## Building and installing

You'll need an iDevice running iOS 11 or later, jailbroken with [LiberiOS](http://newosxbook.com/liberios/). On your Mac, you'll need Xcode 9 and jtool. If you don't have jtool installed, the build script will automatically download the latest version. Make sure that if you do have jtool installed, it is the most recent version [downloaded from here](http://www.newosxbook.com/tools/jtool.html).

To build and install, run:

`./build remote_host`

Where `remote_host` is the SSH connection string for your iDevice.

Example:

`./build root@192.168.1.112`

If you want to just build and install manually, use `--skip-install`:

`./build --skip-install`