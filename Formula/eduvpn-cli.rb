class EduvpnCli < Formula
  desc "Command-line client for eduVPN"
  homepage "https://codeberg.org/eduVPN/eduvpn-common"
  url "https://codeberg.org/eduVPN/eduvpn-common/archive/4.0.0.tar.gz"
  sha256 "5708cb51a99a274ae6b2207bfbebfc61d31d67e57e6f75e472a99537055f4c9d"
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