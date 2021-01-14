#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions
# MUST BE CALLED FROM THE APP DIRECTORY

. ../KingdomIndex/lib-util.sh
. ../KingdomIndex/lib-card.sh
msg "generating game: Antiquities fan expansion"
html_begin 'Antiquities'

cat << EOF
<div id="top" class="w3-cell-row w3-section">

   <div class="w3-cell-top">

      <div class="w3-display-container w3-center">
         <a href="/start.html"><img src="res/shield.png" alt="shield"></a>
         <h1 class="w3-display-middle w3-jumbo w3-text-deep-orange"
             style="text-shadow:3px 3px 0 #dde">
             Antiquities
         </h1>
      </div>

      <div class="w3-card-4 w3-margin w3-padding w3-round-xlarge w3-container w3-section" style="background-color: rgba(255,255,255,.2); backdrop-filter: blur(6px);">
         <p><strong>Antiquities</strong> (2018)<br>
         A Fan Expansion for Donald X. Vaccarino’s Dominion
         by John “Neirai the Forgiven” den Otter
         Featuring Card and Cover Art by Jan Boruta
         <br>
         Release available online <a href="https://drive.google.com/drive/folders/19r-veyGWQOBQpYZGGdAZpN9A0PNaqvkW">here</a>.
         Discussion <a href="http://forum.dominionstrategy.com/index.php?topic=19230.0">here</a>.

         <ul class="w3-large">
            <li>Rules (<a href="games/antiquities/rules.pdf">PDF</a>)</li>
            <li><a href="#game">Game Contents</a></li>
            <li><a href="#featured">Recommended Sets</a></li>
         </ul>
         </p>
      </div>
   </div>

   <div class="w3-cell w3-center">
      <img class="w3-margin w3-card-4"
           src="games/antiquities/box.jpg" alt="Antiquities fan expansion">
   </div>

</div>
EOF

################################################################################

echo '<hr><h1 id="game" class="w3-jumbo">Game Contents</h1>'
echo '<h1>Supply: Kingdoms + Boulder Trap</h1>'

card_row  antiquities#graveyard    antiquities#discovery  antiquities#gamepiece antiquities#gravewatcher antiquities#inscription
card_row  antiquities#inspector    antiquities#miner      antiquities#profiteer antiquities#shipwreck    antiquities#tombraider
card_row  antiquities#aquifer      antiquities#collector  antiquities#curio     antiquities#mendicant    antiquities#moundbuildervillage
card_row  antiquities#snakecharmer antiquities#stoneworks antiquities#agora     antiquities#mastermind   antiquities#missionhouse
card_row  antiquities#pyramid      antiquities#stronghold antiquities#encroach  antiquities#mausoleum    antiquities#archaeologist
card_row  antiquities#dig          antiquities#pharaoh    ''                    ''                       antiquities#bouldertrap

echo '<h1>Material from Dominion</h1>'
card_lrow exilemat victorymat vptoken
echo 'note: use the Exile mat for the Mausoleum.'

################################################################################


cat << EOF
<div class="w3-center w3-section">
   <a href="#top" class="w3-small">(top)</a>
   <hr>
</div>

<h1 id="featured" class="w3-jumbo">Recommended Sets of 10</h1>

<div class="w3-center">
<a href="#only">Antiquities</a> ●
<a href="#dominion">+Dominion</a> ●
<a href="#intrigue">+Intrigue</a> ●
<a href="#prosperity">+Prosperity</a> ●
<a href="#cornucopia">+Cornucopia</a> ●
<a href="#seaside">+Seaside</a> ●
<a href="#alchemy">+Alchemy</a> ●
<a href="#hinterlands">+Hinterlands</a> ●
<a href="#darkages">+DarkAges</a> ●
<a href="#guilds">+Guilds</a> ●
<a href="#adventures">+Adventures</a> ●
<a href="#empires">+Empires</a> ●
<a href="#renaissance">+Renaissance</a>
</div>
EOF


echo '<h1 id="only" class="w3-center">Antiquities Only</h1>'

html_set 'Ancient Times' \
         'antiquities#discovery,antiquities#gamepiece,antiquities#gravewatcher,antiquities#tombraider,antiquities#aquifer,antiquities#agora,antiquities#pyramid,antiquities#stronghold,antiquities#dig,antiquities#pharaoh'
