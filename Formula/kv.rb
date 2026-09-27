class Kv < Formula
  desc "Image viewer for the Kitty Terminal Graphics Protocol"
  homepage "https://github.com/audivir/kv"
  version "0.3.5"

  depends_on "libpdfium"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-apple-darwin"
      sha256 "8cd6b4d933d57bda9ba691616a9a6e8017281fe56c8a015451d417ae6e4f8624"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-aarch64-unknown-linux-gnu"
      sha256 "f64fe343e9ffca7a33297750e34c074c4a10ede07a4ff8a793818dc7a8880e0e"
    else
      url "https://github.com/audivir/kv/releases/download/v#{version}/kv-x86_64-unknown-linux-gnu"
      sha256 "ad9ebc411799dfae850451237d98d753642959705ff4eb482aa806de42e2b567"
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
