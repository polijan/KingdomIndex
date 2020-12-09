#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions

# MUST BE CALLED FROM THE APP DIRECTORY
. ../KingdomIndex/lib-util.sh
. ../KingdomIndex/lib-card.sh

################################################################################

begin() { # usage: begin TITLE [BOX_IMG]...
   msg "generating game: $1"
   html_begin "$1"

   echo   '<div class="w3-center">'
#   echo   '<h1 class="w3-jumbo w3-text-indigo"'
#   echo   '    style="text-shadow:3px 2px 0 #999">'
#   printf '    %s\n' "$1"
#   echo   '</h1>'
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
   msg 'generating game: Index'
   html_begin 'Index'
cat <<EOF
   <div class="w3-center">'
   <div class="w3-display-container">
      <img src="res/shield.png" alt="shield">
         <h1 class="w3-display-middle w3-jumbo w3-text-deep-orange"
             style="text-shadow:3px 3px 0 #dde">
             Index</h1>
   </div>
   </div>
EOF

   echo '<h1>Numerical Indexes (Kingdoms)</h1>'
   card_row  01 02 03 04 05
   card_row  06 07 08 09 10
   echo '<h1>Alphabetical Indexes (usually Non-Kingdom)</h1>'
   card_row  A  B  C  D  E
   card_row  '' F  G  H  ''
   echo '<h1>Landscapes (ToDo)</h1>'
   card_lrow horizontal horizontal horizontal
   echo '<h1>Dominion Base Cards + Trash + Tokens</h1>'
   card_row  copper silver gold     ''    generictoken
   card_row  estate duchy  province curse trash
   html_end
}

game_dominion() {
   begin 'Dominion' baseset.jpg baseset2.jpg
   echo '<h1>Base Cards + Trash</h1>'
   card_row copper      silver     gold        ''          trash
   card_row estate      duchy      province    ''          curse
   echo '<h1>Kingdom Cards</h1>'
   echo '    <h2>Common</h2>'
   card_row  cellar     chapel     moat        village     workshop
   card_row  bureaucrat gardens    militia     moneylender remodel
   card_row  smithy     throneroom councilroom festival    laboratory
   card_row  library    market     mine        witch       ''
   echo '    <h2>Second Edition</h2>'
   card_row  harbinger  merchant   vassal      poacher     ''
   card_row  ''         bandit     sentry      artisan     ''
   echo '    <h2>First Edition (Removed)</h2>'
   card_row  ''         chancellor woodcutter  feast       ''
   card_row  ''         spy        thief       adventurer  ''
   echo '<h1>Mats</h1>'
   card_row  ''         ''         trash       ''          ''
   end
}

game_intrigue() {
   begin 'Intrigue' intrigue.jpg intrigue2.jpg
   echo '<h1>Kingdom Cards</h1>'
   echo '    <h2>Common</h2>'
   card_row  courtyard   pawn          masquerade  shantytown    steward
   card_row  swindler    wishingwell   baron       bridge        conspirator
   card_row  ironworks   miningvillage duke        minion        torturer
   card_row  tradingpost upgrade     harem         nobles        ''
   echo '    <h2>Second Edition</h2>'
   card_row  lurker      diplomat      mill        secretpassage ''
   card_row  ''          courtier      patrol      replace       ''
   echo '    <h2>First Edition (Removed)</h2>'
   card_row  ''          secretchamber greathall   coppersmith   ''
   card_row  ''          scout         saboteur    tribute       ''
   echo '<h1>Other Cards (First Edition only): Base + Trash</h1>'
   card_row  copper      silver         gold       ''            trash
   card_row  estate      duchy          province   ''            curse
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
   card_row  ''            pouch          cursedgold  luckycoin      ''
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
   msg 'generating game: Promo'
   html_begin 'Promo Cards'
   echo '<div class="w3-center">'
   echo '   <h1 class="w3-jumbo w3-text-indigo" style="text-shadow:3px 2px 0 #999">'
   echo '       Promo Cards</h1>'
   echo '</div>'

   echo '<h1>Kingdom Cards</h1>'
   card_row  blackmarket   church   dismantle envoy   saunaavanto
   card_row  walledvillage governor stash     captain prince
   echo '<h1>Landscape Cards</h1>'
   card_lrow '' summon ''
   echo '<h1>Split Piles</h1>'
   card_row  saunaavanto '' '' sauna avanto
   html_end
}

