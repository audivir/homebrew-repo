class MkpasswdGo < Formula
    desc "Go-clone of whois' mkpasswd utility"
    homepage "https://github.com/audivir/mkpasswd-go"
    url "https://github.com/audivir/mkpasswd-go.git",
        tag:      "v1.0.0",
        revision: "098c0653602768813f8fba594d59893a35fbbc5a"
    license "MIT"

    depends_on "go" => :build

    on_macos do
        depends_on "libxcrypt"
    end

    def install
        if OS.mac?
            ENV.append "CPATH", Formula["libxcrypt"].opt_include
            ENV.append "LIBRARY_PATH", Formula["libxcrypt"].opt_lib
        end
        system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", "mkpasswd-go"
        bin.install "mkpasswd-go"
    end

    test do
        assert_match "mkpasswd version mkpasswd-go 1.0", shell_output("#{bin}/mkpasswd-go -v")
    end
end