card_row  antiquities#discovery antiquities#gamepiece antiquities#gravewatcher antiquities#tombraider antiquities#aquifer
card_row  antiquities#agora     antiquities#pyramid   antiquities#stronghold   antiquities#dig        antiquities#pharaoh

html_set 'The College of Antiquities' \
         'antiquities#inscription,antiquities#inspector,antiquities#miner,antiquities#profiteer,antiquities#collector,antiquities#curio,antiquities#mastermind,antiquities#encroach,antiquities#mausoleum,antiquities#dig,antiquities#bouldertrap'
card_row  antiquities#inscription antiquities#inspector  antiquities#miner     antiquities#profiteer antiquities#collector
card_row  antiquities#curio       antiquities#mastermind antiquities#encroach  antiquities#mausoleum antiquities#dig
card_row  '' '' antiquities#bouldertrap '' ''


echo '<h1 id="dominion" class="w3-center">Antiquities + Dominion</h1>'

html_set 'Unearthing Remains' \
         'antiquities#graveyard,antiquities#shipwreck,antiquities#tombraider,bureaucrat,moneylender,smithy,bandit,sentry,antiquities#mausoleum,antiquities#dig,antiquities#bouldertrap'
card_row  antiquities#graveyard antiquities#shipwreck antiquities#tombraider bureaucrat            moneylender
card_row  smithy                bandit                sentry                 antiquities#mausoleum antiquities#dig
card_row  '' '' antiquities#bouldertrap '' ''

html_set 'Ruined Towns' \
         'cellar,chapel,antiquities#inscription,antiquities#shipwreck,antiquities#tombraider,militia,smithy,bandit,antiquities#agora,antiquities#encroach'
card_row  cellar   chapel  antiquities#inscription antiquities#shipwreck antiquities#tombraider
card_row  militia  smithy  bandit                  antiquities#agora     antiquities#encroach


echo '<h1 id="intrigue" class="w3-center">Antiquities + Intrigue</h1>'

html_set 'City of the Dead' \
         'antiquities#graveyard,lurker,masquerade,antiquities#miner,antiquities#profiteer,wishingwell,conspirator,patrol,antiquities#pyramid,antiquities#mausoleum'
card_row  antiquities#graveyard lurker      masquerade antiquities#miner   antiquities#profiteer
card_row  wishingwell           conspirator patrol     antiquities#pyramid antiquities#mausoleum

html_set 'Shady Dealings' \
         'pawn,shantytown,antiquities#tombraider,baron,antiquities#mendicant,antiquities#snakecharmer,courtier,antiquities#mastermind,antiquities#stronghold,torturer'
card_row  pawn                     shantytown antiquities#tombraider baron                  antiquities#mendicant
card_row  antiquities#snakecharmer courtier   antiquities#mastermind antiquities#stronghold torturer


echo '<h1 id="prosperity" class="w3-center">Antiquities + Prosperity</h1>'

html_set 'Loot City' \
         'antiquities#discovery,antiquities#gamepiece,antiquities#inscription,loan,antiquities#stoneworks,city,vault,antiquities#encroach,goons,hoard'
card_row  antiquities#discovery antiquities#gamepiece antiquities#inscription loan  antiquities#stoneworks
card_row  city                  vault                 antiquities#encroach    goons hoard

html_set 'Kings and Pharaohs' \
         'antiquities#graveyard,antiquities#gamepiece,watchtower,bishop,antiquities#curio,antiquities#stronghold,grandmarket,bank,kingscourt,antiquities#pharaoh'
card_row  antiquities#graveyard  antiquities#gamepiece watchtower bishop     antiquities#curio
card_row  antiquities#stronghold grandmarket           bank       kingscourt antiquities#pharaoh


echo '<h1 id="cornucopia" class="w3-center">Antiquities + Cornucopia</h1>'

html_set 'Pastoral Tales of Yore' \
         'antiquities#discovery hamlet,antiquities#inscription,menagerie,antiquities#profiteer,farmingvillage,antiquities#agora,hornofplenty,huntingparty,antiquities#archaeologist'
card_row  antiquities#discovery hamlet            antiquities#inscription menagerie    antiquities#profiteer
card_row  farmingvillage        antiquities#agora hornofplenty            huntingparty antiquities#archaeologist

html_set "The Pharaoh's Festival" \
         'antiquities#graveyard,fortuneteller,horsetraders,antiquities#mendicant,antiquities#moundbuildervillage,antiquities#stoneworks,tournament,jester,fairgrounds,antiquities#pharaoh'
