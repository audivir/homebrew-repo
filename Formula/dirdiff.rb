class Dirdiff < Formula
  desc "Recursively compare two local or ssh-remote directories"
  homepage "https://github.com/audivir/dirdiff"
  version "0.1.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-arm64"
      sha256 "784aa19de877071eb1968f97a2463aec488ca7b4d547acbbb175bd2986ec5c80"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-darwin-amd64"
      sha256 "8845e2d5e3a3533542d406b8a5650151aa4cfe35efccd89dddd4583bb00cecb5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-arm64"
      sha256 "eb6b83d86310a1c8f66da8de38b84f8ee2101560d58415b28a934957edc29de4"
    else
      url "https://github.com/audivir/dirdiff/releases/download/v#{version}/dirdiff-linux-amd64"
      sha256 "06e99df97f48b924fc251379cd6761023d23c1a529e82613340bffafde1159d2"
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
    assert_match "dirdiff version #{version}", shell_output("#{bin}/dirdiff --version")
  end
end
