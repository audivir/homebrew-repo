class Dirdiff < Formula
  desc "Recursively compare two local or ssh-remote directories"
  homepage "https://github.com/audivir/dirdiff"
  version "2.0.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "b3818eb621e1bcf46e916468b6e761500fdb0e5f4a090bb77631fab8d37607a9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "847b02011ac7c0c8cacd661ff7195c7e831f4477a8d6b169e0e1c4da078599eb"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "4129cde11aeb060d25d8cf9d6987f5596aadf52caf42ec929944c3231a4ad0c3"
    end
  end

  def install
    # Rename to just 'dirdiff'
    binary_name = if OS.mac?
      "dirdiff-darwin-arm64"
    else
      Hardware::CPU.arm? ? "dirdiff-linux-arm64" : "dirdiff-linux-amd64"
    end

    bin.install binary_name => "dirdiff"
    chmod 0755, bin/"dirdiff"
    generate_completions_from_executable(bin/"dirdiff", "--gen-completions")
  end

  test do
    assert_match "dirdiff version v#{version}", shell_output("#{bin}/dirdiff --version")
  end
end
