cask "mestrenova" do
    version "14.3.3-33362"
    sha256 "36770803f0a17996cafa0dd4db29f09611d0a9ad41fa2496c59cf0fe365fa6d9"

    url "https://mestrelab.com/downloads/mnova/mac/MestReNova-#{version}.dmg"
    name "MestReNova"
    desc "A top class software suite to process your analytical chemistry data"
    homepage "https://mestrelab.com/software/mnova/"

    app "MestReNova.app"
end
