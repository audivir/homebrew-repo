cask "apple-garageband" do
    version :latest
    sha256 :no_check
  
    name "Apple GarageBand"
    desc "Digital audio workstation by Apple"
    homepage "https://apps.apple.com/us/app/garageband/id682658836"
    url "https://apps.apple.com/us/app/garageband/id682658836"

    depends_on formula: "mas"
  
    installer script: {
      executable: "/opt/homebrew/bin/mas",
      args: ["install", "682658836"],
    }
  
    uninstall delete: "/Applications/GarageBand.app"
  
    caveats <<~EOS
      Apple GarageBand is installed via the Mac App Store using the 'mas' CLI.
      Ensure that you are signed into the Mac App Store with an account that has access to download the app.
    EOS
  end
  