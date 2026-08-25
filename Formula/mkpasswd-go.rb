class MkpasswdGo < Formula
  desc "Go-clone of whois' mkpasswd utility"
  homepage "https://github.com/audivir/mkpasswd-go"
  version "1.0.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-darwin-arm64"
      sha256 "e2ce57cb7d47a26a8716aa416e5505bfa987705e1de6a4ef8364b2eae1a59bbf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-arm64"
      sha256 "ff3a37c8b0bf2cc42da9261291cb78a8d326de92f2951a4340166a3114c59cb4"
    else
      url "https://github.com/audivir/mkpasswd-go/releases/download/v#{version}/mkpasswd-go-linux-amd64"
      sha256 "e80a42f99b3b0501d82fb98a7bb0c3cf3c912d6873e1b787f009e0cbb2374796"
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
    assert_match "dirdiff version #{version}", shell_output("#{bin}/dirdiff --version")
  end
end
