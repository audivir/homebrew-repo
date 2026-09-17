class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.3.2"

  depends_on "libpdfium"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-apple-darwin"
      sha256 "df055fc82ba0c5f0e0c59b184b4e9dd3e87c1a5c0476fb1ed0705d06c330e81e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-unknown-linux-gnu"
      sha256 "b4078cbba010879490237b3c8530af77b674777811fe1394159ba83b2af42e61"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-x86_64-unknown-linux-gnu"
      sha256 "275cd46afa8b832bffd4e3add801f097d179ce9e95c8b19d151dacba20d962a3"
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
