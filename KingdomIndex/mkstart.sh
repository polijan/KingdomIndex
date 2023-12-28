#!/bin/sh

# Usage: $0
# print the landing page
# (should be called from "app" directory)


################################################################################

expansions() {
   printf '  <a href="game-index.html" target="_blank"><strong>Index</strong></a>\n'

   local game
   local title
   for i in games/*; do
      [ -d "$i" ] || break
      title=$(basename "$i")
      page=game-unofficial-$title.html
      printf ' - <a href="%s" target="_blank">%s</a>\n' "$page" "$title"
   done
}

################################################################################

cat << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Kingdom Index</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="res/w3.css">
  <link rel="stylesheet" href="res/style.css">
</head>
<body class="w3-light-grey wood">
<div class="w3-content">
<div class="w3-container w3-center">
<!-- ------------------------------------------------------------- -->

<div class="w3-display-container w3-animate-zoom">
   <img src="res/shield.png" alt="shield">
   <h1 class="w3-display-middle w3-jumbo w3-text-deep-orange"
        style="text-shadow:3px 3px 0 #dde">
        Kingdom<br>Index
   </h1>
</div>


<div class="w3-cell-row w3-container">
   <div class="w3-cell w3-sand w3-card-4 w3-round-xlarge">
      <h1>Kingdom Index</h1>

      <p class="w3-large">
         <a href="board.html"
            target="_blank"
            class="w3-large w3-btn w3-ripple w3-hover-white w3-hover-text-blue w3-indigo w3-animate-left"
         >Current Board</a> &nbsp;
         <a href="board-generator.html"
            target="_blank"
            class="w3-large w3-btn w3-ripple w3-hover-white w3-hover-text-blue w3-blue w3-animate-right"
         >New Board</a>
      </p>
      <p><strong>tools</strong>:
                <a href="boon.html"        target="_blank">boons</a> -
                <a href="hex.html"         target="_blank">hexes</a> -
                <a href="blackmarket.html" target="_blank">black market</a>
      </p>
   </div>

   <div class="w3-cell">&nbsp; &nbsp;</div>

   <div class="w3-cell w3-sand w3-card-4 w3-round-xlarge">
      <h1>Kingdom<br>Randomizer</h1>
      <p>
         <a href="index.html" target="_blank">Randomizer</a><br>
         <a href="sets.html"  target="_blank">Featured Games</a><br>
         <a href="rules.html" target="_blank">Rules</a>
      </p>
   </div>
</div>


<div class="w3-sand w3-card-4 w3-round-xlarge w3-margin">
   <h1 class="w3-padding">Games Contents</h1>
   <div class="w3-cell-row">
      <div class="w3-cell">
         <div class="w3-container w3-margin w3-white w3-round-xlarge">
            <h3>Dominion</h3>
            <p>
            <a href="game-dominion.html"    target="_blank">Dominion</a> -
            <a href="game-intrigue.html"    target="_blank">Intrigue</a> -
            <a href="game-seaside.html"     target="_blank">Seaside</a> -
            <a href="game-alchemy.html"     target="_blank">Alchemy</a> -
            <a href="game-prosperity.html"  target="_blank">Prosperity</a> -
            <a href="game-cornucopia.html"  target="_blank">Cornucopia</a> -
            <a href="game-hinterlands.html" target="_blank">Hinterlands</a> -
            <a href="game-darkages.html"    target="_blank">Dark Ages</a> -
            <a href="game-guilds.html"      target="_blank">Guilds</a> -
            <a href="game-adventures.html"  target="_blank">Adventures</a> -
            <a href="game-empires.html"     target="_blank">Empires</a> -
            <a href="game-nocturne.html"    target="_blank">Nocturne</a> -
            <a href="game-renaissance.html" target="_blank">Renaissance</a> -
            <a href="game-menagerie.html"   target="_blank">Menagerie</a> -
            <a href="game-allies.html"      target="_blank">Allies</a> -
            <a href="game-plunder.html"     target="_blank">Plunder</a>
            <br><br>
            <a href="game-promo.html"       target="_blank">Promo Cards</a> -
            <a href="game-all.html"         target="_blank">ALL GAMES</a>
            </p>
         </div>
      </div>
      <div class="w3-cell">
         <div class="w3-container w3-margin w3-white w3-round-xlarge" style="height:100%">
            <h3>Community</h3>
EOF

expansions

cat << EOF
         </div>
      </div>
   </div>
</div>

<div class="w3-container w3-sand w3-card-4 w3-round-xlarge w3-margin">
   <h1>Online Resources</h1>

   <p>Dominion Strategy:
      <a href="https://dominionstrategy.com"      target="_blank">site</a> -
      <a href="http://wiki.dominionstrategy.com"  target="_blank"><strong>wiki</strong></a> -
      <a href="http://forum.dominionstrategy.com" target="_blank"><strong>forum</strong></a>
      <br>Board Game Geek:
          <a href="https://boardgamegeek.com/boardgame/36218/dominion"                   target="_blank">dominion</a> -
          <a href="https://boardgamegeek.com/boardgame/36218/dominion/expansions"        target="_blank">expansions</a> -
          <a href="https://boardgamegeek.com/filepage/68210/complete-dominion-companion" target="_blank">"Companion" rulebook</a>
      <br>Reddit: <a href="https://old.reddit.com/r/dominion" target="_blank">r/dominion</a>
      <br><a href="https://dominion.games" target="_blank">Dominion Online</a> (official online game)
      <br><a href="https://www.riograndegames.com/games/dominion" target="_blank">Dominion</a> at RioGrande Games (official publisher)
    </p>
</div>

<!-- ------------------------------------------------------------- -->
</div>
</div>
</body>
</html>
EOF
