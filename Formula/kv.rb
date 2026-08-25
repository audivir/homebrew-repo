class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.2.7"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-apple-darwin"
      sha256 "92ab3f69d04b39d60d7e003a0b384eb312e3328d510f7b63d641cf057a6cb57f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-unknown-linux-gnu"
      sha256 "27a960a84a313a338a0fce0898c5a1ca46a56c1dd4a23f8a67c47ddf2159e9a9"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-x86_64-unknown-linux-gnu"
      sha256 "916828469a187e3f3417e6b0b7bc3626839765e4e1768bdb0faf02634a5863ff"
    end
  end

  depends_on "libpdfium"

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
