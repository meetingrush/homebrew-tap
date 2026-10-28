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

  depends_on macos: :sonoma

  app "MeetingRush.app"

  # Releases are signed with an Apple Development certificate, which Gatekeeper rejects for downloaded apps, so the
  # quarantine flag is removed, but only from an app signed by the project's own team. Drop both once notarised.
  postflight_steps do
    run "/usr/bin/codesign",
        args: [
          "--verify",
          "--strict",
          "-R=anchor apple generic and certificate leaf[subject.OU] = \"REPLACE_WITH_TEAM_ID\"",
          "{{appdir}}/MeetingRush.app",
        ]
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MeetingRush.app"]
  end

  uninstall quit: "dev.meetingrush.MeetingRush"

  zap script: {
        executable:   "/usr/bin/security",
        args:         ["delete-generic-password", "-s", "dev.meetingrush.MeetingRush.google", "-a", "secrets"],
        must_succeed: false,
      },
      trash:  [
        "~/Library/Caches/dev.meetingrush.MeetingRush",
        "~/Library/HTTPStorages/dev.meetingrush.MeetingRush",
        "~/Library/Preferences/dev.meetingrush.MeetingRush.plist",
      ]
end
