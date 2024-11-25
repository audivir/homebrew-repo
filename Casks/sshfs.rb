cask "sshfs" do
    version "2.5.0"
    sha256 "f8f4f71814273ea42dbe6cd92199f7cff418571ffd1b10c0608878d3472d2162"

    desc "File system client based on SSH File Transfer Protocol"
    homepage "https://osxfuse.github.io/"
    url "https://github.com/osxfuse/sshfs/releases/download/osxfuse-sshfs-$VERSION/sshfs-#{version}.pkg"


    pkg "sshfs-#{version}.pkg"

    uninstall pkgutil: "com.github.osxfuse.pkg.SSHFS",
            delete:  [
                        "/usr/local/bin/sshfs",
                        "/usr/local/share/man/man1/sshfs.1"
                        ]

    caveats do
    <<~EOS
        SSHFS has been installed. You might need to restart your computer for the changes to take effect.
        You can mount a remote file system using the following command:
        
        sshfs user@hostname:/remote/path /local/mount/point
    EOS
    end
end