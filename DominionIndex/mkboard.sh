#!/bin/sh

# Usage: $0 [-N] [CARD,...,...] [CARD]...
# prints on stdout an HTML Dominion Board with the given CARDS
#
# OPTIONS:
#   -N where N is 2..6, controls the number of players (default is 2)
#
# ARGUMENTS:
# First argument (after options) can be a comma separated list of cards
# Normally, 10 kingdom cards should be given.
#
# tips:
# to always include Potions,  include the card 'Potion'
# to always include Colonies, include the card 'Colony'
# to always include Ruins  ,  include the (virtual) card 'Ruins'


# this script is meant to be called from the 'app' directory
. ../DominionIndex/lib-util.sh
. ../DominionIndex/lib-card.sh


################################################################################
# This script is organized in different "modules".
# functions or global variables are prefixed with the name of the module.
#-----------.-------------------------------------------------------------------
# MODULE    | DESCRIPTION
#-----------+-------------------------------------------------------------------
# index     | function utility to get and display indexes
#-----------+-------------------------------------------------------------------
# base      | functions to display the base cards decks
#-----------+-------------------------------------------------------------------
# kingdom   | functions to display the kingdom cards decks and the
#           |                 events/landmarks/projects/ways decks
#-----------+-------------------------------------------------------------------
# landscape | functions for landscape decks: events/landmarks/projects/ways
#           |                            and boons/hexes/states/artifacts
#-----------+-------------------------------------------------------------------
# mixed     | functions to display kingdom decks that don't contain all the same
#           | cards [the card order is either 'mixed' (ie. ramdom order)
#           |                              or 'split' (predetermined order)]
#-----------+-------------------------------------------------------------------
# nonsupply | functions to display non-supply cards/decks [cards that are
#           |           gained/acquired via other supply cards or events]
#-----------+-------------------------------------------------------------------
# starthand | functions to display players starting hands
#-----------+-------------------------------------------------------------------
# mat       | functions to display mats (global and players' own)
#-----------+-------------------------------------------------------------------
# token     | functions to display tokens in play
#-----------'-------------------------------------------------------------------
# board     | function to display the board. uses most others modules.
#-----------'-------------------------------------------------------------------
#
# Modules may (or may not) have the following functions:
#----------.--------------------------------------------------------------------
# init     | no args. Initialize modules variables to a suitable default values,
#          | This needs to be called before any other functions of the module.
#----------+--------------------------------------------------------------------
# check    | no args. Update module variables in reaction to adding CARD_NAME.
#          | This gets called when adding a card (board_add)
#----------+--------------------------------------------------------------------
# finalize | no args. Finalize module variables once all cards have been added.
#----------+--------------------------------------------------------------------
# main     | no args. Prints relevant part of the board
################################################################################



################################################################################
# MODULE "INDEX": update alphabetical index
################################################################################

index_init() {
   INDEX_ORD=64  # <- ascii code of current alphabetical index
}

#TODO: document!
# no args, increment index
# args: set up
index_get() {
   case $# in
      0) INDEX_ORD=$((INDEX_ORD + 1))
         INDEX_RAW=$(printf "\\$(printf '%03o' $INDEX_ORD)") ;;
      1) INDEX_RAW=$1 ;;
      *) die 'index_get should have 0 or 1 arg' ;;
   esac
   INDEX="<span class=\"w3-badge w3-blue\">$INDEX_RAW</span>"
}


################################################################################
# MODULE "BASE": functions related to BASE cards
################################################################################
#
# [ ] All       : Copper   : 60 (that includes both base & players' start hands)
#                 Silver   : 40
#                 Gold     : 30
#                 Estate   : 2 player: 8, 3-4 players: 12
#                 Duchy    : 2 player: 8, 3-4 players: 12
#                 Province : 2 player: 8, 3-4 players: 12
#                 Curse    : in the supply, there should be 10 x (#players - 1)
# [ ] Alchemy   : any card with a potion in its cost => Potion (16)
#                 '-> (transmute, vineyard, apothecary, scrying pool,
#                      university, alchemist, familiar, philosopher's stone,
#                      golem, possession)
# [ ] Prosperity: Platinum (8/12) & Colonies (2 player: 8, 3-4 players: 12)
# [ ] Dark Ages : any card with type looters => Ruins (mixed pile)
#                 '-> (cultist, marauder, death cart)
################################################################################

base_init() {
   BASE_POTION=auto
   BASE_COLONY=auto
   BASE_PLATINUM=auto
   BASE_RUINS=auto

   # each players start with 7 coppers in hand (some coppers might
   # get added back here, if heirlooms are used in starting hands)
   BASE_COPPER_N=60
   [ "$BOARD_PLAYERS" -ge 5 ] && BASE_COPPER_N=120
   BASE_COPPER_N=$((BASE_COPPER_N - 7 * BOARD_PLAYERS))
}

# base_check will modify the CARD_TYPE to 'base'
# if it's a base card
base_check() {
   case $CARD_NAME in

   # All: the "basic" bases
   copper|coppers|silver|silvers|gold|golds|curse|curses|estate|estates|duchy|duchies|province|provinces)
      CARD_TYPE='base' ;;

   # Prosperity colony/platinum + Alchemy potions
      colony|colonies) [ $BASE_COLONY = true ] || msg "adding Colony to base cards"
                       BASE_COLONY=true
                       CARD_TYPE='base' ;;
   platinum|platinums) [ $BASE_PLATINUM = true ] || msg "adding Platinum to base cards"
                       BASE_PLATINUM=true
                       CARD_TYPE='base' ;;
    coloniesplatinums) [ $BASE_PLATINUM = true ] || msg "adding Platinums/Colonies to base cards"
                       BASE_PLATINUM=true; BASE_COLONY=true
                       CARD_TYPE='base' ;;
    # ^-- this is a "card" name in Dominion Randomizer app

   # Alchemy: add Potions when a card has potion in its cost or it potion is explicitely passed
      potion|potions|transmute|vineyard|apothecary|scryingpool|university|alchemist|familiar|philosophersstone|golem|possession)
         [ $BASE_POTION = true ] || msg "adding 'Potion' to base cards"
         BASE_POTION=true
         case $CARD_NAME in
            potion*) CARD_TYPE='base' ;;
         esac ;;

   # Dark Ages: add Ruins when there's a "looter" (deathcart|marauder|cultist)
   # or a ruins is given (or the generic 'Ruin(s)')
      deathcart|marauder|cultist|ruin|ruins|abandonedmine|ruinedlibrary|ruinedmarket|ruinedvillage|survivors)
         [ $BASE_RUINS = true ]  || msg "adding 'Ruins' to base cards"
         BASE_RUINS=true
         case $CARD_NAME in
            deathcart|marauder|cultist) ;;
            *) CARD_TYPE='base' ;;
         esac ;;

      *) return ;;
   esac
}

# no args. to call when all cards have been put into the game,
# to make sure base global variables are boleean and consistent
base_finalize() {

## TODO: Colonies ?????
##
## [ "$BASE_COLONY" = auto ] \
## && case $1 in
##      Loan|Trade_Route|Watchtower|Bishop|Monument|Quarry|Talisman|Workers_Village|City|Contraband|Counting_House|Mint|Mountebank|Rabble|Royal_Seal|Vault|Venture|Goons|Grand_Market|Hoard|Bank|Expand|Forge|Kings_Court|Peddler)
##         BASE_COLONY=true  ;;
##      *) BASE_COLONY=false ;;
##   esac

   [ "$BASE_POTION" = true ] || BASE_POTION=false
   [ "$BASE_COLONY" = true ] || BASE_COLONY=false
   [ "$BASE_RUINS"  = true ] || BASE_RUINS=false
   case $BASE_PLATINUM in
      true|false) ;;
               *) BASE_PLATINUM=$BASE_COLONY
                  $BASE_PLATINUM && msg "adding Platinum to base cards" ;;
   esac
}

