cask "apple-numbers" do
    version :latest
    sha256 :no_check
  
    name "Apple Numbers"
    desc "Spreadsheet application by Apple"
    homepage "https://apps.apple.com/us/app/numbers/id409203825"
    url "https://apps.apple.com/us/app/numbers/id409203825"

    depends_on formula: "mas"
  
    installer script: {
      executable: "/opt/homebrew/bin/mas",
      args: ["install", "409203825"],
    }
  
    uninstall delete: "/Applications/Numbers.app"
  
    caveats <<~EOS
      Apple Numbers is installed via the Mac App Store using the 'mas' CLI.
      Ensure that you are signed into the Mac App Store with an account that has access to download the app.
    EOS
  end
  