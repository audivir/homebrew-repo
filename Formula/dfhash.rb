class Dfhash < Formula
  desc "Deterministic content hasher for tabular data files"
  homepage "https://github.com/audivir/dfhash"
  version "0.1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-darwin-arm64"
      sha256 "aead7809102bfec497e24c61623f8aeef83e862e31b8f060bd6710eec3dff995"
    else
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-darwin-amd64"
      sha256 "47e07bba75fb430d6928090ca3de847205bd96b58dda6c1cdf52fc2fb0ece45b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-linux-arm64"
      sha256 "c6c44509dda850caa335c67b9cc05392a15189b1c3649980a142d9c6fd7efde1"
    else
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-linux-amd64"
      sha256 "06b64831ec14e5590c7ffe5fa0d38efd5da3025200e983fed0868b6384c03394"
    end
  end

  def install
    # Rename to just 'dfhash'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "dfhash-darwin-arm64" : "dfhash-darwin-amd64"
    else
      Hardware::CPU.arm? ? "dfhash-linux-arm64" : "dfhash-linux-amd64"
    end

    bin.install binary_name => "dfhash"
  end

  test do
    assert_match "dfhash #{version}", shell_output("#{bin}/dfhash --version")
  end
end
