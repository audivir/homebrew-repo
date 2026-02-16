class Smina < Formula
    desc "Fork of AutoDock Vina"
    homepage "http://pubs.acs.org/doi/abs/10.1021/ci300604z"
    url "https://altushost-swe.dl.sourceforge.net/project/smina/smina.osx.12"
    version "2021.12.01"
    sha256 "d2d9f5162f3e0e407376421d3f78cfc69d062f44bb0ea2d65ee1ae2bfacf418b"

    def install
        bin.install "smina.osx.12" => "smina"
    end

    test do
        system bin/"smina", "--version"
    end
end