# no args. display base cards
base_cards() {
   # If possible we'd like to keep 2 lines of 5 cards
   #       [Line1]:  Copper Silver Gold     [slot4]  [slot5]
   #       [Line2]:  Estate Duchy  Province [slot4]  Curse
   # we have 3 slots and 4 conditional cards: Platinum, Colony, Potion, Ruins
   # so sometimes, a 3rd line is needed. We do it this way:
   #
   # If there's no ruins, we can do:
   #   [Line1]: Copper Silver Gold     (Platinum)   (Potion)
   #   [Line2]: Estate Duchy  Province (Colony)     Curse
   # But if there are ruins, we do:
   #   - if no Potions:
   #     [Line1]: Copper Silver Gold     (Platinum)   Ruins
   #     [Line2]: Estate Duchy  Province (Colony)     Curse
   #   - if there are Potion (and Ruins) but no Platinum:
   #     [Line1]: Copper Silver Gold     Potion       Ruins
   #     [Line2]: Estate Duchy  Province (Colony)     Curse
   #   - else => use a 3rd line to display Ruines:
   #     [Line1]: Copper Silver Gold     Platinum     Potion
   #     [Line2]: Estate Duchy  Province (Colony)     Curse
   #     [Line3]:                                     Ruins
   #     (normally Colony is there (as per official rule)
   #      if Platinum is here)

   echo '<h1>Base Cards</h1>'
   local line3=false
   local n=12 # number of victory cards (expect provinces)
   [ "$BOARD_PLAYERS" -eq 2 ] && n=8
   local np # number of provinces
   case $BOARD_PLAYERS in
      6) np=18 ;;
      5) np=15 ;;
      *) np=$n ;;
   esac

   # line 1: Copper Silver Gold ...
   local label_potion=''
   local label_ruins="#$(( 10*(BOARD_PLAYERS - 1) )) (see below)"
   local card4=''; local label4=''
   local card5=''; local label5=''
   if $BASE_PLATINUM; then
      card4='Platinum'
      index_get; label4="${INDEX}.1-12"
   fi
   if $BASE_POTION; then
      index_get; label_potion="${INDEX}.1-12"
      index_get; label_potion="${label_potion}, ${INDEX}.1-4"
   fi

   if ! $BASE_RUINS; then      # ... (Platinum) (Potion)
      $BASE_POTION && card5='Potion' && label5=$label_potion
   elif ! $BASE_POTION; then   # ... (Platinum) Ruins
      card5='ruins';  label5=$label_ruins
   elif ! $BASE_PLATINUM; then # ... Potion Ruins
      card4='Potion'; label4=$label_potion
      card5='ruins' ; label5=$label_ruins
   else                        # ... Platinum Potion (3rd line for Ruins)
      card5='Potion'; label5=$label_potion
      line3=true
   fi

   if [ "$BOARD_PLAYERS" -le 4 ]
      then card_row_labels "#${BASE_COPPER_N}" '#40' '#30' "$label4" "$label5"
      else card_row_labels "#${BASE_COPPER_N}" '#80' '#60' "$label4" "$label5"
   fi
   card_row 'Copper' 'Silver' 'Gold' "$card4" "$card5"


   # line #2: Estate Duchy Province (Colony) Curse
   card4=''; label4=''
   if $BASE_COLONY; then
      card4='Colony'
      index_get; label4="${INDEX}.1-${n}"
   fi
   card_row         'Estate' 'Duchy'  'Province' "$card4"  'Curse'
   card_row_labels  "#${n}"  "#${n}"  "#${np}"   "$label4" "#$(( 10*(BOARD_PLAYERS - 1) ))"

   # line #3 (Ruins when other stuff takes all the space)
   if $line3; then
      card_row         'ruins'        '' '' '' ''
      card_row_labels  "$label_ruins" '' '' '' ''
   fi
}

base_ruins_shuffle() {
   msg 'shuffling to select ruins indexes'

   # 50 ruins (A:Mines, B:Libraries, C:Markets, D:Villages, E:Survivors)
   # shuffle them            : shuf
   # choose the right numbers: head -n $((10 * (BOARD_PLAYERS - 1)))
   # make the count          : sort | uniq -c
   {  printf 'A\nA\nA\nA\nA\nA\nA\nA\nA\nA\n'
      printf 'B\nB\nB\nB\nB\nB\nB\nB\nB\nB\n'
      printf 'C\nC\nC\nC\nC\nC\nC\nC\nC\nC\n'
      printf 'D\nD\nD\nD\nD\nD\nD\nD\nD\nD\n'
      printf 'E\nE\nE\nE\nE\nE\nE\nE\nE\nE\n'
   }| shuf                                  |
      head -n $((10 * (BOARD_PLAYERS - 1))) |
      sort | uniq -c
}

# compute indexes for ruins
# need to be called from base_ruins (use its local variables)
base_ruins_index() {
   local count
   count=$(printf %s "$ruins" | awk "/$1/ {print \$1}")
   if [ -z "$count" ]; then
      label='-'
   else
      [ $((n + count)) -gt 12 ] && n=1 && index_get
      label="${INDEX}.${n}"
      n=$((n + count - 1))
      [ "$count" = 1 ] || label="${label}-$n"
      n=$((n + 1))
   fi
}

# no args. display the Ruins pile!
base_ruins() {
   echo '<h2>Ruins Pile (shuffled)</h2>' #TODO

   local ruins ; ruins=$(base_ruins_shuffle)
   debug "ruins shuffling:$(printf '\n\033[0m')${ruins}"
   local n=1   ; index_get

   local label
   local a; base_ruins_index 'A'; a=$label;
   local b; base_ruins_index 'B'; b=$label;
   local c; base_ruins_index 'C'; c=$label;
   local d; base_ruins_index 'D'; d=$label;
   local e; base_ruins_index 'E'; e=$label;

   card_row_labels "$a" "$b" "$c" "$d" "$e"
   card_row 'Abandoned Mine' 'Ruined Library' 'Ruined Market' 'Ruined Village' 'Survivors'

}

base_main() {
   base_finalize
   base_cards
   $BASE_RUINS && base_ruins
}



###############################################################################
# MODULE "KINGDOMS": kingdom cards +  events/landmarks/projects/ways decks
###############################################################################
# [ ] All       : 10 kingdom piles
# [ ] Cornucopia: Young Witch => Bane card as an 11th kingdom pile
# [ ] Adventures/Empires/Renaissance/Menagerie/Promo:
#                 (max) TWO cards (A and B) for events/landmarks/projects/ways
###############################################################################

kingdom_init() {
   KINGDOM_1=''; KINGDOM_2='' ; KINGDOM_3=''; KINGDOM_4=''; KINGDOM_5=''
   KINGDOM_6=''; KINGDOM_7='' ; KINGDOM_8=''; KINGDOM_9=''; KINGDOM_10=''
   KINGDOM_11=''
}

