class BindfsFuseT < Formula
  desc "Mount a directory to another location with altered permissions"
  homepage "https://bindfs.org/"
  # Change URL to point to GitHub and specify the tag
  url "https://github.com/mpartel/bindfs.git",
      tag: "1.18.3",
      revision: "91fbfa48427c67f59c24e84f3855507531ba972c"
  license "GPL-2.0-or-later"

  # Add HEAD URL for cloning the main branch
  head "https://github.com/mpartel/bindfs.git", branch: "main"

  conflicts_with "bindfs", because: "it installs the same binaries"

  # We need pkg-config to find fuse-t
  depends_on "pkg-config" => :build
  # Add build dependencies for running ./autogen.sh
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  # depends_on "libtool" => :build

  # As per the README, fuse-t is the dependency for macOS
  depends_on "fuse-t"

  def install
    # We need to run ./autogen.sh when building from git
    system "./autogen.sh"
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    # Check if the binary runs and reports its version
    system "#{bin}/bindfs", "--version"
  end
end

