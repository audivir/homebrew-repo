class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.2.8"
  depends_on "libpdfium"
  depends_on "libheif"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-apple-darwin"
      sha256 "df7befb91eecbe5c825dda30fb0f2d981a2f6452b4da162043f60b2e542e8518"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-unknown-linux-gnu"
      sha256 "5440ed33d0e2901043b82a1426db3e14a607262106c8d994972975632388ea1e"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-x86_64-unknown-linux-gnu"
      sha256 "8ff1b22bf0670817221b3c6c63b339edb4ca067f6d965ce1e0605a192293806f"
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
    "For full functionality, you may need to install libreoffice:
    brew install libreoffice"
  end

  test do
    assert_match "kv #{version}", shell_output("#{bin}/kv --version")
  end
end
