class Libpdfium < Formula
  desc "Binary distribution of PDFium (without V8)"
  homepage "https://github.com/bblanchon/pdfium-binaries"
  version "8057"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-arm64.tgz"
      sha256 "013ecc9e0a155dabb8dd006a73a028ea542965f80a4990e5f013de283b0e58a6"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-mac-x64.tgz"
      sha256 "d726dc3d81445555f92bbee44577c53a9fb6425e1194cfd630403d6840d9ecbf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-arm64.tgz"
      sha256 "172094db7a92e0449339cb3a753668bcb26280dd484ea07fe98f61508f1409fa"
    else
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/#{version}/pdfium-linux-x64.tgz"
      sha256 "7788fa57a2996ebd21afc4090eb0a42b9f95ef3a72e7ef4c0756f1ea703c0415"
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
