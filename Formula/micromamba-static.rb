class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  version "2.10.0-0"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-arm64.tar.bz2"
      sha256 "acef4eaab19ec2174ad5a449e5aad981ca326270db819502ff096a92fc31caa6"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-osx-64.tar.bz2"
      sha256 "17b20c4271d65c030a5c86788f5ca86eb575187209f626edabdb8c6a875c6838"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-aarch64.tar.bz2"
      sha256 "890bc4906e6ab17f1b393f0da21547f75e000078e573a156316ec925b92a4a4c"
    else
      url "https://github.com/mamba-org/micromamba-releases/releases/download/#{version}/micromamba-linux-64.tar.bz2"
      sha256 "9a97976244929bbae28fb1fae504e74a3e7e6d1932870e3a03321f01b7fbd07b"
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
