class Smc < Formula
  desc "CLI for reading/writing Apple System Management Controller (SMC) keys"
  homepage "https://github.com/hholtmann/smcFanControl"
  url "https://github.com/hholtmann/smcFanControl/archive/refs/tags/2.6.tar.gz"
  version "2.6"
  sha256 "2ede743d324367ddf8a1a2b83efcdb92bf2f14ed2c88c1d63dedfbc83f706cfa"
  license "GPL-2.0-or-later"

  def install
    cd "smc-command" do
      system ENV.cc, "-DCMD_TOOL_BUILD", "-c", "smc.c"
      system "make", "smc"
      bin.install "smc"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/smc -v", 1)
  end
end
