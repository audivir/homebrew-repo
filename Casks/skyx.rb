 cask "skyx" do
    version "24.1.3-2"
    sha256 "dce31b764dc81916d303b674bc6ebef4fb8603636c0cc6f74f5c49a7d554f150"

    url "https://desktopclient.ott.sky.com/skygodesktop/AT/SkyXInstaller.zip"
    name "Sky X Desktop"
    desc "Streaming service from Sky AT"
    homepage "https://www.skyx.at/"

    auto_updates true

    installer manual: "SkyXInstaller.app"
    uninstall quit: "com.bskyb.skyxplayer",
                delete: "~/Applications/Sky X.app"
end