cask "battery-cli" do
  name "Battery CLI"
  desc "CLI for managing battery charging."
  homepage "https://github.com/audivir/battery-cli/"
  sha256 "4b342cbebcc13656749951a37a978b49fe3a1a9b73b3bc8dca655f24bbd1767b"
  url "https://github.com/audivir/battery-cli/archive/refs/tags/0.9.0.tar.gz"

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
