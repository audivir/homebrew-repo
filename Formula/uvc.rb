class Uvc < Formula
    desc "Conda-like wrapper for uv"
    homepage "https://github.com/audivir/uvc"
    url "https://github.com/audivir/uvc.git",
        tag:      "v0.1.2",
        revision: "08c5abd9987c735067196be5d15843d7a21e101e"
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