card_row  antiquities#graveyard  fortuneteller horsetraders antiquities#mendicant antiquities#moundbuildervillage
card_row  antiquities#stoneworks tournament    jester       fairgrounds           antiquities#pharaoh


echo '<h1 id="seaside" class="w3-center">Antiquities + Seaside</h1>'

html_set 'Colonial Archaeology' \
         'fishingvillage,antiquities#miner,warehouse,antiquities#curio,antiquities#agora,outpost,tactician,wharf,antiquities#encroach,antiquities#dig'
card_row  fishingvillage antiquities#miner warehouse antiquities#curio    antiquities#agora
card_row  outpost        tactician         wharf     antiquities#encroach antiquities#dig

html_set 'Treasure Islands' \
         'lighthouse,pearldiver,antiquities#gamepiece,antiquities#shipwreck,antiquities#tombraider,antiquities#collector,navigator,treasuremap,explorer,antiquities#mastermind,antiquities#bouldertrap'
card_row  lighthouse            pearldiver  antiquities#gamepiece antiquities#shipwreck antiquities#tombraider
card_row  antiquities#collector navigator   treasuremap           explorer              antiquities#mastermind
card_row  '' '' antiquities#bouldertrap '' ''


echo '<h1 id="alchemy" class="w3-center">Antiquities + Alchemy</h1>'

html_set 'Academia Arcana' \
         'transmute,apothecary,university,antiquities#discovery,antiquities#profiteer,antiquities#tombraider,antiquities#curio,antiquities#stoneworks,golem,apprentice'
card_row  transmute              apothecary        university             antiquities#discovery antiquities#profiteer
card_row  antiquities#tombraider antiquities#curio antiquities#stoneworks golem                 apprentice

html_set 'Undergrounds Movements' \
         'vineyard,herbalist,scryingpool,antiquities#gravewatcher,antiquities#inspector,familiar,antiquities#aquifer,antiquities#mendicant,antiquities#missionhouse,possession'
card_row  vineyard herbalist           scryingpool           antiquities#gravewatcher antiquities#inspector
card_row  familiar antiquities#aquifer antiquities#mendicant antiquities#missionhouse possession


echo '<h1 id="hinterlands" class="w3-center">Antiquities + Hinterlands</h1>'

html_set 'Histories of the Unmapped World' \
         'antiquities#discovery,foolsgold,antiquities#profiteer,antiquities#stoneworks,cache,cartographer,haggler,antiquities#pyramid,bordervillage,antiquities#dig,antiquities#bouldertrap'
card_row  antiquities#discovery foolsgold antiquities#profiteer antiquities#stoneworks cache
card_row  cartographer          haggler   antiquities#pyramid   bordervillage          antiquities#dig
card_row  '' '' antiquities#bouldertrap '' ''

html_set 'Midnight Runner' \
         'foolsgold,antiquities#gravewatcher,antiquities#inspector,scheme,tunnel,antiquities#collector,antiquities#stoneworks,trader,illgottengains,antiquities#missionhouse'
card_row  foolsgold             antiquities#gravewatcher antiquities#inspector scheme         tunnel
card_row  antiquities#collector antiquities#stoneworks   trader                illgottengains antiquities#missionhouse


echo '<h1 id="darkages" class="w3-center">Antiquities + Dark Ages</h1>'

html_set 'A Dark Underbelly' \
         'beggar,vagrant,antiquities#inspector,antiquities#profiteer,antiquities#collector,rats,antiquities#stoneworks,cultist,mystic,antiquities#mausoleum'
card_row  beggar  vagrant                antiquities#inspector antiquities#profiteer antiquities#collector
card_row  rats    antiquities#stoneworks cultist               mystic                antiquities#mausoleum

html_set 'The Fallen Empire' \
         'antiquities#graveyard,squire,feodum,fortress,banditcamp,antiquities#pyramid,antiquities#stronghold,huntinggrounds,antiquities#archaeologist,antiquities#pharaoh'
card_row  antiquities#graveyard  squire                 feodum         fortress                  banditcamp
card_row  antiquities#pyramid    antiquities#stronghold huntinggrounds antiquities#archaeologist antiquities#pharaoh


echo '<h1 id="guilds" class="w3-center">Antiquities + Guilds</h1>'

html_set 'History is Business' \
         'candlestickmaker,antiquities#tombraider,plaza,antiquities#snakecharmer,baker,antiquities#mastermind,merchantguild,antiquities#missionhouse,soothsayer,antiquities#archaeologist'
