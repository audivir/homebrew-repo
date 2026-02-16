class Findcopies < Formula
    desc "Recursively find copies of files in a directory"
    homepage "https://github.com/audivir/findcopies"
    url "https://github.com/audivir/findcopies.git",
        tag:      "v0.1.0",
        revision: "fea0862b5908c854b716a140e2bd39a12246b8ad"
    license "MIT"

    depends_on "go" => :build

    def install
        system "go", "build", "-o", "findcopies", "github.com/audivir/findcopies"
        bin.install "findcopies"
    end

    test do
        assert_match "findcopies [global options]", shell_output("#{bin}/findcopies -h")
    end
end
