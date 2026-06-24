class Libpdfium < Formula
  desc "Binary distribution of PDFium (without V8)"
  homepage "https://github.com/bblanchon/pdfium-binaries"
  version "7906"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-arm64.tgz"
      sha256 "d7179c5667c6ff5032a4e57840df642e094c101f464ec18aabb0ea22fb722f8e"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-x64.tgz"
      sha256 "e15aefb3ed4e86e9bd0b33701b02b6e77c9a6ed51cc53a51f1dd9f5d6a0bd82a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-arm64.tgz"
      sha256 "a188262ab444d43e6030ffabc8b03a7d3a4e3b1146ecbfb030af42f402ee0cff"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-x64.tgz"
      sha256 "e07bc44c4e422c50eb01da742dc1ec59ad6780ce64ed91955533da8e9fe1a363"
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
