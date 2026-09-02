class Pbput < Formula
  desc "Put typed data directly onto the macOS pasteboard from files or stdin"
  homepage "https://github.com/audivir/pbput"
  version "0.1.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/pbput/releases/download/v#{version}/pbput-aarch64-apple-darwin"
      sha256 "49108372dffdcc6d4fd214e8609c6bc78a0d2c60b76848aa4686ae5f1c95cf8f"
    end
  end

  def install
    # Rename to just 'pbput'
    binary_name = "pbput-aarch64-apple-darwin"

    bin.install binary_name => "pbput"
  end

  test do
    assert_match "pbput #{version}", shell_output("#{bin}/pbput --version")
  end
end
