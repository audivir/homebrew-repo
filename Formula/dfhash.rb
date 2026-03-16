class Dfhash < Formula
  desc "Deterministic content hasher for tabular data files"
  homepage "https://github.com/audivir/dfhash"
  version "0.1.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-darwin-arm64"
      sha256 "4b6646675970b10499755bbed4ea7c5d159187d52f3c81619335e5b3826bc3ea"
    else
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-darwin-amd64"
      sha256 "e0fe2d74d2e706e14626e88c0cfe4978462b234383cd15a662dee2d6392b9c62"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-linux-arm64"
      sha256 "b70b2bca5d9b98e05572f23fe21fe30afc038a2c616ed319c586a15b3d27ef0b"
    else
      url "https://github.com/audivir/dfhash/releases/download/v#{version}/dfhash-linux-amd64"
      sha256 "9abba4b4a82cce109b957f39bd556e5dee61f9ba2b51ae6e86ee8c0de6ee1179"
    end
  end

  def install
    # Rename to just 'dfhash'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "dfhash-darwin-arm64" : "dfhash-darwin-amd64"
    else
      Hardware::CPU.arm? ? "dfhash-linux-arm64" : "dfhash-linux-amd64"
    end

    bin.install binary_name => "dfhash"
  end

  test do
    assert_match "dfhash #{version}", shell_output("#{bin}/dfhash --version")
  end
end
