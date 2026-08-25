class MkpasswdGo < Formula
  desc "Go-clone of whois' mkpasswd utility"
  homepage "https://github.com/audivir/mkpasswd-go"
  version "0.1.6"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "0eb59b84d9d47759992965f537fa0628ec5e566914ec5fd1080eaaa0a9ac6118"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-amd64"
      sha256 "dbba33ff0ab625c0feb6bef6cc2bb3eac947db2b20053b457d46749f6a68e35c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "1bd1a16e02e04ae19a3bbd14de71da46df441cd4f9dd85ce0ff1f299e5e98434"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "ab50d01a1bd619955c6c94d7aa94dcc04c4993a54625f2821cd68d2ec472bd96"
    end
  end

  def install
    # Rename to just 'mkpasswd-go'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "dirdiff-darwin-arm64" : "dirdiff-darwin-amd64"
    else
      Hardware::CPU.arm? ? "dirdiff-linux-arm64" : "dirdiff-linux-amd64"
    end
  
    bin.install binary_name => "mkpasswd-go"
  end

  test do
    # Updated to match our latest usage text
    assert_match "dirdiff version #{version}", shell_output("#{bin}/dirdiff --version")
  end
end
