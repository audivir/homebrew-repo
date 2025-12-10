class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  license "BSD-3-Clause"
  version "2.4.0" # head "https://github.com/mamba-org/mamba.git", branch: "main"

  on_linux do
    on_arm do
  	  url "https://micro.mamba.pm/api/micromamba/linux-aarch64/latest"
      sha256 "9dd1e427bb173730d57a025a7536b3e036af8890b28f524b53f7a4b53e373ced"
    end
    on_intel do
      url "https://micro.mamba.pm/api/micromamba/linux-64/latest"
      sha256 "3dbcca4c4b3e64e2b0c7ca7121307e687b6c10ce7fe889f21d5c10d817f983a9"
    end
  end
  on_macos do
    on_arm do
  	  url "https://micro.mamba.pm/api/micromamba/osx-arm64/latest"
      sha256 "55754cabf1c892fd057251138559eda3464616639acab384264b45c4fbc6e8aa"
    end
    on_intel do
      url "https://micro.mamba.pm/api/micromamba/osx-64/latest"
      sha256 "89334976546685aa875a619643c0ef12a1269e6d8df66e6f8696d0a1c47af044"
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
