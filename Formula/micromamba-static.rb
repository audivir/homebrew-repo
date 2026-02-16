class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  version "2.5.0"
  license "BSD-3-Clause"

  on_linux do
    on_arm do
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/linux-aarch64/micromamba-#{version}-2.tar.bz2"
      sha256 "6ec1517c8c89c875a8fa93f9c66abd4fe3dd147341376bdc37b57c526bc13e44"
    end
    on_intel do
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/linux-64/micromamba-#{version}-2.tar.bz2"
      sha256 "cec496f2299f9ceb5f5e23fc2ccf081fffda0c4bc87a6fdab575bf1e04f103b6"
    end
  end
  on_macos do
    on_arm do
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/osx-arm64/micromamba-#{version}-2.tar.bz2"
      sha256 "74d1f250b1505cd4d78728bd8b0b7f0ffbaa660b18042f15f7b610c16102d201"
    end
    on_intel do
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/osx-64/micromamba-#{version}-2.tar.bz2"
      sha256 "2d6ab968ba08c003e43642f55afded1f0fc4247387f04e340cdc6a0129d9c550"
    end
  end

  def install    # but as of 2.0 they provide identical interfaces.
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
