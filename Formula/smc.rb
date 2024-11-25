class Smc < Formula
    desc "Control the fans of every Intel Mac to make it run cooler"
    homepage "https://github.com/hholtmann/smcFanControl"
    url "https://github.com/hholtmann/smcFanControl/archive/refs/tags/2.6.tar.gz"
    sha256 "2ede743d324367ddf8a1a2b83efcdb92bf2f14ed2c88c1d63dedfbc83f706cfa"
    license "GPL"
  
    uses_from_macos "gcc" => [":build"]
    uses_from_macos "make" => [":build"]
  
    def install
      cd "smc-command" do
        system "gcc", "-DCMD_TOOL_BUILD", "-c" ,"smc.c"
        system "make", "smc"
      end
      bin.install "smc-command/smc"
    end
  
    test do
      system "#{bin}/smc", "--version"
    end
  end