class Dfhash < Formula
  desc "Deterministic content hasher for tabular data files"
  homepage "https://github.com/audivir/dfhash"
  url "https://github.com/audivir/dfhash.git",
      tag:      "v0.1.0",
      revision: "db4956982d21b9b0ce71c211f7e575d5b79e0be4"
  license "MIT"

  depends_on "rustup" => :build

  def install
    nightly_version = "nightly-2026-01-28"

    ENV["RUSTUP_HOME"] = buildpath/".rustup"
    ENV["CARGO_HOME"] = buildpath/".cargo"
    
    system "rustup", "toolchain", "install", nightly_version
    
    system "#{buildpath}/.cargo/bin/cargo", "+#{nightly_version}", "install", *std_cargo_args
  end

  test do
    assert_match "dfhash #{version}", shell_output("#{bin}/dfhash --version")
  end
end
