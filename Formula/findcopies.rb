class Findcopies < Formula
  desc "Recursively find copies of files in a directory"
  homepage "https://github.com/audivir/findcopies"
  version "0.1.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/findcopies/releases/download/v#{version}/findcopies-darwin-arm64"
      sha256 "4d67b4d6babf308b73a7e21869f059031da21cbec78632dd350ee693f2dea124"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/findcopies/releases/download/v#{version}/findcopies-linux-arm64"
      sha256 "dc5b5325d26e7c87277b01537d8bdc08f03140ac58bfc5c74ec04016d1a131ea"
    else
      url "https://github.com/audivir/findcopies/releases/download/v#{version}/findcopies-linux-amd64"
      sha256 "f835a808e63f928b8b85fc3b6aa8a100b305b703fb90f6d4334c346abcaae43e"
    end
  end

  def install
    # Rename to just 'findcopies'
    binary_name = if OS.mac?
      "findcopies-darwin-arm64"
    else
      Hardware::CPU.arm? ? "findcopies-linux-arm64" : "findcopies-linux-amd64"
    end

    bin.install binary_name => "findcopies"
  end

  test do
    assert_match "findcopies version v#{version}", shell_output("#{bin}/findcopies --version")
  end
end
