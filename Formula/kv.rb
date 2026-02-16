class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  url "https://github.com/audivir/kv.git",
      tag:      "v0.2.0",
      revision: "b224598e61d9be05f0b1aab725a76caaec0c3b6c"
  license "MIT"

  depends_on "rust" => :build
  depends_on "pdfium"

  def install
    system "cargo", "install", *std_cargo_args
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
