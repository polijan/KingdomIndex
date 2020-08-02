#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions
# MUST BE CALLED FROM THE APP DIRECTORY

. ../DominionIndex/lib-util.sh
. ../DominionIndex/lib-card.sh

msg 'generating game: Fairy Tale fan expansion'
html_begin 'Fairy Tale'
cat << EOF
    <div class="w3-center">
       <img class="w3-margin"
            src="games/fairytale/box1.jpg" alt="Fairy Tale fan expansion">

       <details>
          <summary>about</summary>
EOF
cat  'games/fairytale/README.md'
echo '  </details>'
echo '</div>'

echo '<h1>Kingdom Cards</h1>'
card_row  fairytale#magicbeans  fairytale#bridgetroll     fairytale#soothsayer fairytale#lostvillage fairytale#magicmirror
card_row  fairytale#quest       fairytale#storybook       fairytale#werewolf   fairytale#druid       fairytale#dryad
card_row  fairytale#hedgewizard fairytale#masterhuntsman  fairytale#dragon     fairytale#goldentouch fairytale#tinker
card_row  ''                    fairytale#enchantedpalace fairytale#forestfolk fairytale#sorceress   ''

echo '<h1>Tokens</h1>'
card_row  '' '' fairytale#trolltoken '' ''
html_end
