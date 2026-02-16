class Pdfium < Formula
  desc "Binary distribution of PDFium (without V8)"
  homepage "https://github.com/bblanchon/pdfium-binaries"
  license "Apache-2.0"
  version "7678" 

  on_macos do
    on_arm do
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-arm64.tgz"
      sha256 "80bf5fe0317b06c6ac771125d57a404c4f196d507287fecff63584900ef4953f"
    end
    on_intel do
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-x64.tgz"
      sha256 "80ff74fda755237de1df2feda6972aafbd82828be23836093c5708063c815af8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-arm64.tgz"
      sha256 "2e8a639a3c80e19d61b193177d588069f05c8d91724f5ca53b8a3abd12dea11a"
    end
    on_intel do
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-x64.tgz"
      sha256 "80ff74fda755237de1df2feda6972aafbd82828be23836093c5708063c815af8"
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