kingdom_check() {
   case $CARD_NAME in
      # Cornucopia's "Young Witch"
      youngwitch) KINGDOM_11='11'
                  msg 'Young Witch => setting up 11th Kingdom (Bane)' ;;
   esac
}

# add current card to kingdom pile
kingdom_add() {
   msg "adding '$CARD_NAME' to kingdoms"
   if   [ -z "$KINGDOM_1"  ]; then KINGDOM_1=$CARD_NAME
   elif [ -z "$KINGDOM_2"  ]; then KINGDOM_2=$CARD_NAME
   elif [ -z "$KINGDOM_3"  ]; then KINGDOM_3=$CARD_NAME
   elif [ -z "$KINGDOM_4"  ]; then KINGDOM_4=$CARD_NAME
   elif [ -z "$KINGDOM_5"  ]; then KINGDOM_5=$CARD_NAME
   elif [ -z "$KINGDOM_6"  ]; then KINGDOM_6=$CARD_NAME
   elif [ -z "$KINGDOM_7"  ]; then KINGDOM_7=$CARD_NAME
   elif [ -z "$KINGDOM_8"  ]; then KINGDOM_8=$CARD_NAME
   elif [ -z "$KINGDOM_9"  ]; then KINGDOM_9=$CARD_NAME
   elif [ -z "$KINGDOM_10" ]; then KINGDOM_10=$CARD_NAME
   elif [ "$KINGDOM_11" = '11' ]; then
        if [ "$CARD_NAME" = youngwitch ]
           then warn 'Young Witch as 11th kingdom'
           else msg  "setting up $CARD_NAME as BANE pile"
        fi
        KINGDOM_11=$CARD_NAME
   elif [ -z "$KINGDOM_11" ]; then
        warn "no Young Witch, but asked to set up '$CARD_NAME' as 11th kingdom"
        KINGDOM_11=$CARD_NAME
   else die 'all kingdoms are assigned already'
   fi
}

kingdom_finalize() {
   [ -n "$KINGDOM_1"  ] || KINGDOM_1='01'
   [ -n "$KINGDOM_2"  ] || KINGDOM_2='02'
   [ -n "$KINGDOM_3"  ] || KINGDOM_3='03'
   [ -n "$KINGDOM_4"  ] || KINGDOM_4='04'
   [ -n "$KINGDOM_5"  ] || KINGDOM_5='05'
   [ -n "$KINGDOM_6"  ] || KINGDOM_6='06'
   [ -n "$KINGDOM_7"  ] || KINGDOM_7='07'
   [ -n "$KINGDOM_8"  ] || KINGDOM_8='08'
   [ -n "$KINGDOM_9"  ] || KINGDOM_9='09'
   [ -n "$KINGDOM_10" ] || KINGDOM_10='10'
}

# return 0 if card $1 is *not* in the kingdom
# return the numerical index otherwise
# (it's a bit unusual to use return values to return
#  values and not errors, but it works well in this case)
kingdom_hasnt() {
   card_name "$1"
   [ "$KINGDOM_1"  = "$CARD_NAME" ] && return 1
   [ "$KINGDOM_2"  = "$CARD_NAME" ] && return 2
   [ "$KINGDOM_3"  = "$CARD_NAME" ] && return 3
   [ "$KINGDOM_4"  = "$CARD_NAME" ] && return 4
   [ "$KINGDOM_5"  = "$CARD_NAME" ] && return 5
   [ "$KINGDOM_6"  = "$CARD_NAME" ] && return 6
   [ "$KINGDOM_7"  = "$CARD_NAME" ] && return 7
   [ "$KINGDOM_8"  = "$CARD_NAME" ] && return 8
   [ "$KINGDOM_9"  = "$CARD_NAME" ] && return 9
   [ "$KINGDOM_10" = "$CARD_NAME" ] && return 10
   [ "$KINGDOM_11" = "$CARD_NAME" ] && return 11
   return 0
}

# TODO: remove and use only kingdom_hasnt ?
# usage: kingdom_has CARD
# return 0 if CARD is in the kingdom, non-zero otherwise
kingdom_has() { ! kingdom_hasnt "$1" ;}


# usage: kingdom_label N  [with N in 0..11]
# create index for kingdom N in variable label
# (variable label is declared by kindom_main() calling this)
kingdom_label() {
   local card # the kingdom card
   local n    # number of cards in the pile

   case $1 in
      1) card=$KINGDOM_1  ;;
      2) card=$KINGDOM_2  ;;
      3) card=$KINGDOM_3  ;;
      4) card=$KINGDOM_4  ;;
      5) card=$KINGDOM_5  ;;
      6) card=$KINGDOM_6  ;;
      7) card=$KINGDOM_7  ;;
      8) card=$KINGDOM_8  ;;
      9) card=$KINGDOM_9  ;;
     10) card=$KINGDOM_10 ;;
     11) card=$KINGDOM_11 ;;
   esac

   case $1 in
     11) index_get      ;; #TODO (!!!)
      *) index_get "$1" ;;
   esac

   case $card in

      # generic index card
      01|02|03|04|05|06|07|08|09|10) label=""; return ;;
      11) index_get; label=$INDEX; return ;;

      # victory cards in the kingdom pile => 8/12 cards
      castles|vineyard|greathall|tunnel|gardens|mill|island|silkroad|feodum|cemetery|duke|distantlands|harem|nobles|fairgrounds|farmland)
            n=12
            [ "$BOARD_PLAYERS" -eq 2 ] && n=8 ;;

      # other kingdoms which aren't 10 cards pile (and at most 12 cards)
      port) n=12 ;;

      # kingdoms with >12 cards (use alphabetical indexes)
      rats) local rat1; index_get; rat1=$INDEX;
            local rat2; index_get; rat2=$INDEX;
            label="${rat1}.1-10, ${rat2}.1-10"
            return ;;

      # the usual case => 10 cards
         *) n=10 ;;
   esac

   label="${INDEX}.1-$n"
}


# no args. display kingdoms decks and A/B cards
kingdom_main() {
   kingdom_finalize
   echo '<h1>Kingdom Cards</h1>'

   local label
   local l1; kingdom_label 1; l1=$label
   local l2; kingdom_label 2; l2=$label
   local l3; kingdom_label 3; l3=$label
   local l4; kingdom_label 4; l4=$label
   local l5; kingdom_label 5; l5=$label
   card_row_labels "$l1" "$l2" "$l3" "$l4" "$l5"
   card_row "$KINGDOM_1" "$KINGDOM_2" "$KINGDOM_3" "$KINGDOM_4" "$KINGDOM_5"

   kingdom_label  6; l1=$label
   kingdom_label  7; l2=$label
   kingdom_label  8; l3=$label
   kingdom_label  9; l4=$label
   kingdom_label 10; l5=$label
   card_row "$KINGDOM_6" "$KINGDOM_7" "$KINGDOM_8" "$KINGDOM_9" "$KINGDOM_10"
   card_row_labels "$l1" "$l2" "$l3" "$l4" "$l5"

   if [ -n "$KINGDOM_11" ]; then
      kingdom_label 11
      card_row        "$KINGDOM_11" '' '' '' ''
      card_row_labels "$label"      '' '' '' ''
   fi
}



################################################################################
# MODULE "LANDSCAPE" : Landscape "cards"
# events/landmarks/projects/ways  boons/hexes/states/artifacts

