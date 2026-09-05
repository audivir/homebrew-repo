cask "skyx" do
    version "26.1.2"
    sha256 "ac0c32ba60655db22ea27e5ea42cc3b6ce6d5b7959ddacca33f663c29f05cf4f"

    url "https://desktopclient.ott.sky.com/skygodesktop/AT/SkyXInstaller.zip"
    name "Sky X Desktop"
    desc "Streaming service from Sky AT"
    homepage "https://www.skyx.at/"

    auto_updates true

    installer manual: "SkyXInstaller.app"
    uninstall quit: "com.bskyb.skyxplayer",
                delete: "~/Applications/Sky X.app"
end
