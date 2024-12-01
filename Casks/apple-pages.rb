cask "apple-pages" do
    version :latest
    sha256 :no_check
  
    name "Apple Pages"
    desc "Word processor and page layout application by Apple"
    homepage "https://apps.apple.com/us/app/pages/id409201541"
    url "https://apps.apple.com/us/app/pages/id409201541"

    depends_on formula: "mas"
  
    # Install Pages via mas
    installer script: {
      executable: "/opt/homebrew/bin/mas",
      args: ["install", "409201541"],
    }
  
    # Uninstall Pages by removing the application bundle
    uninstall delete: "/Applications/Pages.app"
  
    caveats <<~EOS
      Apple Pages is installed via the Mac App Store using the 'mas' CLI.
      Ensure that you are signed into the Mac App Store with an account that has access to download the app.
    EOS
  end
  