#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions
# MUST BE CALLED FROM THE APP DIRECTORY

. ../DominionIndex/lib-util.sh
. ../DominionIndex/lib-card.sh

msg "generating game: Antiquities fan expansion"
html_begin 'Antiquities'
cat << EOF
      <div class="w3-center">
         <img class="w3-margin"
              src="games/antiquities/box.jpg" alt="Antiquities fan expansion">
         <details>
            <summary>about</summary>
EOF
cat  'games/antiquities/README.md'
echo '   </details>'
echo '</div>'

echo '<h1>Supply: Kingdoms + Boulder Trap</h1>'
card_row  antiquities#graveyard    antiquities#discovery  antiquities#gamepiece antiquities#gravewatcher antiquities#inscription
card_row  antiquities#inspector    antiquities#miner      antiquities#profiteer antiquities#shipwreck    antiquities#tombraider
card_row  antiquities#aquifer      antiquities#collector  antiquities#curio     antiquities#mendicant    antiquities#moundbuildervillage
card_row  antiquities#snakecharmer antiquities#stoneworks antiquities#agora     antiquities#mastermind   antiquities#missionhouse
card_row  antiquities#pyramid      antiquities#stronghold antiquities#encroach  antiquities#mausoleum    antiquities#archaeologist
card_row  antiquities#dig          antiquities#pharaoh    ''                    ''                       antiquities#bouldertrap
html_end
echo '<h1>Material from Dominion</h1>'
card_lrow vptoken victorymat exilemat
