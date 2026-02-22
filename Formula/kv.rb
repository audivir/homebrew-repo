class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.2.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-arm64"
      sha256 "b304fd84386c77b85c43f7ff284ed02d5975f4893bb80ad64d23fa41889675ac"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-darwin-amd64"
      sha256 "784b73f09b2f89e136ae02e30d01847ff04c8222244c7b784059c8d680d6e469"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-arm64"
      sha256 "f754fd5e26c4b1a28fa0c92ebcf7b121b0edd42b16fcb0e3669e3ad7ee306ea4"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-linux-amd64"
      sha256 "989461b4b25cc9baceb825cc515f9ddce4a9efbbe1ee9ca66671a93949b9974a"
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
