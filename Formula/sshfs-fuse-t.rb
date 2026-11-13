class SshfsFuseT < Formula
  desc "File system client based on SSH File Transfer Protocol"
  homepage "https://github.com/macos-fuse-t/sshfs/"
  url "https://github.com/macos-fuse-t/sshfs.git",
    revision: "6f2908b8d80fed0f52a7f8bbe440b166a86c1c42"
  version "1.0.2"
  license "GPL-2.0-or-later"
  revision 1

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build # static libintl
  depends_on "glib" => :build # static libglib/libgthread
  depends_on "pcre2" => :build # static libpcre2-8 (glib dependency)
  depends_on "pkgconf" => :build

  conflicts_with "sshfs", because: "it installs the same binaries"

  def install
    # check if fuse-t is installed else die
    unless File.exist?("/usr/local/lib/libfuse-t.dylib")
      odie "fuse-t is not installed. Please install it first: brew install --cask fuse-t"
    end

    ENV.prepend_path "PKG_CONFIG_PATH", formula_opt_lib("glib")/"pkgconfig"
    ENV.append_path "HOMEBREW_LIBRARY_PATHS", "/usr/local/lib"
    ENV.append_path "HOMEBREW_INCLUDE_PATHS", "/usr/local/include"
    ENV.append_path "PKG_CONFIG_PATH", "/usr/local/lib/pkgconfig"

    system "autoreconf", "-vfi"

    system "./configure",
           "--prefix=#{prefix}",
           "--disable-dependency-tracking"

    # Link glib, gettext and pcre2 statically so there is no runtime
    # dependency on them. fuse-t stays dynamic (added by Makefile.am).
    static_libs = [
      formula_opt_lib("glib")/"libgthread-2.0.a",
      formula_opt_lib("glib")/"libglib-2.0.a",
      formula_opt_lib("gettext")/"libintl.a",
      formula_opt_lib("pcre2")/"libpcre2-8.a",
    ].map(&:to_s)
    frameworks = %w[Foundation CoreFoundation AppKit Carbon].flat_map { |f| ["-framework", f] }

    system "make", "SSHFS_LIBS=#{[*static_libs, "-liconv", "-lm", *frameworks].join(" ")}"
    system "make", "install"

    MachO::Tools.change_install_name(bin/"sshfs",
                                     "@rpath/libfuse-t.dylib",
                                     "/usr/local/lib/libfuse-t.dylib")
    MachO.codesign!(bin/"sshfs") if Hardware::CPU.arm?
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
