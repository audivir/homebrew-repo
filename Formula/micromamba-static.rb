class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  version "2.6.0-0"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-arm64.tar.bz2"
      sha256 "8c819bad89f1ef042bc7b62700d7e6ca5cb3a48b0b0ba7825623d2cb2a0a1805"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-64.tar.bz2"
      sha256 "d7854bf8b801f76e26d19130e61d6c63bd12f0a4ba7711679cb49322dad131f0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-aarch64.tar.bz2"
      sha256 "638e15fbb30b12f763d3383be2ee765274717a8a2551f30ad8d9e77f4fe54458"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-64.tar.bz2"
      sha256 "f9d82a01e954e19bfc57566f574cdd25f1f6b14cfbee9346544e0850114a01f5"
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