# events/landmarks/projects/ways
# [x] in Adventures, Empires, Renaissance, Menagerie, Promo
#     (max 2 unique of those are in play)
#
# others:
# [ ] Hexes     (Nocturne)  : simulate those with javascript!
# [ ] Boons     (Nocturne)  : simulate those with javascript!
# [x] States    (Nocturne   : 3 unique cards [2 of them double-sided])
# [x] Artifacts (Renaissance: 5 unique cards in Renaissance)
#
################################################################################

landscape_init() {
   LANDSCAPE_A=''
   LANDSCAPE_B=''

   LANDSCAPE_BOONS=false
   LANDSCAPE_HEXES=false

   LANDSCAPE_H1=false
}

landscape_check() {
   case $CARD_NAME in
      # Nocturne's "Doom" cards
      leprechaun|skulk|cursedvillage|tormentor|vampire|werewolf)
         $LANDSCAPE_HEXES || msg "adding 'Hexes'"
         LANDSCAPE_HEXES=true ;;

      # Nocturne's "Fate" cards
      druid|pixie|tracker|fool|bard|blessedvillage|idol|sacredgrove)
         $LANDSCAPE_BOONS || msg "adding 'Boons'"
         LANDSCAPE_BOONS=true ;;
   esac

   case $CARD_TYPE in
      card|base) ;;
      landmark|event|project|way)
         if [ -z "$LANDSCAPE_A" ]; then
            msg "assign '$CARD_NAME' to landscape card A"
            LANDSCAPE_A=$CARD_NAME
         elif [ -z "$LANDSCAPE_B" ]; then
            msg "assign '$CARD_NAME' to landscape card B"
            LANDSCAPE_B=$CARD_NAME
            [ "$LANDSCAPE_A" = "$LANDSCAPE_B" ] &&
               warn "landscape card A and B are duplicates!"
         else
            die "cannot add card '$CARD_NAME' of type '$CARD_TYPE' because both landscape A & B are already assigned"
         fi
         ;;
      *) warn "trying to add '$CARD_NAME' of type '$CARD_TYPE' to the supply" ;;
   esac
}

# landscape_header H2_HEADER
# display a "Landscape Card" header if needed
landscape_header() {
   $LANDSCAPE_H1 || echo '<h1>"Landscape" Cards</h1>'
   LANDSCAPE_H1=true
   printf '<h2>%s</h2>\n' "$1"
}

# artifacts: Renaissance + Nocturne's "lost in the woods" state
landscape_artifacts() {
   # cards in a "landscape card" orientation
   set --
   kingdom_hasnt 'fool'         || set -- "$@" 'lostinthewoods'
   kingdom_hasnt 'borderguard'  || set -- "$@" 'lantern' 'horn'
   kingdom_hasnt 'flagbearer'   || set -- "$@" 'flag'
   kingdom_hasnt 'swashbuckler' || set -- "$@" 'treasurechest'
   kingdom_hasnt 'treasurer'    || set -- "$@" 'key'
   [ -z "$*" ] || landscape_header 'Artifacts (unique)'
   card_lrows "$@"
}

landscape_main() {
   # events/ways/projects landscape cards + boons
   local h=''
   local b='' ; local l=''
   local la=''; local lb=''
   if $LANDSCAPE_BOONS; then
      b='boon'
      h='Boons'
      l='<a href="boon.html" class="w3-badge" target="_blank" contenteditable="false">Get Boon</a>'
   fi
   [ -n "$LANDSCAPE_A" ] && la='<span class="w3-badge w3-red">A</span>'
   [ -n "$LANDSCAPE_B" ] && lb='<span class="w3-badge w3-red">B</span>'
   [ -n "$la$lb" ]  && h="${h}${h:+ + }Events/Landmarks/Ways/Projects"
   if [ -n "$h" ]; then
      landscape_header "$h"
      card_lrow_labels "$l" "$la"          "$lb"
      card_lrow        "$b" "$LANDSCAPE_A" "$LANDSCAPE_B"
   fi

   # hexes
   if $LANDSCAPE_HEXES; then
      l='<a href="hex.html" class="w3-badge" target="_blank" contenteditable="false">Get Hex</a>'
      landscape_header 'Hexes'
      card_lrow       'hex' 'deludedenvious' 'miserabletwicemiserable'
      card_lrow_labels "$l" '(double sided)' '(double sided)'
   fi

   landscape_artifacts
}



################################################################################
# MODULE "MIXED": SUPPLY PILES WHICH ARE MIXED/SPLIT
################################################################################
# Mixed Pile:     [x] DarkAges: Knights
# 5/5 Split Pile: [x] Empires : Catapult,Encampment,Gladiator,Patrician,Settlers
#                 [x] Promos  : Sauna/Avanto in Promos
# Others Splits : [x] Empires : Castle
################################################################################

mixed_init() {
   MIXED_H1=false
}

mixed_check() {
   # if CARD_NAME is from a mixed deck, change card to be the one that
   # should appear in the kingdom of DominionIndex
   case $CARD_NAME in
               catapult|rocks) card_find 'Catapult_Rocks'           ;;
           encampment|plunder) card_find 'Encampment_Plunder'       ;;
            gladiator|fortune) card_find 'Gladiator_Fortune'        ;;
           patrician|emporium) card_find 'Patrician_Emporium'       ;;
     settlers|bustlingvillage) card_find 'Settlers_BustlingVillage' ;;
                 sauna|avanto) card_find 'Sauna_Avanto'             ;;
     humblecastle|crumblingcastle|smallcastle|hauntedcastle|opulentcastle|sprawlingcastle|grandcastle|kingscastle)
        card_find 'Castles' ;;   # ^-- *castle) ?
     dameanna|damejosephine|damemolly|damenatalie|damesylvia|sirbailey|sirdestry|sirmartin|sirmichael|sirvander)
        card_find 'Knights' ;;   # ^-- sir*|dame*) ?
   esac
}

# mixed_header H2_HEADER
# display a 'mixed supply' H1 header if needed and the given h2 header
mixed_header() {
   $MIXED_H1 || echo '<h1>Mixed/Split Supply Piles</h1>'
   MIXED_H1=true
   printf '<h2>%s</h2>\n' "$1"
   msg "add '$1' as mixed/split piles"
}

mixed_split5() { # 5 "$1" card sitting on top of 5 "$2" cards
   index_get $?
   mixed_header "${INDEX} $1/$2 (5/5 split)"
   card_row_labels "${INDEX}.1-5" "${INDEX}.6-10" '' '' ''
   card_row        "$1"           "$2"            '' '' ''
}

mixed_knights() {
   index_get $?
   mixed_header "${INDEX} Knights (shuffled)"
   card_row_labels "${INDEX}.1" "${INDEX}.2"     "${INDEX}.3" "${INDEX}.4"   "${INDEX}.5"
   card_row        'Dame Anna'  'Dame Josephine' 'Dame Molly' 'Dame Natalie' 'Dame Sylvia'
   card_row        'Sir Bailey' 'Sir Destry'     'Sir Martin' 'Sir Michael'  'Sir Vander'
   card_row_labels "${INDEX}.6" "${INDEX}.7"     "${INDEX}.8" "${INDEX}.9"   "${INDEX}.10"
}

