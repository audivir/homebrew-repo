class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  version "2.6.0"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/osx-arm64/micromamba-#{version}-2.tar.bz2"
      sha256 "7c7bb56ba2fc7569eb2821828e8a42e64725b61a4bf00868d553752e832fab61"
    else
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/osx-64/micromamba-#{version}-2.tar.bz2"
      sha256 "7c7bb56ba2fc7569eb2821828e8a42e64725b61a4bf00868d553752e832fab61"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/linux-aarch64/micromamba-#{version}-2.tar.bz2"
      sha256 "7c7bb56ba2fc7569eb2821828e8a42e64725b61a4bf00868d553752e832fab61"
    else
      url "https://api.anaconda.org/download/conda-forge/micromamba/#{version}/linux-64/micromamba-#{version}-2.tar.bz2"
      sha256 "7c7bb56ba2fc7569eb2821828e8a42e64725b61a4bf00868d553752e832fab61"
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
