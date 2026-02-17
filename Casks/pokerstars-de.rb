cask "pokerstars-de" do
  version :latest
  sha256 :no_check

  url "https://download.pokerstars.de/poker/client/download/"
  name "PokerStarsDE"
  desc "PokerStars ist die Heimat der spannendsten Pokerspiele"
  homepage "https://www.pokerstars.de/"

  container nested: "PokerStars/PokerStars.dmg"
  app "PokerStars.app"
end
