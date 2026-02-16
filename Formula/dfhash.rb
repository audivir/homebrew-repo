class Dfhash < Formula
  desc "Deterministic content hasher for tabular data files"
  homepage "https://github.com/audivir/dfhash"
  url "https://github.com/audivir/dfhash.git",
      tag:      "v0.1.0",
      revision: "db4956982d21b9b0ce71c211f7e575d5b79e0be4"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "kv #{version}", shell_output("#{bin}/kv --version")
  end
end
