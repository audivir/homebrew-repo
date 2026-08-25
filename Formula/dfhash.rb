class Dfhash < Formula
  desc "Deterministic content hasher for tabular data files"
  homepage "https://github.com/audivir/dfhash"
  version "0.1.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-aarch64-apple-darwin"
      sha256 "b82abf1993fda6e98836ffcf231f59a19846f659f57c7cd304237e7f74eef0ae"
    else
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-x86_64-apple-darwin"
      sha256 "0087b4280d0e6be7db73ab09a76b8c891e90c5bffff55a4e80c011a30fe888b2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-aarch64-unknown-linux-gnu"
      sha256 "62487222508d334516ac3780e4e56acb2e40b3819bc679a28c56670168e8e797"
    else
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-x86_64-unknown-linux-gnu"
      sha256 "b8f03705b9ccd72733cbc5d3f122f4ec3fc1637df9aaa9212558fa76e828df0e"
    end
  end

  def install
    # Rename to just 'dfhash'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "dfhash-aarch64-apple-darwin" : "dfhash-x86_64-apple-darwin"
    else
      Hardware::CPU.arm? ? "dfhash-aarch64-unknown-linux-gnu" : "dfhash-x86_64-unknown-linux-gnu"
    end

    bin.install binary_name => "dfhash"
  end

  test do
    assert_match "dfhash #{version}", shell_output("#{bin}/dfhash --version")
  end
end
