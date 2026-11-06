class Pbput < Formula
  desc "Put typed data directly onto the macOS pasteboard from files or stdin"
  homepage "https://github.com/audivir/pbput"
  version "0.1.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/pbput/releases/download/v#{version}/pbput-aarch64-apple-darwin"
      sha256 "bff3b7d7aa500541527b41557732602d6a8d9bb14c37a208c88315b439398a73"
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
