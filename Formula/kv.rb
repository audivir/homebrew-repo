class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.3.0"

  depends_on "libpdfium"
  depends_on "libheif"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-apple-darwin"
      sha256 "d700aa1abe589c4882ed5c74920dec384d619949a0562d27d74e629cde621da8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-unknown-linux-gnu"
      sha256 "b69e3cda4535f756d2caec7d1eb6d99945cf7c0eea3542d2d3f78f1f07d4c590"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-x86_64-unknown-linux-gnu"
      sha256 "48fdc62287d6c5f9307853d1b2dee2263799fdfeaf6bac4e0bff953c75db202f"
    end
  end

  def install
    # Rename to just 'kv'
    binary_name = if OS.mac?
      "kv-aarch64-apple-darwin"
    else
      Hardware::CPU.arm? ? "kv-aarch64-unknown-linux-gnu" : "kv-x86_64-unknown-linux-gnu"
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
