class Smc < Formula
  desc "Control the fans of every Intel Mac to make it run cooler"
  homepage "https://github.com/hholtmann/smcFanControl"
  url "https://github.com/hholtmann/smcFanControl/archive/refs/tags/2.6.tar.gz"
  version "0.01"
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
    assert_match "0.01", shell_output("#{bin}/smc -v", 1)
  end
end
