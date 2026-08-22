class Uvc < Formula
    desc "Conda-like wrapper for uv"
    homepage "https://github.com/audivir/uvc"
    url "https://github.com/audivir/uvc.git",
        tag:      "v0.1.1",
        revision: "8f8ac1626ec4a062d7073a855ca069e513aa48e4"
    license "MIT"

    def install
        bin.install "uvc"
    end

    def caveats
      <<~EOS
        Please run the following to setup your shell:
          #{bin}/uvc shellenv <zsh|bash> >> <~/.zshrc|~/.bashrc>
        and restart your terminal.
      EOS
    end

    test do
        expected="Usage: uvc {create|remove|activate|install|uninstall|list|envs} [options]"
        assert_match expected, shell_output(bin/"uvc", 1)
    end
end