mixed_split_castles() {
   index_get $?
   mixed_header "${INDEX} Castles (ordered)"
   if [ "$BOARD_PLAYERS" -le 2 ]
      then card_row_labels "${INDEX}.1"   "${INDEX}.3" "${INDEX}.5"   "${INDEX}.6" ''
      else card_row_labels "${INDEX}.1-2" "${INDEX}.3" "${INDEX}.4-5" "${INDEX}.6" ''
   fi
   card_row 'Humble Castle'  'Crumbling Castle' 'Small Castle' 'Haunted Castle' ''
   card_row 'Opulent Castle' 'Sprawling Castle' 'Grand Castle' "King's Castle"  ''
   if [ "$BOARD_PLAYERS" -le 2 ]
      then card_row_labels "${INDEX}.7"   "${INDEX}.9" "${INDEX}.10" "${INDEX}.12" ''
      else card_row_labels "${INDEX}.7-8" "${INDEX}.9" "${INDEX}.10" "${INDEX}.11-12" ''
   fi
}

mixed_main() {
   kingdom_hasnt 'Knights'                  || mixed_knights
   kingdom_hasnt 'Castles'                  || mixed_split_castles
   kingdom_hasnt 'Catapult_Rocks'           || mixed_split5 'Catapult'   'Rocks'
   kingdom_hasnt 'Encampment_Plunder'       || mixed_split5 'Encampment' 'Plunder'
   kingdom_hasnt 'Gladiator_Fortune'        || mixed_split5 'Gladiator'  'Fortune'
   kingdom_hasnt 'Patrician_Emporium'       || mixed_split5 'Patrician'  'Emporium'
   kingdom_hasnt 'Settlers_BustlingVillage' || mixed_split5 'Settlers'   'Bustling Village'
   kingdom_hasnt 'Sauna_Avanto'             || mixed_split5 'Sauna'      'Avanto'
}



################################################################################
# MODULE "NON-SUPPLY": cards gained/acquired via supply cards or events
################################################################################
#
# cards that have asterisked cost and text distinguishing them as non-supply:
# [x] Cornucopia: Tournament => Prizes (5 unique cards)
# [x] Dark Ages : Hermit  => Madman    pile (10)
# [x] Dark Ages : Urchin  => Mercenary pile (10)
# [x] Dark Ages : Bandit Camp, Marauder, and Pillage   =>   Spoils pile (15)
# [x] Adventures: Page    => Page's    "Travellers upgrades"  (4 piles of 5)
# [x] Adventures: Peasant => Peasant's "Travellers upgrades"  (4 piles of 5)
# [x] Nocturne  : Vampire => exchanges with Bat pile (10)
# [x] Nocturne  : Leprechaun and Magic Lamp (heirloom for SecretCave)
#                                                =>           Wish pile (12)
# [x] Nocturne  : Haunted Mirror                 => Ghost (spirit) pile  (6)
# [x] Nocturne  : Devil's Workshop and Tormentor =>   Imp (spirit) pile (13)
# [x] Nocturne  : The Swamp's Gift (boon) => Will-o'-Wisp (spirit) pile (12)
# [x] Nocturne  : Exorcist => all 3 spirit piles (Will-o'-Wisp, Imp,  Ghost)
# [x] Menagerie : Bargain, Cavalry, Demand, Groom, Hostelry, Livery, Paddock
#                 Ride, Scrap, Sleigh, Stampede, and Supplies =>  Horse (30)
#
# cards with no asterisked cost and no text distinguishing them as non-supply:
# [>] Dark Ages : Shelters     => see players' hand section below
# [>] Nocturne  : Heirlooms    => see players' hand section below
# [>] Nocturne  : Necromancer  => 3 zombies cards: see mats' section
# [ ] Promo     : Black Market => Black Market deck (all different!)
#                 (from Kingdom cards not available in this game's supply)
################################################################################

nonsupply_init() {
   NONSUPPLY_HORSES=false
   NONSUPPLY_H1=false
}

nonsupply_check() {
   case $CARD_NAME in
      # Horses
      sleigh|supplies|scrap|cavalry|groom|hostelry|livery|paddock|ride|bargain|demand|stampede)
         NONSUPPLY_HORSES=true ;;
   esac
}

# nonsupply_header H2_HEADER
# display a 'non-supply' H1 header if needed and the given h2 header
nonsupply_header() {
   $NONSUPPLY_H1 || echo '<h1>Non-Supply Piles</h1>'
   NONSUPPLY_H1=true
   printf '<h2>%s</h2>\n' "$1"
   msg "add '$1' to non-supply pile"
}

# no args. non-supply decks for Cornucopia (prizes)
nonsupply_prizes() {
   kingdom_hasnt 'Tournament' && return
   index_get
   nonsupply_header "${INDEX} Prizes"
   card_row_labels "${INDEX}.1" "${INDEX}.2" "${INDEX}.3" "${INDEX}.4" "${INDEX}.5"
   card_row       'Bag of Gold' 'Diadem'     'Followers'  'Princess'   'Trusty Steed'
}

nonsupply_travellers_page() {
   kingdom_hasnt 'Page' && return
   index_get $?
   local i1; i1=$INDEX
   local i2; index_get; i2=$INDEX
   local i3; index_get; i3=$INDEX
   nonsupply_header "\"${i1} Page\" Upgrades"
   card_row_labels "${i1}.1-10" "${i2}.1-5"       "${i2}.6-10" "${i3}.1-5" "${i3}.6-10"
   card_row        'Page'       'Treasure Hunter' 'Warrior'    'Hero'      'Champion'
}
nonsupply_travellers_peasant() {
   kingdom_hasnt 'Peasant' && return
   index_get $?
   local i1; i1=$INDEX
   local i2; index_get; i2=$INDEX
   local i3; index_get; i3=$INDEX
   nonsupply_header "\"${i1} Peasant\" Upgrades"
   card_row_labels "${i1}.1-10" "${i2}.1-5" "${i2}.6-10" "${i3}.1-5" "${i3}.6-10"
   card_row        'Peasant'    'Soldier'   'Fugitive'   'Disciple'  'Teacher'
}

nonsupply_nocturne() {
   # bat
   local c1=''; local l1=''
   if kingdom_has vampire; then
      c1='wish'
      index_get; l1="${INDEX}.1-10"
   fi

   # wish
   local c2=''; local l2=''
   if kingdom_has leprechaun || starthand_heirloom_has magiclamp; then
      c2='wish'
      index_get; l2="${INDEX}.1-12"
   fi

   # will'o wisp (spirit)
   local c3=''; local l3=''
   if kingdom_has exorcist || $LANDSCAPE_BOONS; then
      c3='willowisp'
      index_get; l3="${INDEX}.1-12"
   fi

   # imp (spirit)
   local c4=''; local l4=''
   if kingdom_has exorcist || kingdom_has tormentor || kingdom_has devilsworkshop; then
      c4='imp'
      index_get; l4="${INDEX}.1-12 + <span class=\"w3-badge\">extra</span>"
   fi

   # ghost (spirit)
   local c5=''; local l5=''
   if kingdom_has exorcist || starthand_heirloom_has hauntedmirror; then
      c5='ghost'
      index_get; l5="${INDEX}.1-6"
   fi

   if [ -n "$c1$c2$c3$c4$c5" ]; then
      nonsupply_header 'Nocturne'
      card_row         "$c1" "$c2" "$c3" "$c4" "$c5"
      card_row_labels  "$l1" "$l2" "$l3" "$l4" "$l5"
   fi
}