card_row  candlestickmaker       antiquities#tombraider plaza                    antiquities#snakecharmer baker
card_row  antiquities#mastermind merchantguild          antiquities#missionhouse soothsayer               antiquities#archaeologist


html_set 'B-Movie Crew' \
         'antiquities#discovery,stonemason,doctor,masterpiece,advisor,antiquities#stoneworks,journeyman,antiquities#pyramid,antiquities#dig,antiquities#pharaoh'
card_row  antiquities#discovery  stonemason doctor              masterpiece     advisor
card_row  antiquities#stoneworks journeyman antiquities#pyramid antiquities#dig antiquities#pharaoh


echo '<h1 id="adventures" class="w3-center">Antiquities + Adventures</h1>'

html_set 'Legend of the Lost City' \
         'antiquities#discovery,guide,antiquities#inscription,duplicate,port,antiquities#stoneworks,lostcity,storyteller,antiquities#archaeologist,antiquities#dig,antiquities#bouldertrap,quest,scoutingparty'
card_row  antiquities#discovery  guide    antiquities#inscription duplicate                 port
card_row  antiquities#stoneworks lostcity storyteller             antiquities#archaeologist antiquities#dig
card_row  antiquities#bouldertrap '' '' '' ''
card_lrow '' quest scoutingparty

html_set 'Festival of Tombs' \
         'antiquities#graveyard,page,antiquities#gamepiece,antiquities#gravewatcher,magpie,transmogrify,antiquities#snakecharmer,antiquities#pyramid,relic,winemerchant,antiquities#bouldertrap,travellingfair'
card_row  antiquities#graveyard page                     antiquities#gamepiece antiquities#gravewatcher magpie
card_row  transmogrify          antiquities#snakecharmer antiquities#pyramid   relic                    winemerchant
card_row  antiquities#bouldertrap '' '' '' ''
card_lrow '' '' travellingfair


echo '<h1 id="empires" class="w3-center">Antiquities + Empires</h1>'

html_set 'Classical Oligarchy' \
         'overlord,antiquities#graveyard,patricianemporium,antiquities#gamepiece,antiquities#miner,archive,capital,forum,antiquities#encroach,antiquities#dig,triumph'
card_row  overlord antiquities#graveyard patricianemporium antiquities#gamepiece antiquities#miner
card_row  archive  capital               forum             antiquities#encroach  antiquities#dig
card_lrow '' '' triumph

html_set "Steampunk 'urbs" \
         'engineer,cityquarter,encampmentplunder,settlersbustlingvillage,castles,antiquities#aquifer,antiquities#stoneworks,antiquities#missionhouse,antiquities#archaeologist,antiquities#pharaoh,defiledshrine,banquet'
card_row  engineer            cityquarter            encampmentplunder        settlersbustlingvillage   castles
card_row  antiquities#aquifer antiquities#stoneworks antiquities#missionhouse antiquities#archaeologist antiquities#pharaoh
card_lrow '' defiledshrine banquet


echo '<h1 id="renaissance" class="w3-center">Antiquities + Renaissance</h1>'

html_set 'Above and Below' \
         'borderguard,antiquities#gravewatcher,flagbearer,antiquities#mendicant,mountainvillage,patron,antiquities#snakecharmer,treasurer,antiquities#mausoleum,antiquities#dig,capitalism,fleet'
card_row  borderguard antiquities#gravewatcher flagbearer antiquities#mendicant mountainvillage
card_row  patron      antiquities#snakecharmer treasurer  antiquities#mausoleum antiquities#dig
card_lrow '' capitalism fleet

html_set 'More Than Meets The Eye' \
         'antiquities#graveyard,actingtroupe,antiquities#gamepiece,antiquities#inscription,antiquities#collector,priest,research,silkmerchant,antiquities#agora,scholar,sinisterplot,citadel'
card_row  antiquities#graveyard actingtroupe antiquities#gamepiece antiquities#inscription antiquities#collector
card_row  priest                research     silkmerchant          antiquities#agora       scholar
card_lrow '' sinisterplot citadel


################################################################################

cat << EOF
<hr>
<div class="w3-center w3-section">
   <img class="w3-margin w3-card-4"
        src="games/antiquities/box.jpg" alt="Antiquities fan expansion">
</div>
<div class="w3-center w3-small"><a href="#top">(top)</a></div>
EOF
html_end
