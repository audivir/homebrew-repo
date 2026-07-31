class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  version "2.8.1-1"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-arm64.tar.bz2"
      sha256 "cf94f0d56cd38393ccbe12543e0378f77e6581dee8c4428d1fc563a859a0b070"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-64.tar.bz2"
      sha256 "cd3c10cec65704c0a96195b46002d45350d0dd43a52d940e9dc17c517b7ee439"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-aarch64.tar.bz2"
      sha256 "daa4d5c7c5d688ce0deed4ff7887a4ff95429c89d80c76e39ab1ee3d5f66b913"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-64.tar.bz2"
      sha256 "8528263837623551a44464a372e5bd6b0b856479a83d2a77490a19dd98da3b06"
    end
  end

  def install
    bin.install "bin/micromamba" => "micromamba"
  end

  def caveats
    <<~EOS
      Please run the following to setup your shell:
        #{opt_bin}/micromamba shell init --shell <your-shell> --root-prefix ~/mamba
      and restart your terminal.
    EOS
  end

  test do
    ENV["MAMBA_ROOT_PREFIX"] = testpath.to_s

    assert_match version.to_s, shell_output("#{bin}/mamba --version").strip
    assert_match version.to_s, shell_output("#{bin}/micromamba --version").strip

    # Using 'xtensor' (header-only package) to avoid "broken pipe" codesigning issue
    # encountered on macOS 13-arm and 14-arm during CI.
    system bin/"mamba", "create", "-n", "test", "xtensor", "-y", "-c", "conda-forge"
    assert_path_exists testpath/"envs/test/include/xtensor.hpp"
  end
end
