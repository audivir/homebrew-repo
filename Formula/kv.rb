class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.2.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-arm64"
      sha256 "43a05425bb6d575410f5efff6d8b24a0003f586b2eeea26b79770a08952d9222"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-amd64"
      sha256 "4ec1f98b434e74cc2ae08aba0cb6642985ecdc685736fe43f2a592cadf4eeca1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-arm64"
      sha256 "3a92cce7a615f9ba614eaf26cc333b75d092f4ca3897f71f19be540b55ed8d85"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-amd64"
      sha256 "3647457f786164b1c63368ac07c67b53c81a1fc0c814b87e6425d122c5aed26f"
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
