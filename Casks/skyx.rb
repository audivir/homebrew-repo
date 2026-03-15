cask "skyx" do
    version "26.1.2"
    sha256 "823f192eb0bb505b8f69b65ee16ba35d9e35ef2159fbe68266d19048ec7faeee"

    url "https://desktopclient.ott.sky.com/skygodesktop/AT/SkyXInstaller.zip",
      verified: "desktopclient.ott.sky.com"
    name "Sky X Desktop"
    desc "Streaming service from Sky AT"
    homepage "https://www.skyx.at/"

    auto_updates true

    installer manual: "SkyXInstaller.app"
    uninstall quit: "com.bskyb.skyxplayer",
                delete: "~/Applications/Sky X.app"
end