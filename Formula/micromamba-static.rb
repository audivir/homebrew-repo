class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  version "2.8.1-0"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-arm64.tar.bz2"
      sha256 "a28588c79e96436c2001c87e3b8360bf2eb5c380fb288871389197b9150caf0a"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-64.tar.bz2"
      sha256 "146abdea8793c6ccf1b8600ae2b03cf2a0f1506a2846eeafc34ae3ebe1123fe6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-aarch64.tar.bz2"
      sha256 "70c60a36609ee8bcc07a3a1a66b2c3a65cff7c1053466963437f1bda72e5210f"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-64.tar.bz2"
      sha256 "a934c3709c997feae403a27fd1e321c106d26ffa4f294800ffb11cbc9a3e8515"
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
