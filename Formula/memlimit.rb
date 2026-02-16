class Memlimit < Formula
    desc "Watches a process tree and terminates it if the memory reaches a limit"
    homepage "https://github.com/audivir/memlimit"
    url "https://github.com/audivir/memlimit.git",
        tag:      "v0.1.0",
        revision: "f1c4bab0ad31728fc8325ffc72a9409be65bb791"
    license "MIT"

    depends_on "go" => :build

    def install
        system "go", "build", "-o", "memlimit", "github.com/audivir/memlimit"
        bin.install "memlimit"
    end

    test do
        assert_match "memlimit 0.1.0", shell_output("#{bin}/memlimit -v")
    end
end
