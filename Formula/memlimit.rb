class Memlimit < Formula
  desc "Watches a process tree and terminates it if the memory reaches a limit"
  homepage "https://github.com/audivir/memlimit"
  version "0.1.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-darwin-arm64"
      sha256 "006ebbd41577460dc6bfbdd237d6b957adfb441c6b3959680d31b2ff2c2fd547"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-linux-arm64"
      sha256 "60c764163e1b24166c50276450397dc5750af41d2e898b6de04e50c6afd9f83c"
    else
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-linux-amd64"
      sha256 "61a3c8aaa5279059cffdc48356aba50a20f3516ecfd00c8d1ff3f26eed6d49e5"
    end
  end

  def install
    # Rename to just 'memlimit'
    binary_name = if OS.mac?
      "memlimit-darwin-arm64"
    else
      Hardware::CPU.arm? ? "memlimit-linux-arm64" : "memlimit-linux-amd64"
    end

    bin.install binary_name => "memlimit"
  end

  test do
    assert_match "memlimit version v#{version}", shell_output("#{bin}/memlimit --version")
  end
end
