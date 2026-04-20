class SshfsFuseT < Formula
  desc "File system client based on SSH File Transfer Protocol"
  homepage "https://github.com/macos-fuse-t/sshfs/"
  url "https://github.com/macos-fuse-t/sshfs.git",
    tag:      "1.0.2",
    revision: "bb7d6ca32b81f7c09abc271f4eb63c88d445ad81"
  license "GPL-2.0-or-later"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  depends_on "gettext"
  depends_on "glib"

  conflicts_with "sshfs", because: "it installs the same binaries"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["glib"].opt_lib/"pkgconfig"
    ENV.append_path "HOMEBREW_LIBRARY_PATHS", "/usr/local/lib"
    ENV.append_path "HOMEBREW_INCLUDE_PATHS", "/usr/local/include"
    ENV.append_path "PKG_CONFIG_PATH", "/usr/local/lib/pkgconfig"

    # check if fuse-t is installed else die
    unless File.exist?("/usr/local/lib/libfuse-t.dylib")
      odie "fuse-t is not installed. Please install it first: brew install --cask fuse-t"
    end

    system "autoreconf", "-vfi"

    system "./configure",
           "--prefix=#{prefix}",
           "--disable-dependency-tracking"

    system "make"
    system "make", "install"

    system "install_name_tool",
           "-change",
           "@rpath/libfuse-t.dylib",
           "/usr/local/lib/libfuse-t.dylib",
           bin/"sshfs"
  end

  def caveats
    <<~EOS
      SSHFS has been installed. You might need to restart your computer for the changes to take effect.
      You can mount a remote file system using the following command:

      sshfs user@hostname:/remote/path /local/mount/point
    EOS
  end

  test do
    assert_match "SSHFS version", shell_output("#{bin}/sshfs --version")
  end
end
