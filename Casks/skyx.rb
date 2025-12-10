 cask "skyx" do
    version "25.5.2"
    sha256 "e2dddb92a97f2a2dc43920d3e660bb03e52b6e465149312ed21f104ad118de92"

    url "https://desktopclient.ott.sky.com/skygodesktop/AT/SkyXInstaller.zip"
    name "Sky X Desktop"
    desc "Streaming service from Sky AT"
    homepage "https://www.skyx.at/"

    auto_updates true

    installer manual: "SkyXInstaller.app"
    uninstall quit: "com.bskyb.skyxplayer",
                delete: "~/Applications/Sky X.app"
end
