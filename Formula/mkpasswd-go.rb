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
        ENV["PKG_CONFIG_PATH"] = "#{opt_path}/libxcrypt/lib/pkgconfig" if OS.mac?
        system "go", "build", "-o", "mkpasswd-go", "github.com/audivir/mkpasswd-go"
        bin.install "mkpasswd-go"
    end

    test do
        assert_match "mkpasswd version mkpasswd-go 1.0", shell_output("#{bin}/mkpasswd-go -v")
    end
end
