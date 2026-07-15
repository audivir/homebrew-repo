class Libpdfium < Formula
  desc "Binary distribution of PDFium (without V8)"
  homepage "https://github.com/bblanchon/pdfium-binaries"
  version "7947"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-arm64.tgz"
      sha256 "aa9739354fc7bc8f200f3f3c9532bd5233298203051e094820272ccd9c997a77"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-x64.tgz"
      sha256 "16d7a263b9e2f550d230ce81637697381b0ce898f2e3a22c7316594b15199d87"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-arm64.tgz"
      sha256 "4af22363364962975d823979d07769581a4ca5d9a0d4a4117a06e5bb6d2c8e2d"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-x64.tgz"
      sha256 "f73d69d309fe1f33cc7269dcc99be31ec44e1cf608e31d7e2fcc6545fc2f9323"
    end
  end

  def install
    lib.install Dir["lib/*"]
    include.install Dir["include/*"]

    # Create a pkg-config file so other software can find it easily
    (lib/"pkgconfig/pdfium.pc").write <<~EOS
      prefix=#{prefix}
      exec_prefix=${prefix}
      libdir=${exec_prefix}/lib
      includedir=${prefix}/include

      Name: pdfium
      Description: PDF generation and rendering library
      Version: #{version}
      Libs: -L${libdir} -lpdfium
      Cflags: -I${includedir}
    EOS
  end

  test do
    # Simple test to verify the library can be linked against
    (testpath/"test.c").write <<~EOS
      #include <fpdfview.h>
      int main() {
        FPDF_InitLibrary();
        FPDF_DestroyLibrary();
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lpdfium", "-o", "test"
    system "./test"
  end
end
