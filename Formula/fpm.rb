class Fpm < Formula
  desc "Effing Package Management! Build packages for multiple platforms easily"
  homepage "https://github.com/jordansissel/fpm"
  url "https://github.com/jordansissel/fpm/archive/refs/tags/v1.17.0.tar.gz"
  sha256 "006abf20b88261a96a64adf473d78f1bd4361265d909b2357cb506629258dd06"
  license "MIT"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "#{name}-#{version}.gem", "--no-document"

    bin.install libexec/"bin/fpm"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fpm --version")
  end
end
