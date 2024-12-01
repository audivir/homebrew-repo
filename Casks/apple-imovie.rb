cask "apple-imovie" do
    version :latest
    sha256 :no_check
  
    name "Apple iMovie"
    desc "Video editing application by Apple"
    homepage "https://apps.apple.com/us/app/imovie/id408981434"
    url "https://apps.apple.com/us/app/imovie/id408981434"

    depends_on formula: "mas"
  
    installer script: {
      executable: "/opt/homebrew/bin/mas",
      args: ["install", "408981434"],
    }
  
    uninstall delete: "/Applications/iMovie.app"
  
    caveats <<~EOS
      Apple iMovie is installed via the Mac App Store using the 'mas' CLI.
      Ensure that you are signed into the Mac App Store with an account that has access to download the app.
    EOS
  end
  