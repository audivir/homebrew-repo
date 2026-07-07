class Libpdfium < Formula
  desc "Binary distribution of PDFium (without V8)"
  homepage "https://github.com/bblanchon/pdfium-binaries"
  version "7934"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-arm64.tgz"
      sha256 "24815e8986a85e1ce5553027fc2e038c21d61310665ffdf849625994cc43819c"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-x64.tgz"
      sha256 "7aace004650a5933467c100956bd39feeb36c28d92660dbf0326ad10022f48e9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-arm64.tgz"
      sha256 "a5ea0edd14b9e352a96f47c9484ebbd24af8dfcadc0f0cb9a199b832d815e75e"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-x64.tgz"
      sha256 "60975aea26c0c6e2f0e0ca3e3c55d184085362f78ac689e4cba2d7d7997920bb"
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
