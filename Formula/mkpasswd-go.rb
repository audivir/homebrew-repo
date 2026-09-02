class MkpasswdGo < Formula
  desc "Go-clone of whois' mkpasswd utility"
  homepage "https://github.com/audivir/mkpasswd-go"
  version "1.0.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-darwin-arm64"
      sha256 "3f04a68c4c37edf22a1717fe3f1d759b3823009f6e8766b77d187d2ee938bf45"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-arm64"
      sha256 "b7fe4312bf25e5cc972fb83a6eab71743713ff3b19c0ddb22e503edabc825ad1"
    else
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-amd64"
      sha256 "6c9a46b25e664e13818086c19d05690abed3f45c0f8564c9e8afe36c665827dc"
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
