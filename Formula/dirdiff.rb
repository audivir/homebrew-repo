class Dirdiff < Formula
  desc "Recursively compare two local or ssh-remote directories"
  homepage "https://github.com/audivir/dirdiff"
  version "0.1.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "8761eb346116db5d5dce2b3738d1e9926d3c50152b56cc673670ddaeaf89f37a"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-amd64"
      sha256 "a90fa1e6dc35338275bb4fef048aba9b8897187fba615ced628b036a46528ddc"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "ab8f7e87747b641d69df8e1e98f39798a34ecaab4c110422e890e8884ca3ee47"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "fbb9bf375e37b59bc68a31dad99d8562f8063655c3d975d335737c6c52d406b6"
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
    # Updated to match our latest usage text
    assert_match "dirdiff version #{version}", shell_output("#{bin}/dirdiff --version")
  end
end
