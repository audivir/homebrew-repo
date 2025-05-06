 cask "skyx" do
    version "25.2.1"
    sha256 "d9273453ff777262ed21cff4ca3bfd210c6cc0ae890205e6fc11d53fb121fadb"

    url "https://desktopclient.ott.sky.com/skygodesktop/AT/SkyXInstaller.zip"
    name "Sky X Desktop"
    desc "Streaming service from Sky AT"
    homepage "https://www.skyx.at/"

    auto_updates true

    installer manual: "SkyXInstaller.app"
    uninstall quit: "com.bskyb.skyxplayer",
                delete: "~/Applications/Sky X.app"
end
