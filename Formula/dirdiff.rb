class Dirdiff < Formula
  desc "Recursively compare two local or ssh-remote directories"
  homepage "https://github.com/audivir/dirdiff"
  version "2.0.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "b55173690c8e9b0aa0073cfe9611ea3554691668e17ee57db793bbd6f4ccc5d1"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-amd64"
      sha256 "b79f9d262b719dc9ba376cbb77a613f6dd716b12192ab2af191c7655eaa4f6dd"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "60d44fe7325723ea9c79a535f2507fb4b840aef090f301428b6434cfb20102b4"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "358f3b02ef117d6b99df2db6dabfc059cacf0830ad2a7392b4d434fd34328830"
    end
  end

  def install
    # Rename to just 'dirdiff'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "dirdiff-darwin-arm64" : "dirdiff-darwin-amd64"
    else
      Hardware::CPU.arm? ? "dirdiff-linux-arm64" : "dirdiff-linux-amd64"
    end

    bin.install binary_name => "dirdiff"
  end

  test do
    assert_match "dirdiff version v#{version}", shell_output("#{bin}/dirdiff --version")
  end
end
