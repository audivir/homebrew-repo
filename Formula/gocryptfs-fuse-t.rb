class GocryptfsFuseT < Formula
  desc "Encrypted overlay filesystem written in Go (FUSE-T build)"
  homepage "https://github.com/audivir/gocryptfs"
  # gocryptfs v2.7.0 + listxattr fix + fuse.Caller port; go.mod replaces
  # go-fuse with audivir/go-fuse (upstream 6018575 + FUSE-T support).
  url "https://github.com/audivir/gocryptfs.git",
    tag:      "v2.7.0-fuset2",
    revision: "7e6680927e60e4c523c35d45950dc793a74fb7da"
  version "2.7.0"
  license "MIT"

  depends_on "go" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@3"

  conflicts_with "gocryptfs", because: "it installs the same binaries"

  def install
    # check if fuse-t is installed else die
    unless File.exist?("/usr/local/lib/libfuse-t.dylib")
      odie "fuse-t is not installed. Please install it first: brew install --cask fuse-t"
    end

    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@3"].opt_lib/"pkgconfig"
    system "bash", "build.bash"
    bin.install "gocryptfs"
  end

  test do
    assert_match "gocryptfs v#{version}", shell_output("#{bin}/gocryptfs --version")
  end
end
