class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  version "2.6.1-0"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-arm64.tar.bz2"
      sha256 "584c8841d2242f4725456366081411686db8579774d3a7708e9bfaff83e773d7"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-64.tar.bz2"
      sha256 "3e31746ed16a7f4cfecd242e5f59453482537e26895e7e8c8db3270df682d2d2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-aarch64.tar.bz2"
      sha256 "4ac51434e71956451e190cef222be5be5dd7fe7eb93a865380dd7f00f4c956b4"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-64.tar.bz2"
      sha256 "dbc83e3f20aec0cb7fe1082f13d7472dad5dbe67b28b9a7cc555d6982992ff03"
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
