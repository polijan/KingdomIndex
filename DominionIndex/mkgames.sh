#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions
# MUST BE CALLED FROM THE APP DIRECTORY


################################################################################
# MODULE "UTIL": small util functions
################################################################################

log()   { local c; c=$1; shift; printf '%b %s\n' "$c" "$*" >&2; }
msg()   { log '\033[32m[ msg ]\033[0m'   "$*"; }
die()   { log '\033[1;31m[abort]\033[0m' "$*"; exit 3; }
warn()  { log '\033[1;33m[warn!]\033[0m' "$*"; }
debug() { log '\033[1;36m[debug]\033[0m' "$*"; }


################################################################################
# MODULE "CARDS": find or print cards
################################################################################

# card_name CARD
# put the 'simple name' of a resources/card in variable CARD_NAME,
# 'simple name' means lowercase and removing spaces and apostrophes
card_name() {
   CARD_NAME=$(printf %s "$1" | tr '[:upper:]' '[:lower:]' | tr -d " '/_")
}

# usage: card_find_ NAME
# try to find card named NAME
# first will try to find in DominionIndxe images
# second will try to find
#
# 1. call 'card_name' (populates variable CARD_NAME)
# 2. find the corresponding image and put it in variable CARD_IMG
# 3. set the name of the game in variable CARD_GAME
# 4. set type of the card variable CARD_TYPE
#    if it's really a card (in Dominion parlance), CARD_TYPE will be "card"
#    otherwise CARD_TYPE will the type of landscape card: (event, landmark,
#                                              project, way, artifact, ...)
card_find() {
   card_name  "$1"
   card_find_ 'img/cards' ||
   card_find_ 'img_index' ||
   die "cannot find image for '$CARD_NAME'"
}

# usage: card_find_ DIR
# (helper for card_find)
# look for card $CARD_NAME in directory DIR
card_find_() {
   [ -d "$1" ] || die "$1: not a directory"

   CARD_IMG=$(ls "$1" | grep "_${CARD_NAME}.jpg$") || return 1
   while true; do
      case $(printf '%s\n' "$CARD_IMG" | wc -l) in
         1) break    ;;
         2) # cards common to version 1&2 of dominion(baseset)
            # or intrique may be returned twice. In that case,
            # return the card of the 2nd version.
            CARD_IMG=$(printf %s "$CARD_IMG" | grep '^intrigue2\|^baseset2')
            [ "$(printf '%s\n' "$CARD_IMG" | wc -l)" -eq 1 ] \
            ||  die "found two images for '$CARD_NAME'" ;;
         *) die "found several images for '$CARD_NAME'" ;;
      esac
   done

   CARD_GAME=$(printf %s "$CARD_IMG" | cut -f1 -d_)

   # card or special type? (artifact, boon, event, landmark, project, way)
   CARD_TYPE='card'
   case $CARD_IMG in *_*_*)
        CARD_TYPE=$(printf %s "$CARD_IMG" | cut -f2 -d_) ;;
   esac

   CARD_IMG=$1/$CARD_IMG
}

#-------------- card_row, card_rows, card_row_labels, card_print ---------------

