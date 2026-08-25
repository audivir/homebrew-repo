class MkpasswdGo < Formula
  desc "Go-clone of whois' mkpasswd utility"
  homepage "https://github.com/audivir/mkpasswd-go"
  version "1.0.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-darwin-arm64"
      sha256 "e679e5fde639a971e460da1ac808fe42bba3a5b0f194c71b2a1be7e4f835fbc1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-arm64"
      sha256 "772fbe7207bb02ccd6a3183c1667efe59a5910e01aba7cb252bc1e33c1fb77bc"
    else
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-amd64"
      sha256 "472c8acca11023d81f0b43b49ea8ac6dc58a2164b7770c28a114d4b72cc410e9"
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
    # Updated to match our latest usage text
    assert_match "mkpasswd-go version v#{version}", shell_output("#{bin}/mkpasswd-go --version")
  end
end
