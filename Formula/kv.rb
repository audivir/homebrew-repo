class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.2.3"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-arm64"
      sha256 "6f438ac8de2e215e7add3e538e509243ef682b299da5e112ee24946a0700e005"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-amd64"
      sha256 "4d4af744609b60f807410ae46b42c74ee191c97ab07ef3adb8ec5e0efa6ae137"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-arm64"
      sha256 "2b45038cfcc8a347fa0da169ebfddb5e2cb2b9988aa7ddd7392d7f6445f1efbe"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-amd64"
      sha256 "74a975455b1db09d63b468ad1e5edbb5602330356a93f2b456f605c407316f0f"
    end
  end

  depends_on "libpdfium"

  def install
    # Rename to just 'kv'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "kv-darwin-arm64" : "kv-darwin-amd64"
    else
      Hardware::CPU.arm? ? "kv-linux-arm64" : "kv-linux-amd64"
    end

    bin.install binary_name => "kv"
  end

  def caveats
    <<~EOS
      For full functionality, you may need to install libreoffice:
        brew install libreoffice
    EOS
  end

  test do
    assert_match "kv #{version}", shell_output("#{bin}/kv --version")
  end
end
