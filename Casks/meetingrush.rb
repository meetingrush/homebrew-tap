cask "meetingrush" do
  version "0.1.2"
  sha256 "REPLACE_WITH_RELEASE_SHA256"

  url "https://github.com/meetingrush/meetingrush/releases/download/v#{version}/MeetingRush-#{version}.zip"
  name "MeetingRush"
  desc "Full-screen meeting alerts with one-click join"
  homepage "https://github.com/meetingrush/meetingrush"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "MeetingRush.app"

  # Releases are signed with an Apple Development certificate, which Gatekeeper rejects for downloaded apps.
  # Remove this once they're signed with a Developer ID and notarised.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MeetingRush.app"]
  end

  uninstall quit: "dev.meetingrush.MeetingRush"

  zap trash: "~/Library/Preferences/dev.meetingrush.MeetingRush.plist"
end
