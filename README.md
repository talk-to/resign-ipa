# resign-ipa

`resign-ipa` allows you to re-sign a .ipa with a different
provisioning profile. The provisioning profile can have a different
signing identity from the original provisioning profile.

## Installation

* The `bin/resign-ipa` is a standalone Ruby script that you can place
  in your path.

* This repository is also a Ruby Gem, so you can use it by adding the
  following to your Gemfile

        gem 'resign-ipa', :git => 'git@github.com:talk-to/resign-ipa.git', :tag => '0.0.1'

  followed by a `bundle install`.

## Usage

To use this script, you would need

1. A .ipa to resign
2. The new provisioning profile
3. The signing identity (certificate + key) for the provisioning
   profile in your keychain

With all this in place, resign a .ipa with the following command.

```
resign-ipa -p new_profile.mobileprovision source.ipa destination.ipa
```

For an explaination of the various steps involved in resigning an iOS
app, see [this gist][resign gist].

[resign gist]: https://gist.github.com/chaitanyagupta/9a2a13f0a3e6755192f7

## Entitlements

By default, entitlements are extracted from the given provisioning
profile. If you want to use a different set of entitlements, you can
specify your own entitlements file with the `-e` switch.

```
resign-ipa -e entitlements.plist -p new_profile.mobileprovision source.ipa destination.ipa

```

Entitlements in an app could differ from those in the provisioning
profile, so its always a good idea to see if the two match up
(i.e. all the entitlements that the app asks for are available in the
provisioning profile). You can use the `codesign` utility to get the
entitlements in the original .ipa.

```
unzip source.ipa
codesign -d --entitlements :entitlements.plist Payload/<app-name>.app/
```

This will write `entitlements.plist` with the current set of
entitlements. Compare this with the entitlements in the provisioning
profile which can be extracted like this:

```
# Remove codesigning blobs from the provisioning profile and get the plain plist
security cms -D -i new_profile.mobileprovision -o plain_profile.plist

# Print the entitlements from the plist
PlistBuddy -x -c 'Print :Entitlements' plain_profile.plist
```

If the provisioning profile has all the entitlements that the app asks
for, then you don't need to explicitly provide any entitlements. If
they don't, then create a new entitlements plist[1] and provide it
using the `-e` switch.

## Notes

1. At the very least, you will need to update
`application-identifier`, `com.apple.developer.team-identifier` and
`keychain-access-groups`

## Releasing a new version

Update `resign-ipa.gemspec` and then run `rake release:tag`.
