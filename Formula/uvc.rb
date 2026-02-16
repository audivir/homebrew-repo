class Uvc < Formula
    desc "Conda-like wrapper for uv"
    homepage "https://github.com/audivir/uvc"
    url "https://github.com/audivir/uvc.git",
        revision: "eddc90dc6cc2c86b62e978a168d1b5e26216a192"
    license "MIT"

    def install
        bin.install "uvc"
    end

    test do
        expected="Usage: uvc {create|remove|activate|install|uninstall|list|envs} [options]"
        assert_match expected, shell_output("#{bin}/uvc", 1)
    end
end
