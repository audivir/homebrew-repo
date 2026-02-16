class Dirdiff < Formula
    desc "Compare two directories recursively"
    homepage "https://github.com/audivir/dirdiff"
    url "https://github.com/audivir/dirdiff.git",
        tag:      "v0.1.0",
        revision: "2bd1ea40f99a0eb0ce69e1a789ac14bab13550bb"
    license "MIT"

    depends_on "go" => :build

    def install
        system "go", "build", "-o", "dirdiff", "github.com/audivir/dirdiff"
        bin.install "dirdiff"
    end

    test do
        expected="Error: usage: dirdiff [options] <dirA> <dirB>"
        assert_match expected, shell_output(bin/"dirdiff", 2)
    end
end
