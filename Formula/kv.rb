class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.2.3"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-arm64"
      sha256 "70bb58f7882c79819c8dca22acc87aec423c52f66d4dce0f721513b53e7ae201"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-amd64"
      sha256 "cc24b8893644110ddf1b89a136d3f7640143dc28c5579f76d69b54008059c311"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-arm64"
      sha256 "cb7b94ff448d71977f09e0cdcbe606a45864b0b9fb5c0fac34892680b32139f9"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-amd64"
      sha256 "e3c719e13af982178e75c65d71dfaebcfcdc40eb4673de371766523290efefd6"
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