# black market (Promo) + horse (Menagerie) + Dark Ages
nonsupply_others() {
   local h=''

   # blackmarket (TODO!!!)
   local c1=''; local l1=''
   if kingdom_has blackmarket; then
      h="${h}${h:+ + }Black Market Deck"
      c1='blackmarketdeck'
      l1='<a href="blackmarket.html" class="w3-badge" target="_blank" contenteditable="false">Black Market</a>'
   fi

   local c2=''; local l2=''
   if $NONSUPPLY_HORSES; then
      h="${h}${h:+ + }Horses"
      c2='horse'
      index_get; l2="${INDEX}.1-12"
      index_get; l2="${l2}, ${INDEX}.1-12"
      index_get; l2="${l2}, ${INDEX}.1-6"
   fi

   # (dark ages) madman
   local c3=''; local l3=''
   if kingdom_has hermit; then
       c3='madman'
       index_get; l3="${INDEX}.1-10"
    fi

   # (dark ages) mercenary
   local c4=''; local l4=''
   if kingdom_has urchin; then
       c4='mercenary'
       index_get; l4="${INDEX}.1-10"
   fi

   # (dark ages) spoils
   local c5=''; local l5=''
   if kingdom_has banditbamp || kingdom_has marauder || kingdom_has pillage; then
       c5='spoils'
       index_get; l5="${INDEX}.1-12"
       index_get; l5="${l5}, ${INDEX}.1-3"
   fi

   [ -n "$c3$c4$c5" ] && h="${h}${h:+ + }Dark Ages"
   if [ -n "$h" ]; then
      nonsupply_header "$h"
      card_row         "$c1" "$c2" "$c3" "$c4" "$c5"
      card_row_labels  "$l1" "$l2" "$l3" "$l4" "$l5"
   fi
}

nonsupply_main() {
   # prizes fit in on row (cornucopia)
   nonsupply_prizes

   # travellers fits its own row (adventures)
   nonsupply_travellers_page
   nonsupply_travellers_peasant

   # nocturne has up to five non-supply cards (bat, wish, 3 spirit piles)
   # so display that in one row
   nonsupply_nocturne

   # and then one row with what's left:
   # - black market (Promo)
   # - Horse (Menagerie)
   # - 3 non-supply cards from Dark Ages
   nonsupply_others
}



################################################################################
# MODULE "STARTHAND": Players' starting hands
################################################################################
# [x] Normally: 7 coppers + 3 estates
# [ ] DarkAges: Shelters may replace the 3 estates
# [ ] Nocturne: Heirlooms may replace some of the coppers
################################################################################

starthand_init() {
   # Regular starting hands (7 Coppers + 3 Estates):
   STARTHAND_C1='Copper'
   STARTHAND_C2='Copper'
   STARTHAND_C3='Copper'
   STARTHAND_C4='Copper'
   STARTHAND_C5='Copper'
   STARTHAND_C6='Copper'
   STARTHAND_C7='Copper'
   STARTHAND_E1='Estate'
   STARTHAND_E2='Estate'
   STARTHAND_E3='Estate'

   # Shelters may replace the Estates:
   STARTHAND_SHELTERS=auto
   # ^--- TODO: put SHELTER on true if one random kingdom is from Dark Ages
   #            http://wiki.dominionstrategy.com/index.php/Shelters
}

starthand_check() {
   case $CARD_NAME in

   # Shelters:

      # one specific shelter: add it, and also change type
      # so that it won't get added in kindgoms
        hovel) [ $STARTHAND_SHELTERS = true ] || msg "adding one shelter: $CARD_NAME"
               STARTHAND_E1=$CARD_NAME
               CARD_TYPE=shelter ;;
        necropolis)
               [ $STARTHAND_SHELTERS = true ] || msg "adding one shelter: $CARD_NAME"
               STARTHAND_E2=$CARD_NAME
               CARD_TYPE=shelter ;;
        overgrownestate)
               [ $STARTHAND_SHELTERS = true ] || msg "adding one shelter: $CARD_NAME"
               STARTHAND_E3=$CARD_NAME
               CARD_TYPE=shelter ;;
      # all shelters
        shelter|shelters)
               #TODO, when it tries to find a card for 'shelters'
               [ $STARTHAND_SHELTERS = true ] || msg "adding Shelters"
               STARTHAND_SHELTERS=true
               CARD_TYPE=shelter ;;

   # Heirlooms:

        # one specific heirloom: add it, and also change type
        # so that it won't get added in kindgoms
        hauntedmirror|magiclamp|goat|pasture|pouch|cursedgold|luckycoin)
           starthand_heirloom_add "$CARD_NAME"
           CARD_TYPE=heirloom ;;

        # kingdom cards associated with the heirlooms:
        cemetery) starthand_heirloom_add 'hauntedmirror' ;;
      secretcave) starthand_heirloom_add 'magiclamp'     ;;
           pixie) starthand_heirloom_add 'goat'          ;;
         sheperd) starthand_heirloom_add 'pasture'       ;;
         tracker) starthand_heirloom_add 'pouch'         ;;
           pooka) starthand_heirloom_add 'cursedgold'    ;;
            fool) starthand_heirloom_add 'luckycoin'     ;;
   esac
}

starthand_finalize() {
   case $STARTHAND_SHELTERS in
      true) STARTHAND_E1='Hovel'
            STARTHAND_E2='Necropolis'
            STARTHAND_E3='Overgrown Estate' ;;
         *) STARTHAND_SHELTERS=false        ;;
   esac
}

starthand_heirloom_has() {
   card_name "$1"
   [ "$STARTHAND_C1"  = "$CARD_NAME" ] || [ "$STARTHAND_C2"  = "$CARD_NAME" ] ||
   [ "$STARTHAND_C3"  = "$CARD_NAME" ] || [ "$STARTHAND_C4"  = "$CARD_NAME" ] ||
   [ "$STARTHAND_C5"  = "$CARD_NAME" ] || [ "$STARTHAND_C6"  = "$CARD_NAME" ] ||
   [ "$STARTHAND_C7"  = "$CARD_NAME" ]
}

# replace a copper in the starting hand with the given heirloom $1
starthand_heirloom_add() {
   msg "replacing a Copper with an Heirloom '$1' in the starting hand"

   # return one copper (per player) to base cards
   BASE_COPPER_N=$((BASE_COPPER_N + BOARD_PLAYERS))

   [ "$STARTHAND_C1" = 'Copper' ] && { STARTHAND_C1=$1; return; }
   [ "$STARTHAND_C2" = 'Copper' ] && { STARTHAND_C2=$1; return; }
   [ "$STARTHAND_C3" = 'Copper' ] && { STARTHAND_C3=$1; return; }
   [ "$STARTHAND_C4" = 'Copper' ] && { STARTHAND_C4=$1; return; }
   [ "$STARTHAND_C5" = 'Copper' ] && { STARTHAND_C5=$1; return; }
   [ "$STARTHAND_C6" = 'Copper' ] && { STARTHAND_C6=$1; return; }
   [ "$STARTHAND_C7" = 'Copper' ] && { STARTHAND_C7=$1; return; }
   die 'cannot set heirloom as starting hand has no copper'
}

