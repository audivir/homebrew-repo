class Findcopies < Formula
  desc "Recursively find copies of files in a directory"
  homepage "https://github.com/audivir/findcopies"
  version "0.1.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/findcopies/releases/download/v#{version}/findcopies-darwin-arm64"
      sha256 "9803afcab1d4cab50997cea1ef25b9777b07003cdfb021ba80a5310cdad7c7bf"
    else
      url "https://github.com/audivir/findcopies/releases/download/v#{version}/findcopies-darwin-amd64"
      sha256 "25f1240a29bb4dbc8bc592c7322b3fb84f5cc7714a29c695887c3980a90b4682"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/audivir/findcopies/releases/download/v#{version}/findcopies-linux-arm64"
      sha256 "1cf2acccd283a9f8d0b6fcfd521691d525491995a47433cb73212b99c0e3d817"
    else
      url "https://github.com/audivir/findcopies/releases/download/v#{version}/findcopies-linux-amd64"
      sha256 "6bd03300b9faef679ecfb34059ed6290100178581b1d86cd123697bc3c26ba55"
    end
  end

  def install
    # Rename to just 'findcopies'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "findcopies-darwin-arm64" : "findcopies-darwin-amd64"
    else
      Hardware::CPU.arm? ? "findcopies-linux-arm64" : "findcopies-linux-amd64"
    end

    bin.install binary_name => "findcopies"
  end

  test do
    # Updated to match our latest usage text
    assert_match "findcopies version #{version}", shell_output("#{bin}/findcopies --version")
  end
end
