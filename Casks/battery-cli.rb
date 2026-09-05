cask "battery-cli" do
  name "Battery CLI"
  desc "CLI for managing battery charging."
  homepage "https://github.com/audivir/battery-cli/"
  sha256 "063fcb15419c1c06182565ecdeab6c29c251c3592e7be2cd13c67e49635800f8"
  version "1.3.5"
  url "https://github.com/audivir/battery-cli/archive/refs/tags/v#{version}.tar.gz"

  depends_on macos: :big_sur
  depends_on arch: :arm64
  depends_on formula: "smc"

  binary "#{staged_path}/battery-cli-#{version}/battery.sh", target: "battery"

  postflight_steps do
    run "{{HOMEBREW_PREFIX}}/bin/battery",
      args: ["visudo", "{{user}}"],
      sudo: true
  end

  uninstall_preflight_steps do
    run "{{HOMEBREW_PREFIX}}/bin/battery",
      args: ["uninstall", "silent"],
      sudo: true,
      must_succeed: false
    run "/bin/sh",
      args: ["-c", "/usr/bin/pkill -f '{{HOMEBREW_PREFIX}}/bin/battery' || true"]
  end

  zap trash: [
    "~/Library/LaunchAgents/battery.plist",
  ]
end
