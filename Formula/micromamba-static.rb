class MicromambaStatic < Formula
  desc "Fast Cross-Platform Package Manager"
  homepage "https://github.com/mamba-org/mamba"
  license "BSD-3-Clause"
  version "2.3.0"# head "https://github.com/mamba-org/mamba.git", branch: "main"

  on_linux do
    on_arm do
  	  url "https://micro.mamba.pm/api/micromamba/linux-aarch64/latest"
      sha256 "9c7262a340c8aedaec668f0cd47e8bdd663087222fe4b39282bf3d52a52a39b8"
    end
    on_intel do
      url "https://micro.mamba.pm/api/micromamba/linux-64/latest"
      sha256 "0669b73f6cb21548f76c4c2aa416b2e1ec397d3f987b73c558ebfc89dd5c9f8c"
    end
  end
  on_macos do
    on_arm do
  	  url "https://micro.mamba.pm/api/micromamba/osx-arm64/latest"
      sha256 "f8a21556f5f085e81d816961d6d9773d31293da17ca27500b1e1f5c899070321"
    end
    on_intel do
      url "https://micro.mamba.pm/api/micromamba/osx-64/latest"
      sha256 "da60f2e2aa9f835bee6586d6b58e64caa14f9a06014331316f551f2c78444f7f"
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