starthand_cards() {
   # first row labels (copper/heirlooms)
   local l1=''; local l2=''; local l3=''; local l4=''; local l5=''
   [ "$STARTHAND_C1" = "Copper" ] || l1='ToDo'
   [ "$STARTHAND_C2" = "Copper" ] || l2='ToDo'
   [ "$STARTHAND_C3" = "Copper" ] || l3='ToDo'
   [ "$STARTHAND_C4" = "Copper" ] || l4='ToDo'
   [ "$STARTHAND_C5" = "Copper" ] || l5='ToDo'
   card_row_labels "$l1" "$l2" "$l3" "$l4" "$l5"

   # cards
   card_row "$STARTHAND_C1" "$STARTHAND_C2" "$STARTHAND_C3" "$STARTHAND_C4" "$STARTHAND_C5"
   card_row "$STARTHAND_C6" "$STARTHAND_C7" "$STARTHAND_E1" "$STARTHAND_E2" "$STARTHAND_E3"

   # second row labels (copper/heirlooms)
   l1=''; l2=''
   [ "$STARTHAND_C6" = "Copper" ] || l1='ToDo'
   [ "$STARTHAND_C7" = "Copper" ] || l2='ToDo'

   # second row labels (estates/shelters)
   l3=''; l4=''; l5=''
   if $STARTHAND_SHELTERS; then
      index_get
      if [ "$BOARD_PLAYERS" -le 4 ]; then
         l3="${INDEX}.1-${BOARD_PLAYERS}"
         l4="${INDEX}.5-$((4 + BOARD_PLAYERS))"
         l5="${INDEX}.9-$((8 + BOARD_PLAYERS))"
      else
         l3="${INDEX}.1-4"
         l4="${INDEX}.5-8"
         l5="${INDEX}.9-12"
         index_get
         l3="${l3}, ${INDEX}.1"
         l4="${l4}, ${INDEX}.5"
         l5="${l5}, ${INDEX}.9"
         [ "$BOARD_PLAYERS" -eq 6 ] && { l3="${l3}-2"; l4="${l4}-6"; l5="${l5}-10"; }
      fi
   fi
   card_row_labels "$l1" "$l2" "$l3" "$l4" "$l5"
}

starthand_main() {
   starthand_finalize
   echo "<h1>Starting Hands</h1>"
   starthand_cards
}



################################################################################
# MODULE "MATS"
################################################################################
# [x] All     : Trash is a global mat     (used if there are any trashers:
#                      http://wiki.dominionstrategy.com/index.php/Trasher)
#               always include it (for now) as there are so many trashers.
# [ ] Nocturne: Necromancer => include the Trash + 3 unique zombies cards:
#                              Necromancer      : INDEX.4+
#                              Zombie Apprentice: Index('Necromancer').1
#                              Zombie Mason     : Index('Necromancer').2
#                              Zombie Spy       : Index('Necromancer').3


# All:
# is needed is there's a trasher
# there are so many, that it's best to include it always


# [>] Nocturne  : Necromancer  => 3 zombies cards: see mats' section

################################################################################

mat_init() {
   # no-trash and non-seaside mats
   MAT_TRADEROUTE=false
   MAT_VP=false
   MAT_TAVERN=false
   MAT_COFFERS=false
   MAT_VILLAGERS=false
   MAT_EXILE=false
}

mat_check() {
   case $CARD_NAME in

   # TradeRoute mat
   traderoute) MAT_TRADEROUTE=true ;;

   # VP mat (= VP token)
   castle|castles|crumblingcastle|grandcastle|encampment|encampmentplunder|plunder|patrician|patricianemporium|emporium|triumph|chariotrace|farmersmarket|bishop|monument|ritual|sacrifice|salttheearth|temple|wedding|groundskeeper|wildhunt|conquest|goons|dominate|aqueduct|arena|basilica|baths|battlefield|colonnade|defiledshrine|labyrinth|mountainpass|tomb)
      MAT_VP=true ;;

   # Tavern mat (Adventures: card with Reserve type & Miser)
   coinoftherealm|ratcatcher|guide|duplicate|transmogrify|distantlands|royalcarriage|winemerchant|miser|peasant|soldier|fugitive|disciple|teacher)
      MAT_TAVERN=true ;;

   # Coffers mat (Guilds and Renaissance)
   candlestickmaker|ducat|pageant|exploration|patron|plaza|silkmerchant|baker|butcher|guildhall|merchantguild|spices|swashbuckler|villain)
      MAT_COFFERS=true ;;

   # Villagers (Renaissance)
   lackeys|actingtroupe|exploration|patron|silkmerchant|academy|recruiter|sculptor)
      MAT_VILLAGERS=true ;;

   # Exile mat (Menagerie)
   cameltrain|stockpile|transport|banish|bountyhunter|cardinal|invest|coven|displace|gatekeeper|sanctuary|enclave|wayofthecamel|wayoftheworm)
      MAT_EXILE=true ;;

   esac
}

mat_trash_seaside() {
   local t='Trash'; lt='#1'
   local c3=''; local c4=''; local c5=''

   if kingdom_has 'Necromancer'; then
      msg 'Necromancer => adding Zombies (in the trash)'
      c3='Zombie Apprentice'
      c4='Zombie Mason'
      c5='Zombie Spy'
#      echo '<h2>Trash Mat (global) + Zombies in the trash</h2>'
      index_get
      card_row_labels "$lt" '' "${INDEX}.1" "${INDEX}.2" "${INDEX}.3"
      card_row        "$t"  '' "$c3"        "$c4"        "$c5"
      t=''; lt=''
   fi

   local seaside=false
   # seaside mats: those form a mosaic
   c3=''; c4=''; c5=''
   l3=''; l4=''; l5=''

   kingdom_hasnt 'Island' || {
      index_get $?
      seaside=true; c3='islandmat'
      [ "$BOARD_PLAYERS" -le 2 ] && l3="${INDEX}.11-12" || l3="#$BOARD_PLAYERS"
   }
   kingdom_hasnt 'PirateShip' || {
      index_get $?
      seaside=true; c4='pirateshipmat'
      [ "$BOARD_PLAYERS" -le 2 ] && l4="${INDEX}.11-12" || l4="#$BOARD_PLAYERS"
   }
   kingdom_hasnt 'NativeVillage' || {
      index_get $?
      seaside=true; c5='nativevillagemat'
      [ "$BOARD_PLAYERS" -le 2 ] && l5="${INDEX}.11-12" || l5="#$BOARD_PLAYERS"
   }

   if $seaside; then
#      if [ -n "$t" ]
#         then echo '<h2>Trash Mat (global) / Seaside Mats</h2>'
#         else echo '<h2>Seaside Mats</h2>'
#      fi
      card_row        "$t"  '' "$c3" "$c4" "$c5"
      card_row_labels "$lt" '' "$l3" "$l4" "$l5"
      t=''
   fi

   if [ -n "$t" ]; then
#      echo '<h2>Trash Mat (global)</h2>'
      card_row        "$t"  '' '' '' ''
      card_row_labels "$lt" '' '' '' ''
   fi
}

# display mats we need
mat_main() {
   echo '<h1>Mats</h1>'
   # mats in a "card" orientation
   mat_trash_seaside

   # cards in a "landscape card" orientation
   set --
   $MAT_TRADEROUTE && set -- "$@" traderoutemat
   $MAT_VP         && set -- "$@" victorymat
   $MAT_TAVERN     && set -- "$@" tavernmat
   $MAT_COFFERS    && set -- "$@" coffers
   $MAT_VILLAGERS  && set -- "$@" villagers
   $MAT_EXILE      && set -- "$@" exilemat
   card_lrows "$@"
}



