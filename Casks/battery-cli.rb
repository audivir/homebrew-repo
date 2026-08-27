cask "battery-cli" do
  name "Battery CLI"
  desc "CLI for managing battery charging."
  homepage "https://github.com/audivir/battery-cli/"
  sha256 "5e0ea56bf99b88cf06d239c5de9983467ba1e2c21a05379602a554da113a4011"
  version "1.3.4"
  url "https://github.com/audivir/battery-cli/archive/refs/tags/v#{version}.tar.gz"

  depends_on macos: :catalina
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
