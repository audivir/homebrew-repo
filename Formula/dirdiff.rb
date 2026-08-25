class Dirdiff < Formula
  desc "Recursively compare two local or ssh-remote directories"
  homepage "https://github.com/audivir/dirdiff"
  version "0.1.7"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "3f8bedd5bdd7464aad556ae4d649de601ee8c77b4378392c0fbcbc3b52f2eced"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-amd64"
      sha256 "cd7d0dc065e99e660a0643c84b3b0483de32db3855cad2fa4043dc60b2275a65"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "f1458f41f99ea8db4911383b15345fda0cbd47b5665784bf67c68022a338c097"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "47ccea30f4b8cef7cb1156316fdf6e045d10da8a6391e2d11041ad3400479f4e"
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
    assert_match "dirdiff version v#{version}", shell_output("#{bin}/dirdiff --version")
  end
end
