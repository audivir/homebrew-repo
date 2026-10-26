class MkpasswdGo < Formula
  desc "Go-clone of whois' mkpasswd utility"
  homepage "https://github.com/audivir/mkpasswd-go"
  version "1.0.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-darwin-arm64"
      sha256 "727318431200c89afd25f4f5f62b42abfe502205d6c8bc2c6aff540595c1fbea"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-arm64"
      sha256 "1a84b5e6da55359eb724ff9b37d2fb82e29f8bd0f4fab576bafc19222593485a"
    else
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-amd64"
      sha256 "99b3ed704684a589b1c61cfa1df36711e8d3b035c4594977b0a585f595e7dcfa"
    end
  end

  def install
    # Rename to just 'mkpasswd-go'
    binary_name = if OS.mac?
      "mkpasswd-go-darwin-arm64"
    else
      Hardware::CPU.arm? ? "mkpasswd-go-linux-arm64" : "mkpasswd-go-linux-amd64"
    end

    bin.install binary_name => "mkpasswd-go"
  end

  test do
    assert_match "mkpasswd-go version v#{version}", shell_output("#{bin}/mkpasswd-go --version")
  end
end