################################################################################
# MODULE "TOKEN"
################################################################################
# VP       : certain cards,events,landmarks (Prosperity and Empires)
# coin     : - Pirate Ship and Trade Route (Seaside)
#            - Sinister Plot project (Renaissance)
#            - mats: Coffers (Guilds and Renaissance), Villagers (Renaissance)
# debt     : certain cards,events,landmarks (from Empires)
# embargo  : Embargo (Seaside)
# cube     : all projects (Renaissance)
# adventure: (Adventures)
################################################################################

token_init() {
   TOKEN_COIN=false
   TOKEN_VP=false
   TOKEN_DEBT=false
   TOKEN_EMBARGO=false
   TOKEN_CUBE=false

   TOKEN_ADV_CARD=false
   TOKEN_ADV_ACTION=false
   TOKEN_ADV_MONEY=false
   TOKEN_ADV_BUY=false

   TOKEN_ADV_TRASHING=false
   TOKEN_ADV_JOURNEY=false
   TOKEN_ADV_ESTATE=false
   TOKEN_ADV_PENALTY=false
   TOKEN_ADV_MINUS2COST=false
   TOKEN_ADV_MINUSCARD=false
}

token_check() {
   case $CARD_NAME in

   # victory tokens / victory mat
   castle|castles|crumblingcastle|grandcastle|encampment|encampmentplunder|plunder|patrician|patricianemporium|emporium|triumph|chariotrace|farmersmarket|bishop|monument|ritual|sacrifice|salttheearth|temple|wedding|groundskeeper|wildhunt|conquest|goons|dominate|aqueduct|arena|basilica|baths|battlefield|colonnade|defiledshrine|labyrinth|mountainpass|tomb)
      TOKEN_VP=true ;;

   # coins tokens (cards without coffers/villagers mats)
   pirateship|traderoute|sinisterplot) TOKEN_COIN=true ;;

   # embargo tokens
   embargo) TOKEN_EMBARGO=true ;;

   # debt tokens
   capital|tax|mountainpass|engineer|triumph|annex|cityquarter|donate|overlord|royalblacksmith|wedding|fortune)
      TOKEN_DEBT=true ;;

   # adventure "vanilla" tokens
   peasant|soldier|fugitive|disciple|teacher)
      TOKEN_ADV_CARD=true
      TOKEN_ADV_ACTION=true
      TOKEN_ADV_MONEY=true
      TOKEN_ADV_BUY=true              ;;
   pathfinding) TOKEN_ADV_CARD=true   ;;
      lostarts) TOKEN_ADV_ACTION=true ;;
      training) TOKEN_ADV_MONEY=true  ;;
        seaway) TOKEN_ADV_BUY=true    ;;

   # adventure "non-vanilla" tokens
   bridgetroll|relic|borrow|ball|raid) TOKEN_ADV_PENALTY=true    ;;
                                 plan) TOKEN_ADV_TRASHING=true   ;;
              ranger|giant|pilgrimage) TOKEN_ADV_JOURNEY=true    ;;
                          inheritance) TOKEN_ADV_ESTATE=true     ;;
                                ferry) TOKEN_ADV_MINUS2COST=true ;;
   esac

   # cube tokens
   case $CARD_TYPE in
      project) TOKEN_CUBE=true ;;
   esac
}

token_finalize() {
   # coin tokens => if we have the mat, then we need coins!
   $MAT_COFFERS   && TOKEN_COIN=true
   $MAT_VILLAGERS && TOKEN_COIN=true

   # victory token = vitory mat
   TOKEN_VP=$MAT_VP
}

token_main() {
   token_finalize
   set --
                                                        #TODO: add a label
   $TOKEN_COIN           && set -- "$@" cointoken       #&infin;
   $TOKEN_VP             && set -- "$@" vptoken         #&infin;
   $TOKEN_DEBT           && set -- "$@" debttoken       #&infin;
   $TOKEN_EMBARGO        && set -- "$@" embargotoken    #&infin;
   $TOKEN_CUBE           && set -- "$@" cubetoken       #&$BOARD_PLAYERS

   $TOKEN_ADV_CARD       && set -- "$@" cardtoken       #&$BOARD_PLAYERS
   $TOKEN_ADV_ACTION     && set -- "$@" actiontoken     #&$BOARD_PLAYERS
   $TOKEN_ADV_MONEY      && set -- "$@" pluscointoken   #&$BOARD_PLAYERS
   $TOKEN_ADV_BUY        && set -- "$@" buytoken        #&$BOARD_PLAYERS

   $TOKEN_ADV_TRASHING   && set -- "$@" trashingtoken   #&$BOARD_PLAYERS
   $TOKEN_ADV_JOURNEY    && set -- "$@" journeytoken    #&$BOARD_PLAYERS
   $TOKEN_ADV_ESTATE     && set -- "$@" estatetoken     #&$BOARD_PLAYERS
   $TOKEN_ADV_PENALTY    && set -- "$@" minuscointoken  #&$BOARD_PLAYERS
   $TOKEN_ADV_MINUS2COST && set -- "$@" minuscosttoken  #&$BOARD_PLAYERS
   $TOKEN_ADV_MINUSCARD  && set -- "$@" minuscardtoken  #&$BOARD_PLAYERS
        # ^-- TODO!!!! currently, this never gets true!!!!
        #     see dominion wiki 'Adventure tokens'

   [ -n "$*" ] && echo '<h1>Tokens</h1>'
   card_rows "$@"
}



################################################################################
# MODULE "BOARD"
################################################################################

board_init() {
   # numbers of players (default is 2, otherwise it's giving as a flag)
   BOARD_PLAYERS=2
   case $1 in
      -2|-3|-4|-5|-6) BOARD_PLAYERS=${1#-*} ;;
      -*) die "unrecognized option: $1"     ;;
   esac
   msg "initializing board (for $BOARD_PLAYERS players)"

   # init modules
   index_init
   base_init
   kingdom_init
   landscape_init
   mixed_init
   nonsupply_init
   starthand_init
   mat_init
   token_init
}

# usage: board_add CARD
# function that modify the global variable to put CARD in the game
board_add() {
   card_find "$1"
   msg "setting up '$CARD_NAME' on the board"

   mixed_check
   base_check
   kingdom_check
   nonsupply_check
   starthand_check
   landscape_check
   mat_check
   token_check

   [ "$CARD_TYPE" = 'card' ] && kingdom_add
}

# print board
board_main() {
   html_begin 'Board'

   base_main
   kingdom_main
   landscape_main
   mixed_main
   nonsupply_main
   starthand_main
   mat_main
   token_main

   echo   '<hr><div class="w3-container w3-center">'
   printf 'Dominion Index - board for %d players (created on %s)\n' \
          "$BOARD_PLAYERS"  "$(date)"
   echo   '</div>'

   html_end
}


# process flag arguments
board_setup() {
   local i

   # we already the player option (if any), so discard it
   case $1 in
      -*) shift ;;
   esac

   # if $1 is a comma-separated lists, transform it into arguments
   case $1 in
      *,*) args=$1; shift
           for i in $(printf %s "$args" | tr -d ' ' | tr , ' '); do
               set -- "$@" "$i"
           done
   esac

   # add all cards
   for i; do
       board_add "$i"
   done
}



################################################################################
# MAIN SCRIPT
################################################################################

main() {
   board_init  "$@"
   board_setup "$@"
   board_main
}

main "$@"
