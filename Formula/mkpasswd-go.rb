class MkpasswdGo < Formula
  desc "Go-clone of whois' mkpasswd utility"
  homepage "https://github.com/audivir/mkpasswd-go"
  version "1.0.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-darwin-arm64"
      sha256 "bfde5cebcad9dd150a40375c46092a065abe66a7e33a240fd544ffa89f3c13ae"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-arm64"
      sha256 "7cc1aca91ad71413002a42397562bad00658b5da8ac78ab64b805149eaa33a9a"
    else
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-amd64"
      sha256 "e65b7c89605cf9c9f3895e78b9131016930196b3f8f5962a4d375f42eb218be0"
    end
  end

  def install
    # Rename to just 'mkpasswd-go'
    binary_name = if OS.mac?
      "mkpasswd-go-darwin-arm64"
    else
      Hardware::CPU.arm? ? "mkpasswd-go-linux-arm64" : "mkpasswd-go-linux-amd64"
    end

    bin.install binary_name => "mkpasswd-go"
  end

  test do
    assert_match "mkpasswd-go version v#{version}", shell_output("#{bin}/mkpasswd-go --version")
  end
end