# card_row CARD1 CARD2 CARD3 CARD4 CARD5
# prints a row of five cards
# a CARD can be '' to display nothing
card_row() {
   [ $# -eq 5 ] || die 'need 5 card arguments'
   echo '<div class="w3-cell-row">'
   card_print "$1"
   card_print "$2"
   card_print "$3"
   card_print "$4"
   card_print "$5"
   echo '</div>'
}


# display rows of cards (crads given in arguments)
# each row is filled with 5 cards displayed with card_row function
card_rows() {
   local c1
   local c2
   local c3
   local c4
   local c5
   while [ $# -ne 0 ]; do
      c1=''; [ $# -ne 0 ] && { c1=$1; shift; }
      c2=''; [ $# -ne 0 ] && { c2=$1; shift; }
      c3=''; [ $# -ne 0 ] && { c3=$1; shift; }
      c4=''; [ $# -ne 0 ] && { c4=$1; shift; }
      c5=''; [ $# -ne 0 ] && { c5=$1; shift; }
      [ -n "$c1$c2$c3$c4$c5" ] && card_row "$c1" "$c2" "$c3" "$c4" "$c5"
   done
}

# card_row_label LABEL1 LABEL2 LABEL3 LABEL4 LABEL5
# print a row of "card labels"
#
#(use fmt as format string which is constant, it's ok)
#shellcheck disable=SC2059
card_row_labels() {
   [ $# -eq 5 ] || die 'need 5 card arguments'

   local fmt='   <div class="w3-cell">\n'
   fmt="$fmt        <div contenteditable=\"true\"\n"
   fmt="$fmt              style=\"width:220px; display:inline-block\">\n"
   fmt="$fmt           %s"
   fmt="$fmt        </div>"
   fmt="$fmt     </div>\n"

   echo   '<div class="w3-cell-row">'
   echo   '   <div class="w3-cell-row w3-center w3-text-grey">'
   printf "$fmt"  "$1"
   printf "$fmt"  "$2"
   printf "$fmt"  "$3"
   printf "$fmt"  "$4"
   printf "$fmt"  "$5"
   echo   '   </div>'
   echo   '</div>'
}

# usage: card_print [--no-cell] title image
#    or  card_print [--no-cell] resource
#
# show a card given by its title & name or found by a resource string
# card is shown in a 'w3-cell' unless --no-cell is specified)
#
# >> mostly use card_row() to display cards instead of this
card_print() {
   local title
   local img

   local cell=true
   [ "$1" = '--no-cell' ] && { cell=false; shift; }

   case $# in
     1) if [ -n "$1" ]; then
           card_find "$1"; title=$CARD_NAME; img=$CARD_IMG
        fi ;;
     2) [ -n "$1" ] || die 'card is null but you gave two arguments'
        title=$1; img=$2 ;;
     *) die "card function: wrong number of args ($#)" ;;
   esac

   $cell && echo         '<div class="w3-cell">'
   echo                  '   <div style="padding:3px">'
   [ -n "$1" ] && printf '      <a href="%s">\n' "$img"
   echo                  '         <img style="width:220px"'
   [ -n "$1" ] && echo   '              class="w3-animate-zoom w3-card w3-border-black w3-round-xlarge w3-hover-sepia"'
   [ -n "$1" ] && printf '              src="%s" alt="%s" />\n' "$img" "$title"
   [ -z "$1" ] && echo   '              src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=">'
   [ -n "$1" ] && echo   '      </a>'
   echo                  '   </div>'
   $cell && echo         '</div>'

}

#------------- card_lrow, card_lrows, card_lrow_labels, card_lprint ------------

# card_lrow LCARD1 LCARD2 LCARD3
# prints a row of three landscape cards
# a CARD can be '' to display nothing
card_lrow() {
   [ $# -eq 3 ] || die 'need 3 landscape card arguments'
   echo '<div class="w3-cell-row">'
   card_lprint "$1"
   card_lprint "$2"
   card_lprint "$3"
   echo '</div>'
}

# display rows of landscape cards (landscape cards given in arguments)
# each row is filled with 3 landscape cards displayed with card_lrow function
card_lrows() {
   local l1
   local l2
   local l3
   while [ $# -ne 0 ]; do
      l1=''; [ $# -ne 0 ] && { l1=$1; shift; }
      l2=''; [ $# -ne 0 ] && { l2=$1; shift; }
      l3=''; [ $# -ne 0 ] && { l3=$1; shift; }
      [ -n "$l1$l2$l3" ] && card_lrow "$l1" "$l2" "$l3"
   done
}

# card_lrow_labels LABEL1 LABEL2 LABEL3
# print a row of "lcard labels"
#
#(use fmt as format string which is constant, it's ok)
#shellcheck disable=SC2059
card_lrow_labels() {
   [ $# -eq 3 ] || die 'need 3 label arguments'
   local fmt='   <div class="w3-cell">\n'
   fmt="$fmt        <div contenteditable=\"true\"\n"
   fmt="$fmt              style=\"width:352px; display:inline-block\">\n"
   fmt="$fmt           %s"
   fmt="$fmt        </div>"
   fmt="$fmt     </div>\n"

   echo   '<div class="w3-cell-row">'
   echo   '   <div class="w3-cell-row w3-center w3-text-grey">'
   printf "$fmt"  "$1"
   printf "$fmt"  "$2"
   printf "$fmt"  "$3"
   echo   '   </div>'
   echo   '</div>'
}

# like card_print for landscape cards
card_lprint() {
   [ -n "$1" ] && card_find "$1"
   echo                  '<div class="w3-cell">'
   echo                  '   <div style="padding:3px">'
   [ -n "$1" ] && printf '      <a href="%s">\n' "$CARD_IMG"
   echo                  '         <img style="width:352px; max-height:220px"'
   [ -n "$1" ] && echo   '              class="w3-animate-zoom w3-card w3-border-black w3-round-xlarge w3-hover-sepia"'
   [ -n "$1" ] && printf '              src="%s" alt="%s" />\n' "$CARD_IMG" "$CARD_NAME"
   [ -z "$1" ] && echo   '              src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=">'
   [ -n "$1" ] && echo   '      </a>'
   echo                  '   </div>'
   echo                  '</div>'
}



################################################################################

# print board
html_begin() {
cat << EOF
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Board - Dominion Index</title>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="res/w3.css">
</head>
<style>
   @font-face {
      font-family: 'MagicSchool';
      src: url('res/MagicSchoolOne.ttf');
   }
   h1, h2, h3 { font-family: 'MagicSchool'; }
</style>
<body>
   <div class="w3-auto">
EOF
}

html_end() {
cat << EOF
   </div>
</body>
</html>
EOF
}

################################################################################

begin() { # usage: begin TITLE [BOX_IMG]...
   msg "generating game: $1"
   html_begin

   echo   '<div class="w3-center">'
   echo   '<h1 class="w3-jumbo w3-text-indigo"'
   echo   '    style="text-shadow:3px 2px 0 #999">'
   printf '    %s\n' "$1"
   echo   '</h1>'
   shift

   local i
   echo '<div class="w3-cell-row w3-animate-top">'
   for i; do
       echo   '<div class="w3-cell w3-center">'
       echo   '   <div style="padding:10px">'
       printf '      <img src="img/boxes/%s" alt="%s">\n' "$i" "$i"
       echo   '   </div>'
       echo   '</div>'
   done
   echo '</div>'

   echo '</div>'
}

end() { html_end; }

################################################################################


game_index() {
   begin 'Dominion Index'
   echo '<h1>Base Cards</h1>'
   card_row copper     silver     gold        ''          ''
   card_row estate     duchy      province    ''          curse
   echo '<h1>Numerical Indexes (Kingdoms)</h1>'
   card_row 01 02 03 04 05
   card_row 06 07 08 09 10
   echo '<h1>Alphabetical Indexes</h1>'
   echo '    <h2>A, B, C, D</h2>'
   echo '    <h2>E, F, G, H</h2>'
   echo '    <h2>ToDo ...</h2>'
   echo '<h1>Landscapes (ToDo)</h1>'
   echo '    <h2>x, y, z</h2>'
   echo '<h1>Cheatsheets (ToDo)</h1>'
   echo '    <h2>artifacts - castles - heirlooms - knights - _</h2>'
   echo '    <h2>page, peasant, prizes, ruins, ""</h2>'
   echo '    <h2>shelters - splitpiles1 - splitpiles2 - zombies - _</h2>'
   echo '<h1>Material</h1>'
   card_row  ''         ''         trash       ''          ''
   printf    '<p>For other needed mats, use unused cards.<br>\n'
   printf    'For tokens, use some coins.</p>\n'
   end
}

game_dominion() {
   begin 'Dominion' baseset.jpg baseset2.jpg
   echo '<h1>Base Cards</h1>'
   card_row copper      silver     gold        ''          ''
   card_row estate      duchy      province    ''          curse
   echo '<h1>Kingdom Cards</h1>'
   echo '    <h2>both first and second edition</h2>'
   card_row  cellar     chapel     moat        village     workshop
   card_row  bureaucrat gardens    militia     moneylender remodel
   card_row  smithy     throneroom councilroom festival    laboratory
   card_row  library    market     mine        witch       ''
   echo '    <h2>only in second edition</h2>'
   card_row  harbinger  merchant   vassal      poacher     ''
   card_row  bandit     sentry     artisan     ''          ''
   echo '    <h2>only in first edition (removed)</h2>'
   card_row  ''         chancellor woodcutter  feast       ''
   card_row  ''         spy        thief       adventurer  ''
   echo '<h1>Mats</h1>'
   card_row  ''         ''         trash       ''          ''
   end
}

game_intrigue() {
   begin 'Intrigue' intrigue.jpg intrigue2.jpg
   echo '<h1>Kingdom Cards</h1>'
   echo '    <h2>both first and second edition</h2>'
   card_row  courtyard   pawn          masquerade  shantytown    steward
   card_row  swindler    wishingwell   baron       bridge        conspirator
   card_row  ironworks   miningvillage duke        minion        torturer
   card_row  tradingpost upgrade       harem       nobles        ''
   echo '    <h2>only in second edition</h2>'
   card_row  lurker      diplomat      mill        secretpassage ''
   card_row  courtier    patrol        replace     ''            ''
   echo '    <h2>only in first edition (removed)</h2>'
   card_row  ''          secretchamber greathall   coppersmith   ''
   card_row  ''          scout         saboteur    tribute       ''
   echo '<h1>Other Cards (only in first edition)</h1>'
   echo '    <h2>base cards</h2>'
   card_row  copper      silver        gold        ''            ''
   card_row  estate      duchy         province    ''            curse
   echo '    <h2>Mats</h2>'
   card_row  ''          ''            trash       ''            ''
   end
}

game_seaside() {
   begin 'Seaside' seaside.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  embargo    haven          lighthouse    nativevillage    pearldiver
   card_row  ambassador fishingvillage lookout       smugglers        warehouse
   card_row  caravan    cutpurse       island        navigator        pirateship
   card_row  salvager   seahag         treasuremap   bazaar           explorer
   card_row  ''         ghostship      merchantship  outpost          ''
   card_row  ''         tactician      treasury      wharf            ''
   echo '<h1>Mats</h1>'
   card_row  ''         islandmat      pirateshipmat nativevillagemat ''
   echo '<h1>Tokens</h1>'
   card_row  cointoken  ''             ''            ''               embargotoken
   end
}

game_alchemy() {
   begin 'Alchemy' alchemy.png
   echo '<h1>Base Cards</h1>'
   card_row  ''         ''         potion    ''                ''
   echo '<h1>Kingdom Cards</h1>'
   card_row  transmute  vineyard   herbalist apothecary        scryingpool
   card_row  university alchemist  familiar  philosophersstone golem
   card_row  apprentice possession ''        ''                ''
   end
}

game_prosperity() {
   begin 'Prosperity' prosperity.jpg
   echo '<h1>Base Cards</h1>'
   card_row  platinum      colony    ''              ''          ''
   echo '<h1>Kingdom Cards</h1>'
   card_row  loan          traderoute watchtower     bishop      monument
   card_row  quarry        talisman   workersvillage city        contraband
   card_row  countinghouse mint       mountebank     rabble      royalseal
   card_row  vault         venture    goons          grandmarket hoard
   card_row  bank          expand     forge          kingscourt  peddler
   end
   echo '<h1>Mats & Tokens</h1>'
   card_row  traderoutemat victorymat ''             cointoken   vptoken
}

game_cornucopia() {
   begin 'Cornucopia' cornucopia.png guildscornucopia.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  hamlet    fortuneteller menagerie   farmingvillage horsetraders
   card_row  remake    tournament    youngwitch  harvest        hornofplenty
   card_row  ''        huntingparty  jester      fairgrounds    ''
   echo '<h1>Prizes (unique)</h1>'
   card_row  bagofgold diadem        followers   princess       trustysteed
   end
}

game_hinterlands() {
   begin 'Hinterlands' hinterlands.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  crossroads   duchess  foolsgold     develop         oasis
   card_row  oracle       scheme   tunnel        jackofalltrades noblebrigand
   card_row  nomadcamp    silkroad spicemerchant trader          cache
   card_row  cartographer embassy  haggler       illgottengains  highway
   card_row  ''           inn      mandarin      margrave        ''
   card_row  ''           stables  bordervillage farmland        ''
   end
}

game_darkages() {
   begin 'Dark Ages' darkages.jpg
   echo '<h1>Base Cards (Ruins)</h1>'
   card_row  abandonedmine ruinedlibrary ruinedmarket ruinedvillage   survivors
   echo '<h1>Kingdom Cards</h1>'
   card_row  poorhouse     beggar        squire       vagrant         forager
   card_row  hermit        marketsquare  sage         storeroom       urchin
   card_row  armory        deathcart     feodum       fortress        ironmonger
   card_row  marauder      procession    rats         scavenger       wanderingminstrel
   card_row  bandofmisfits banditcamp    catacombs    count           counterfeit
   card_row  cultist       graverobber   junkdealer   knights         mystic
   card_row  pillage       rebuild       rogue        altar           huntinggrounds
   echo '<h2>Knights</h2>'
   card_row  dameanna      damejosephine damemolly    damenatalie     damesylvia
   card_row  sirbailey     sirdestry     sirmartin    sirmichael      sirvander
   echo '<h1>Non-Supply Cards</h1>'
   echo "    <h2>Shelters</h2>"
   card_row  ''            hovel         necropolis   overgrownestate ''
   echo "    <h2>Others</h2>"
   card_row  ''            madman        mercenary    spoils          ''
   end
}

game_guilds() {
   begin 'Guilds' guilds.png guildscornucopia.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  candlestickmaker stonemason doctor        masterpiece advisor
   card_row  plaza            taxman     herald        baker       butcher
   card_row  ''               journeyman merchantguild soothsayer  ''
   echo '<h1>Mats / Tokens</h1>'
   card_row  coffers          ''         ''            ''          cointoken
   end
}

game_adventures() {
   begin 'Adventures' adventures.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  coinoftherealm page           peasant        ratcatcher   raze
   card_row  amulet         caravanguard   dungeon        gear         guide
   card_row  duplicate      magpie         messenger      miser        port
   card_row  ranger         transmogrify   artificer      bridgetroll  distantlands
   card_row  giant          hauntedwoods   lostcity       relic        royalcarriage
   card_row  storyteller    swamphag       treasuretrove  winemerchant hireling
   echo '<h1>Upgrade Cards</h1>'
   card_row  page           treasurehunter warrior        hero         champion
   card_row  peasant        soldier        fugitive       disciple     teacher
   echo '<h1>Events</h1>'
   card_lrow alms           borrow         quest
   card_lrow save           scoutingparty  travellingfair
   card_lrow bonfire        expedition     ferry
   card_lrow plan           mission        pilgrimage
   card_lrow ball           raid           seaway
   card_lrow trade          lostarts       training
   card_lrow inheritance    pathfinding    ''
   echo '<h1>Mats</h1>'
   card_lrow ''             tavernmat      ''
   echo '<h1>Tokens</h1>'
   card_row  actiontoken    buytoken       cardtoken      pluscointoken  minuscosttoken
   card_row  trashingtoken  journeytoken   estatetoken    minuscointoken minuscardtoken

   end
}

game_empires() {
   begin 'Empires' empires.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  engineer          cityquarter             overlord         royalblacksmith encampmentplunder
   card_row  patricianemporium settlersbustlingvillage castles          catapultrocks   chariotrace
   card_row  enchantress       farmersmarket           gladiatorfortune sacrifice       temple
   card_row  villa             archive                 capital          charm           crown
   card_row  forum             groundskeeper           legionary        wildhunt        ''
   echo '<h1>Split Piles</h1>'
   echo '<h2>Castles</h2>'
   card_row  humblecastle  crumblingcastle smallcastle hauntedcastle ''
   card_row  opulentcastle sprawlingcastle grandcastle kingscastle   ''
   echo '<h2>half/half splits</h2>'
   card_row  encampment    plunder         '' patrician emporium
   card_row  settlers      bustlingvillage '' catapult  rocks
   card_row  gladiator     fortune         '' '' ''
   echo '<h1>Landmarks</h1>'
   card_lrow triumph       annex         donate
   card_lrow advance       delve         tax
   card_lrow banquet       ritual        salttheearth
   card_lrow wedding       windfall      conquest
   card_lrow ''            dominate      ''
   echo '<h1>Events</h1>'
   card_lrow aqueduct      arena         banditfort
   card_lrow basilica      baths         battlefield
   card_lrow colonnade     defiledshrine fountain
   card_lrow keep          labyrinth     mountainpass
   card_lrow museum        obelisk       orchard
   card_lrow palace        tomb          tower
   card_lrow triumphalarch wall          wolfden
   echo '<h1>Tokens</h1>'
   card_row  '' '' 'debttoken' '' ''
   end
}

game_nocturne() {
   begin 'Nocturne' nocturne.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  druid         faithfulhound  guardian    monastery      pixie
   card_row  tracker       changeling     fool        ghosttown      leprechaun
   card_row  nightwatchman secretcave     bard        blessedvillage cemetery
   card_row  conclave      devilsworkshop exorcist    necromancer    shepherd
   card_row  skulk         cobbler        crypt       cursedvillage  denofsin
   card_row  idol          pooka          sacredgrove tormentor      tragichero
   card_row  ''            vampire        werewolf    raider         ''
   echo '<h1>Non-Supply Cards</h1>'
   echo '    <h2>Heirlooms</h2>'
   card_row  hauntedmirror magiclamp      goat        pasture        ''
   card_row  pouch         cursedgold     luckycoin   ''             ''
   echo '    <h2>Spirits</h2>'
   card_row  ''            willowisp      imp         ghost          ''
   echo '    <h2>Zombies</h2>'
   card_row  ''          zombieapprentice zombiemason zombiespy      ''
   echo '    <h2>Others</h2>'
   card_row  ''            wish           ''          bat            ''
   echo '<h1>Boons</h1>'
   card_lrow theearthsgift   thefieldsgift  theflamesgift
   card_lrow theforestsgift  themoonsgift   themountainsgift
   card_lrow theriversgift   theseasgift    theskysgift
   card_lrow thesunsgift     theswampsgift  thewindsgift
   echo '<h1>Hexes</h1>'
   card_lrow badomens        delusion       envy
   card_lrow famine          fear           greed
   card_lrow haunting        locusts        misery
   card_lrow plague          poverty        war
   echo '<h1>States</h1>'
   card_lrow ''              lostinthewoods ''
   card_row  deluded envious ''             miserable twicemiserable
   end
}

game_renaissance() {
   begin 'Renaissance' renaissance.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  borderguard     ducat     lackeys      actingtroupe cargoship
   card_row  experiment      improve   flagbearer   hideout      inventor
   card_row  mountainvillage patron    priest       research     silkmerchant
   card_row  oldwitch        recruiter scepter      scholar      sculptor
   card_row  seer            spices    swashbuckler treasurer    villain
   echo '<h1>Projects</h1>'
   card_lrow cathedral   citygate      pageant
   card_lrow sewers      starchart     exploration
   card_lrow fair        silos         sinisterplot
   card_lrow academy     capitalism    fleet
   card_lrow guildhall   piazza        roadnetwork
   card_lrow barracks    croprotation  innovation
   card_lrow canal       citadel       ''
   echo '<h1>Artifacts</h1>'
   card_row  flag            horn      key          lantern      treasurechest
   echo '<h1>Mats & Tokens</h1>'
   card_row  cointoken       ''        villagers    ''           cubetoken
   end
}

game_menagerie() {
   begin 'Menagerie' menagerie.jpg
   echo '<h1>Kingdom Cards</h1>'
   card_row  blackcat     sleigh    supplies     cameltrain goatherd
   card_row  scrap        sheepdog  snowyvillage stockpile  bountyhunter
   card_row  cardinal     cavalry   groom        hostelry   villagegreen
   card_row  barge        coven     displace     falconer   gatekeeper
   card_row  huntinglodge kiln      livery       mastermind paddock
   card_row  sanctuary    fisherman destrier     wayfarer   animalfair
   echo '<h1>Non-Supply Cards</h1>'
   card_row  ''           ''        horse        ''         ''
   echo '<h1>Events</h1>'
   card_lrow delay        desperation  gamble
   card_lrow pursue       ride         toil
   card_lrow enhance      march        transport
   card_lrow banish       bargain      invest
   card_lrow seizetheday  commerce     demand
   card_lrow stampede     reap         enclave
   card_lrow alliance     populate     ''
   echo '<h1>Ways</h1>'
   card_lrow wayofthebutterfly wayofthecamel  wayofthechameleon
   card_lrow wayofthefrog      wayofthegoat   wayofthehorse
   card_lrow wayofthemole      wayofthemonkey wayofthemouse
   card_lrow wayofthemule      wayoftheotter  wayoftheowl
   card_lrow wayoftheox        wayofthepig    wayoftherat
   card_lrow wayoftheseal      wayofthesheep  wayofthesquirrel
   card_lrow wayoftheturtle    wayoftheworm   ''
   end
}

game_promo() {
   begin 'Promo Cards'
   echo '<h1>Kingdom Cards</h1>'
   card_row  blackmarket   church   dismantle envoy   saunaavanto
   card_row  walledvillage governor stash     captain prince
   echo '<h1>Landscape Cards</h1>'
   card_lrow '' summon ''
   echo '<h1>Split Piles</h1>'
   card_row  saunaavanto '' '' sauna avanto
   end
}

game_all() {
   begin 'All Games'

   echo '<h1>Base Cards</h1>'
   echo '<h2>Treasures / Victories / Curses</h2>'
   card_row  copper        silver        gold         platinum      potion
   card_row  estate        duchy         province     colony        curse
   echo '<h2>Ruins</h2>'
   card_row  abandonedmine ruinedlibrary ruinedmarket ruinedvillage survivors

   echo '<h1>Kingdom Cards (TODO)</h1>'
   echo '    <h2>Dominion (1 & 2)</h2>'
   card_row  cellar     chapel     moat        village     workshop
   card_row  bureaucrat gardens    militia     moneylender remodel
   card_row  smithy     throneroom councilroom festival    laboratory
   card_row  library    market     mine        witch       ''
   echo '    <h2>Dominion (2)</h2>'
   card_row  harbinger  merchant   vassal      poacher     ''
   card_row  bandit     sentry     artisan     ''          ''
   echo '    <h2>Dominion (1)</h2>'
   card_row  ''         chancellor woodcutter  feast       ''
   card_row  ''         spy        thief       adventurer  ''
   echo '    <h2>Intrigue (1 & 2)</h2>'
   card_row  courtyard     pawn          masquerade  shantytown    steward
   card_row  swindler      wishingwell   baron       bridge        conspirator
   card_row  ironworks     miningvillage duke        minion        torturer
   card_row  tradingpost   upgrade       harem       nobles        ''
   echo '    <h2>Intrigue (2)</h2>'
   card_row  lurker        diplomat      mill        secretpassage ''
   card_row  courtier      patrol        replace     ''            ''
   echo '    <h2>Intrigue (1)</h2>'
   card_row  secretchamber greathall     coppersmith scout         saboteur
   card_row  tribute       ''            ''          ''            ''


   echo '<h1>Mixed/Split Kingdom Piles</h1>'
   echo '<h2>Knights</h2>'
   card_row  dameanna      damejosephine damemolly    damenatalie     damesylvia
   card_row  sirbailey     sirdestry     sirmartin    sirmichael      sirvander
   echo '<h2>Castles</h2>'
   card_row  humblecastle  crumblingcastle smallcastle hauntedcastle ''
   card_row  opulentcastle sprawlingcastle grandcastle kingscastle   ''
   echo '<h2>Half/half splits</h2>'
   card_row  encampment    plunder         '' patrician emporium
   card_row  settlers      bustlingvillage '' catapult  rocks
   card_row  gladiator     fortune         '' sauna     avanto

   echo '<h1>Non-Supply Piles (TODO)</h1>'

   echo '<h1>Landscape Cards (Events/Landmarks/Projects/Ways)</h1>'
   echo '<h2>Events</h2>'
   card_lrow triumph           annex          donate
   card_lrow advance           alms           borrow
   card_lrow delay             desperation    quest
   card_lrow save              delve          gamble
   card_lrow pursue            ride           scoutingparty
   card_lrow tax               toil           travellingfair
   card_lrow banquet           bonfire        enhance
   card_lrow expedition        ferry          march
   card_lrow plan              transport      banish
   card_lrow bargain           invest         mission
   card_lrow pilgrimage        ritual         salttheearth
   card_lrow seizetheday       wedding        ball
   card_lrow commerce          demand         raid
   card_lrow seaway            stampede       summon
   card_lrow trade             windfall       conquest
   card_lrow lostarts          training       inheritance
   card_lrow reap              enclave        pathfinding
   card_lrow alliance          populate       dominate
   echo '<h2>Landmarks</h2>'
   card_lrow aqueduct          arena          banditfort
   card_lrow basilica          baths          battlefield
   card_lrow colonnade         defiledshrine  fountain
   card_lrow keep              labyrinth      mountainpass
   card_lrow museum            obelisk        orchard
   card_lrow palace            tomb           tower
   card_lrow triumphalarch     wall           wolfden
   echo '<h2>Projects</h2>'
   card_lrow cathedral         citygate       pageant
   card_lrow sewers            starchart      exploration
   card_lrow fair              silos          sinisterplot
   card_lrow academy           capitalism     fleet
   card_lrow guildhall         piazza         roadnetwork
   card_lrow barracks          croprotation   innovation
   card_lrow canal             citadel        ''
   echo '<h2>Ways</h2>'
   card_lrow wayofthebutterfly wayofthecamel  wayofthechameleon
   card_lrow wayofthefrog      wayofthegoat   wayofthehorse
   card_lrow wayofthemole      wayofthemonkey wayofthemouse
   card_lrow wayofthemule      wayoftheotter  wayoftheowl
   card_lrow wayoftheox        wayofthepig    wayoftherat
   card_lrow wayoftheseal      wayofthesheep  wayofthesquirrel
   card_lrow wayoftheturtle    wayoftheworm   ''

   echo '<h1>Boons / Hexes (TODO)</h1>'

   echo '<h1>Artifacts & States</h1>'
   echo '<h2>Unique Artifacts/Unary states</h2>'
   card_lrow  flag    horn          key
   card_lrow  lantern treasurechest lostinthewoods
   echo '<h2>Per-Player Binary States</h2>'
   card_row  deluded envious ''             miserable twicemiserable

   echo '<h1>Mats</h1>'
   card_row  trash          ''             islandmat      pirateshipmat  nativevillagemat
   card_lrow traderoutemat  victorymat     tavernmat
   card_lrow coffers        villagers      exilemat

   echo '<h1>Tokens</h1>'
   card_row  cointoken      vptoken        debttoken      embargotoken   cubetoken
   card_row  actiontoken    buytoken       cardtoken      pluscointoken  minuscosttoken
   card_row  trashingtoken  journeytoken   estatetoken    minuscointoken minuscardtoken

   end
}


################################################################################

game_index       > game-index.html
game_dominion    > game-dominion.html
game_intrigue    > game-intrigue.html
game_seaside     > game-seaside.html
game_alchemy     > game-alchemy.html
game_prosperity  > game-prosperity.html
game_cornucopia  > game-cornucopia.html
game_hinterlands > game-hinterlands.html
game_darkages    > game-darkages.html
game_guilds      > game-guilds.html
game_adventures  > game-adventures.html
game_empires     > game-empires.html
game_nocturne    > game-nocturne.html
game_renaissance > game-renaissance.html
game_menagerie   > game-menagerie.html
game_promo       > game-promo.html
game_all         > game-all.html
