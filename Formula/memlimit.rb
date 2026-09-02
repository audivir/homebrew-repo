class Memlimit < Formula
  desc "Watches a process tree and terminates it if the memory reaches a limit"
  homepage "https://github.com/audivir/memlimit"
  version "0.1.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-darwin-arm64"
      sha256 "29bb6f168d1a07002abffbb46fdbabb71393b91223ea5b61916636bc44aee4da"
    else
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-darwin-amd64"
      sha256 "88eba1a9c031d7f0898fdd8f40a32c7700c8eb8d2ccdb8470ee4b8f0382dd3f3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-linux-arm64"
      sha256 "d9647a14ee4544787e5b0e924ddf4b1e7792214b49aebe88dbaa2b793a3ab627"
    else
      url "https://github.com/audivir/memlimit/releases/download/v#{version}/memlimit-linux-amd64"
      sha256 "3655075f12e691c548787bc35938836598a6836d7fe136300088df3f6cdd9f2c"
    end
  end

  def install
    # Rename to just 'memlimit'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "memlimit-darwin-arm64" : "memlimit-darwin-amd64"
    else
      Hardware::CPU.arm? ? "memlimit-linux-arm64" : "memlimit-linux-amd64"
    end

    bin.install binary_name => "memlimit"
  end

  test do
    assert_match "memlimit version v#{version}", shell_output("#{bin}/memlimit --version")
  end
end
