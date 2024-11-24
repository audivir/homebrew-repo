cask "battery-cli" do
  version "1.2.3"
  # sha256 "dc0ce58181bc53bbd4f2c500162e529067bd7d234962c8c7abfd7539c6e392ad"
  url "file:///Users/tim/battery-cli/src.tar.gz"
  name "Battery"
  desc "CLI for managing battery charging."
  homepage "https://github.com/actuallymentor/battery/"

  depends_on macos: ">= :catalina"
  depends_on arch: :arm64
  depends_on formula: "smc"

  binary "battery.sh", target: "battery"

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
  end

  zap trash: [
    "~/Library/LaunchAgents/battery.plist",
  ]
end
