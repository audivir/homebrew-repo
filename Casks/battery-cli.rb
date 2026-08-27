cask "battery-cli" do
  name "Battery CLI"
  desc "CLI for managing battery charging."
  homepage "https://github.com/audivir/battery-cli/"
  sha256 "62850fe3fe354e791b14bc916e6eb4819b250a7db2b4dbe641ac5f0bb09eca5b"
  version "1.3.4"
  url "https://github.com/audivir/battery-cli/archive/refs/tags/v#{version}.tar.gz"

  depends_on macos: :big_sur
  depends_on arch: :arm64
  depends_on formula: "smc"

  binary "#{staged_path}/battery-cli-#{version}/battery.sh", target: "battery"

  postflight do
    curr_user = ENV["USER"]

    system_command "#{HOMEBREW_PREFIX}/bin/battery",
                 args: ["visudo", "#{curr_user}"],
                 sudo: true
  end

  uninstall_preflight do
    system_command "#{HOMEBREW_PREFIX}/bin/battery",
                 args: ["uninstall", "silent"],
                 sudo: true
    system_command "/usr/bin/pkill",
                args: ["-f", "#{HOMEBREW_PREFIX}/bin/battery"]
  end

  zap trash: [
    "~/Library/LaunchAgents/battery.plist",
  ]
end
