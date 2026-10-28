# MeetingRush Homebrew tap

```sh
brew install --cask meetingrush/tap/meetingrush
```

The cask installs [MeetingRush](https://github.com/meetingrush/meetingrush) into `/Applications` from its GitHub Release.
It runs on Apple silicon and Intel Macs with macOS 14 or later.
Update with `brew upgrade --cask meetingrush` and remove with `brew uninstall --cask meetingrush`, adding `--zap` to also remove its settings and saved Google sign-in.

## Moving from the formula

MeetingRush used to be a formula here.
To switch a Mac over:

```sh
pkill -x MeetingRush
brew uninstall --formula meetingrush
rm -f ~/Applications/MeetingRush.app   # a symlink to the old install, if you made one
brew install --cask meetingrush/tap/meetingrush
open /Applications/MeetingRush.app
```

The app's code signature changes with the move, so macOS asks once more for calendar access, and once for keychain access if you've connected Google Calendar.
Launch at login also points at the old install: turn it off and on again in MeetingRush's Settings.
