class Dirdiff < Formula
  desc "Recursively compare two local or ssh-remote directories"
  homepage "https://github.com/audivir/dirdiff"
  version "0.1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "fd49a3f2a8d68d40da745afae8c38d17064bef5d86b017f662c4b868255581f9"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-amd64"
      sha256 "df0e094c61bfef0709beed4e248079628da331d2d1c25649f24005aabe339f57"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "e89a9532287ff1ec7636c718825d1c1afcc550c7bac0f428a79b56364d8701aa"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "1baeb0f71c2f3a3897a9fc2fd82954b12c67a1720f89b08f9d91397d416392cd"
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
  end

  test do
    # Updated to match our latest usage text
    assert_match "dirdiff version 0.1.2", shell_output("#{bin}/dirdiff --version")
  end
end
