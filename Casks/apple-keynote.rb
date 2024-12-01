cask "apple-keynote" do
    version :latest
    sha256 :no_check
  
    name "Apple Keynote"
    desc "Presentation application by Apple"
    homepage "https://apps.apple.com/us/app/keynote/id409183694"
    url "https://apps.apple.com/us/app/keynote/id409183694"
  
    depends_on formula: "mas"
  
    installer script: {
      executable: "/opt/homebrew/bin/mas",
      args: ["install", "409183694"],
    }
  
    uninstall delete: "/Applications/Keynote.app"
  
    caveats <<~EOS
      Apple Keynote is installed via the Mac App Store using the 'mas' CLI.
      Ensure that you are signed into the Mac App Store with an account that has access to download the app.
    EOS
  end
  