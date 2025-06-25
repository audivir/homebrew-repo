 cask "skyx" do
    version "25.3.3"
    sha256 "2f17f7c164abd0d0049ed364832bf6ef99ace3765397207c804b542a648d8e36"

    url "https://desktopclient.ott.sky.com/skygodesktop/AT/SkyXInstaller.zip"
    name "Sky X Desktop"
    desc "Streaming service from Sky AT"
    homepage "https://www.skyx.at/"

    auto_updates true

    installer manual: "SkyXInstaller.app"
    uninstall quit: "com.bskyb.skyxplayer",
                delete: "~/Applications/Sky X.app"
end
