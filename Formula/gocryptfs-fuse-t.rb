class GocryptfsFuseT < Formula
  desc "Encrypted overlay filesystem written in Go"
  homepage "https://github.com/rfjakob/gocryptfs/"
  url "https://github.com/rfjakob/gocryptfs.git",
    tag:      "v2.0",
    revision: "c0e75302166c9a166526586690086dcd16eff2c2"
  license "MIT"

  depends_on "go" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@3"

  on_macos do
    depends_on "libxcrypt"
  end

  conflicts_with "gocryptfs", because: "it installs the same binaries"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@3"].opt_lib/"pkgconfig"
    # check if fuse-t is installed else die
    unless File.exist?("/usr/local/lib/libfuse-t.dylib")
      odie "fuse-t is not installed. Please install it first: brew install --cask fuse-t"
    end
    system "go", "mod", "edit", "-replace", "github.com/hanwen/go-fuse/v2=github.com/macos-fuse-t/go-fuse/v2@5340a18"
    system "go", "mod", "tidy"
    system "bash", "build.bash"
    bin.install "gocryptfs"
  end

  test do
    assert_match "gocryptfs v#{version}-dirty.HEAD", shell_output("#{bin}/gocryptfs --version")
  end
end
