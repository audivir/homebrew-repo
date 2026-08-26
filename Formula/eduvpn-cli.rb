class EduvpnCli < Formula
  desc "Command-line client for eduVPN"
  homepage "https://codeberg.org/eduVPN/eduvpn-common"
  url "https://codeberg.org/eduVPN/eduvpn-common/archive/5.0.3.tar.gz"
  sha256 "41e9daf6c6826aa238da7891d43afeed2e892e7e770f958951de22d5c68c7b66"
  license "GPL-3.0-or-later"

  depends_on "go" => :build

  def install
    system "go", "build",
           *std_go_args(ldflags: "-s -w"),
           "./cmd/eduvpn-cli"
  end

  test do
    output = shell_output(bin/"eduvpn-cli")
    assert_match "-country-code string", output
  end
end