game_all() {
   msg 'generating game: All Dominion Games'
   html_begin 'Dominion Games'
   echo '<div class="w3-center">'
   echo '   <h1 class="w3-jumbo w3-text-indigo" style="text-shadow:3px 2px 0 #999">'
   echo '       All Official Dominion Games</h1>'
   echo '</div>'

   echo '<h1>Base Cards</h1>'
   echo '<h2>Treasures / Victories / Curses</h2>'
   card_row  copper        silver        gold         platinum      potion
   card_row  estate        duchy         province     colony        curse
   echo '<h2>Ruins</h2>'
   card_row  abandonedmine ruinedlibrary ruinedmarket ruinedvillage survivors

   echo '<h1>Kingdom Cards</h1>'
   echo '    <h2>Dominion (1 & 2)</h2>'
   card_row  cellar     chapel     moat        village     workshop
   card_row  bureaucrat gardens    militia     moneylender remodel
   card_row  smithy     throneroom councilroom festival    laboratory
   card_row  library    market     mine        witch       ''
   card_row  harbinger  merchant   vassal      poacher     bandit
   card_row  sentry     artisan    ''          chancellor  woodcutter
   card_row  ''         feast      spy         thief       adventurer
   echo '    <h2>Intrigue (1 & 2)</h2>'
   card_row  courtyard   pawn          masquerade  shantytown    steward
   card_row  swindler    wishingwell   baron       bridge        conspirator
   card_row  ironworks   miningvillage duke        minion        torturer
   card_row  tradingpost upgrade       harem       nobles        ''
   card_row  lurker      diplomat      mill        secretpassage courtier
   card_row  patrol      replace       ''          secretchamber greathall
   card_row  ''          coppersmith   scout       saboteur      tribute
   echo '    <h2>Seaside</h2>'
   card_row  embargo    haven          lighthouse    nativevillage    pearldiver
   card_row  ambassador fishingvillage lookout       smugglers        warehouse
   card_row  caravan    cutpurse       island        navigator        pirateship
   card_row  salvager   seahag         treasuremap   bazaar           explorer
   card_row  ''         ghostship      merchantship  outpost          ''
   card_row  ''         tactician      treasury      wharf            ''
   echo '    <h2>Alchemy</h2>'
   card_row  transmute  vineyard   herbalist apothecary        scryingpool
   card_row  university alchemist  familiar  philosophersstone golem
   card_row  apprentice possession ''        ''                ''
   echo '    <h2>Prosperity</h2>'
   card_row  loan          traderoute watchtower     bishop      monument
   card_row  quarry        talisman   workersvillage city        contraband
   card_row  countinghouse mint       mountebank     rabble      royalseal
   card_row  vault         venture    goons          grandmarket hoard
   card_row  bank          expand     forge          kingscourt  peddler
   echo '    <h2>Cornucopia</h2>'
   card_row  hamlet    fortuneteller menagerie   farmingvillage horsetraders
   card_row  remake    tournament    youngwitch  harvest        hornofplenty
   card_row  ''        huntingparty  jester      fairgrounds    ''
   echo '    <h2>Hinterlands</h2>'
   card_row  crossroads    duchess  foolsgold     develop         oasis
   card_row  oracle        scheme   tunnel        jackofalltrades noblebrigand
   card_row  nomadcamp     silkroad spicemerchant trader          cache
   card_row  cartographer  embassy  haggler       illgottengains  highway
   card_row  ''            inn      mandarin      margrave        ''
   card_row  ''            stables  bordervillage farmland        ''
   echo '    <h2>Dark Ages</h2>'
   card_row  poorhouse     beggar        squire       vagrant    forager
   card_row  hermit        marketsquare  sage         storeroom  urchin
   card_row  armory        deathcart     feodum       fortress   ironmonger
   card_row  marauder      procession    rats         scavenger  wanderingminstrel
   card_row  bandofmisfits banditcamp    catacombs    count      counterfeit
   card_row  cultist       graverobber   junkdealer   knights    mystic
   card_row  pillage       rebuild       rogue        altar      huntinggrounds
   echo '    <h2>Guilds</h2>'
   card_row  candlestickmaker stonemason doctor        masterpiece advisor
   card_row  plaza            taxman     herald        baker       butcher
   card_row  ''               journeyman merchantguild soothsayer  ''
   echo '    <h2>Adventures</h2>'
   card_row  coinoftherealm page           peasant        ratcatcher   raze
   card_row  amulet         caravanguard   dungeon        gear         guide
   card_row  duplicate      magpie         messenger      miser        port
   card_row  ranger         transmogrify   artificer      bridgetroll  distantlands
   card_row  giant          hauntedwoods   lostcity       relic        royalcarriage
   card_row  storyteller    swamphag       treasuretrove  winemerchant hireling
   echo '    <h2>Empires</h2>'
   card_row  engineer          cityquarter             overlord         royalblacksmith encampmentplunder
   card_row  patricianemporium settlersbustlingvillage castles          catapultrocks   chariotrace
   card_row  enchantress       farmersmarket           gladiatorfortune sacrifice       temple
   card_row  villa             archive                 capital          charm           crown
   card_row  forum             groundskeeper           legionary        wildhunt        ''
   echo '    <h2>Nocturne</h2>'
   card_row  druid         faithfulhound  guardian    monastery      pixie
   card_row  tracker       changeling     fool        ghosttown      leprechaun
   card_row  nightwatchman secretcave     bard        blessedvillage cemetery
   card_row  conclave      devilsworkshop exorcist    necromancer    shepherd
   card_row  skulk         cobbler        crypt       cursedvillage  denofsin
   card_row  idol          pooka          sacredgrove tormentor      tragichero
   card_row  ''            vampire        werewolf    raider         ''
   echo '    <h2>Renaissance</h2>'
   card_row  borderguard     ducat     lackeys      actingtroupe cargoship
   card_row  experiment      improve   flagbearer   hideout      inventor
   card_row  mountainvillage patron    priest       research     silkmerchant
   card_row  oldwitch        recruiter scepter      scholar      sculptor
   card_row  seer            spices    swashbuckler treasurer    villain
   echo '    <h2>Menagerie</h2>'
   card_row  blackcat     sleigh    supplies     cameltrain goatherd
   card_row  scrap        sheepdog  snowyvillage stockpile  bountyhunter
   card_row  cardinal     cavalry   groom        hostelry   villagegreen
   card_row  barge        coven     displace     falconer   gatekeeper
   card_row  huntinglodge kiln      livery       mastermind paddock
   card_row  sanctuary    fisherman destrier     wayfarer   animalfair

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

   echo '<h1>Non-Supply Piles</h1>'
   card_row  ''            madman           mercenary   spoils     ''
   card_row  ''            wish             bat         horse      ''
   echo '    <h2>Spirits</h2>'
   card_row  ''            willowisp        imp         ghost      ''
   echo '    <h2>Zombies</h2>'
   card_row  ''            zombieapprentice zombiemason zombiespy  ''
   echo '    <h2>Page/Peasant Upgrades</h1>'
   card_row  page          treasurehunter   warrior     hero       champion
   card_row  peasant       soldier          fugitive    disciple   teacher
   echo '    <h2>Prizes (unique)</h2>'
   card_row  bagofgold     diadem           followers   princess   trustysteed
   echo '    <h2>Heirlooms + Shelters (starting hand)</h2>'
   card_row  hauntedmirror magiclamp        goat        pasture    pouch
   card_row  cursedgold    luckycoin        hovel       necropolis overgrownestate

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

   echo '<h1>Landscape Cards "Face-Down" Decks</h1>'
   echo '<h2>Boons</h2>'
   card_lrow theearthsgift   thefieldsgift  theflamesgift
   card_lrow theforestsgift  themoonsgift   themountainsgift
   card_lrow theriversgift   theseasgift    theskysgift
   card_lrow thesunsgift     theswampsgift  thewindsgift
   echo '<h2>Hexes</h2>'
   card_lrow badomens        delusion       envy
   card_lrow famine          fear           greed
   card_lrow haunting        locusts        misery
   card_lrow plague          poverty        war

   echo '<h1>Other Landscape Cards: Artifacts & States</h1>'
   echo '<h2>Unique Artifacts/Unary states</h2>'
   card_lrow flag    horn          key
   card_lrow lantern treasurechest lostinthewoods
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
