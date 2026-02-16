class BindfsFuseT < Formula
  desc "Mount a directory to another location with altered permissions"
  homepage "https://bindfs.org/"
  url "https://github.com/mpartel/bindfs.git",
      tag:      "1.18.3",
      revision: "91fbfa48427c67f59c24e84f3855507531ba972c"
  license "GPL-2.0-or-later"
  head "https://github.com/mpartel/bindfs.git", branch: "main"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build

  conflicts_with "bindfs", because: "it installs the same binaries"

  def install
    # check if fuse-t is installed else die
    if ! File.exist?("/usr/local/lib/libfuse-t.dylib")
      odie "fuse-t is not installed. Please install it first: brew install --cask fuse-t"
    end
    ENV.append_path "HOMEBREW_LIBRARY_PATHS", "/usr/local/lib"
    ENV.append_path "HOMEBREW_INCLUDE_PATHS", "/usr/local/include"
    ENV.append_path "PKG_CONFIG_PATH", "/usr/local/lib/pkgconfig"
    system "./autogen.sh"
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bindfs --version")
  end
end
