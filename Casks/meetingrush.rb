cask "meetingrush" do
  version "0.1.3"
  sha256 "5ac715da85abc2c5b091043b7ba625effb51c293e412653d662904d3785148da"

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
          "-R=anchor apple generic and certificate leaf[subject.OU] = \"5F3K8H626Z\"",
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
