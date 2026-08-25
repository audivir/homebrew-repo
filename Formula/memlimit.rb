class Memlimit < Formula
  desc "Watches a process tree and terminates it if the memory reaches a limit"
  homepage "https://github.com/audivir/memlimit"
  version "0.1.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-darwin-arm64"
      sha256 "d9427c27bd1b6b8d50ac312336d20600b44ce3fb04c790b7478b50280e83381e"
    else
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-darwin-amd64"
      sha256 "145937f89033ed2f5ce7a1f31f56564c2431a44754621a5451e5cbb4316be3d1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-linux-arm64"
      sha256 "05d551a7ff3dcfac1d25e300320260a736fbe19592380f0609c67ca8ba2ef04e"
    else
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-linux-amd64"
      sha256 "eff560568fcdf9876362c9768ea1152219850a05a73df4231b3bb59011d8d817"
    end
  end
  
  def install
    # Rename to just 'memlimit'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "memlimit-darwin-arm64" : "memlimit-darwin-amd64"
    else
      Hardware::CPU.arm? ? "memlimit-linux-arm64" : "memlimit-linux-amd64"
    end

    bin.install binary_name => "memlimit"
  end

  test do
    # Updated to match our latest usage text
    assert_match "memlimit version v#{version}", shell_output("#{bin}/memlimit --version")
  end
end
