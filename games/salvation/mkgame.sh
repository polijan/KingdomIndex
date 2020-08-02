#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions
# MUST BE CALLED FROM THE APP DIRECTORY

. ../DominionIndex/lib-util.sh
. ../DominionIndex/lib-card.sh

msg 'generating game: Salvation fan expansion'
html_begin 'Salvation'
cat << EOF
    <div class="w3-center">
       <img class="w3-margin w3-border-indigo" style="border-style:solid; border-width:15px"
            src="games/salvation/box.jpg" alt="Salvation fan expansion">

       <details>
          <summary>about</summary>
EOF
cat  'games/salvation/README.md'
echo '  </details>'
echo '</div>'

echo '<h1>Kingdom Cards</h1>'
card_row  salvation#alms        salvation#edict      salvation#mass       salvation#mendicant   salvation#belltower
card_row  salvation#graverobber salvation#monk       salvation#priest     salvation#prophet     salvation#scriptorium
card_row  salvation#catacombs   salvation#cathedral  salvation#darkritual salvation#heretic     salvation#mausoleum
card_row  salvation#pagan       salvation#tithe      salvation#assassin   salvation#baptistry   salvation#crusader
card_row  salvation#cultist     salvation#indulgence salvation#inquisitor salvation#archibishop ''

echo '<h1>Sins Tokens + Cheatsheet</h1>'
card_row  '' salvation#sintoken '' salvation#sinscheatsheet ''
html_end
