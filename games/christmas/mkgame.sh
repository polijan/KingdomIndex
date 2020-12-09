#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions
# MUST BE CALLED FROM THE APP DIRECTORY

. ../KingdomIndex/lib-util.sh
. ../KingdomIndex/lib-card.sh

msg "generating game: 'A Very Dominion Christmas' fan expansion"
html_begin 'A Very Dominion Christmas'
cat << EOF
      <div class="w3-center">
         <img class="w3-margin"
              src="games/christmas/box.jpg" alt="Christmas fan expansion">
         <details>
            <summary>about</summary>
EOF
cat  'games/christmas/README.md'
echo '   </details>'
echo '</div>'

echo '<h1>Kingdom Cards</h1>'
card_row  christmas#daysofchristmas christmas#elves         christmas#santasworkshop christmas#silentnight christmas#carolers
card_row  christmas#fruitcake       christmas#grinch        christmas#mistletoe      christmas#snowglobe   christmas#milkandcookies
card_row  christmas#reindeer        christmas#santasvillage christmas#sleighbells    christmas#stockings   christmas#unwrap
card_row  christmas#whiteelephant   christmas#wishlist      christmas#jollyoldelf    christmas#krampus     christmas#nutcracker
card_row  christmas#scrooge         christmas#snowman       christmas#sugarplumfairy christmas#chimney     christmas#christmastree

echo '<h1>Non-Supply</h1>'
echo '<h2>Treasures</h2>'
card_row  '' christmas#gift '' christmas#lumpofcoal ''
echo '<h2>Spirit - Ghosts of Christmas</h2>'
card_row  ''  christmas#ghostofchristmaspast  christmas#ghostofchristmaspresent  christmas#ghostofchristmasfuture  ''
echo '<h2>Days of Christmas</h2>'
card_row  '' christmas#partridgeinapeartree christmas#turtledoves   christmas#frenchhens     christmas#callingbirds
card_row  '' christmas#goldenrings          christmas#geesealaying  christmas#swansaswimming christmas#maidsamilking
card_row  '' christmas#ladiesdancing        christmas#lordsaleaping christmas#piperspiping   christmas#drummersdrumming

html_end
