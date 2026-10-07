class Dirdiff < Formula
  desc "Recursively compare two local or ssh-remote directories"
  homepage "https://github.com/audivir/dirdiff"
  version "2.0.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "58ba2f49f6ad70e74a9af624cd43651b19fe729fc698c446297232e038b3d19d"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-amd64"
      sha256 "a9d1dd9b57e4e36e23742d552036b7d9b129ac1f4957b1f0b53d4c0d5dea0899"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "4adb41ec1c0e804cbb39cc8f35538a8b76d6ba5ee89d50bfe884eab8790e5bb5"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "f3ef4df6f03fafb541659f74f7f228262d9e03a8d45ddc85c5eee066caf4d4cf"
    end
  end

  def install
    # Rename to just 'dirdiff'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "dirdiff-darwin-arm64" : "dirdiff-darwin-amd64"
    else
      Hardware::CPU.arm? ? "dirdiff-linux-arm64" : "dirdiff-linux-amd64"
    end

    bin.install binary_name => "dirdiff"
    generate_completions_from_executable(bin/"dirdiff", "--gen-completions")
  end

  test do
    assert_match "dirdiff version v#{version}", shell_output("#{bin}/dirdiff --version")
  end
end
