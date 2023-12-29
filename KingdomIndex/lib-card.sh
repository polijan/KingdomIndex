#!/bin/sh

################################################################################
# MODULE "CARDS": find or print cards
################################################################################

# card_name CARD
# put the 'simple name' of a resources/card in variable CARD_NAME,
# 'simple name' means lowercase and removing spaces and apostrophes
card_name() {
   CARD_NAME=$(printf %s "$1" | tr '[:upper:]' '[:lower:]' | tr -d " '/_-")
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
##card_find() {
##   card_name  "$1"
##   card_find_ 'img/cards' ||
##   card_find_ 'img_index' ||
##   die "cannot find image for '$CARD_NAME'"
##}
card_find() {
   case $1 in
           # for example salvation#monk
      *#*) debug "unofficial card: $1"
           local game; game=${1%#*}
           local name; name=${1#$game#}
           card_name  "$name"
           card_find_ "games/$game" ||
           die "cannot find extra (${game}) image for '$CARD_NAME'"
           card_name "$1" # <--- get fully qualified name with #
           ;;
        *) card_name "$1"
           card_find_ 'img_index' ||
           card_find_ 'img/cards' ||
           die "cannot find image for '$CARD_NAME'"
           ;;
   esac
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
         2) # Cards from an expansion (or the baseset) with a 2nd edition may be
            # returned twice. In that case, we decide to return the card from
            # the 2nd edition.
            CARD_IMG=$(printf %s "$CARD_IMG" | grep '2')
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


# display rows of cards (cards given in arguments)
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
   [ -n "$1" ] && echo   '              class="w3-animate-zoom w3-card-4 w3-border-black w3-round-xlarge w3-hover-sepia"'
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
   [ -n "$1" ] && echo   '              class="w3-animate-zoom w3-card-4 w3-border-black w3-round-xlarge w3-hover-sepia"'
   [ -n "$1" ] && printf '              src="%s" alt="%s" />\n' "$CARD_IMG" "$CARD_NAME"
   [ -z "$1" ] && echo   '              src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=">'
   [ -n "$1" ] && echo   '      </a>'
   echo                  '   </div>'
   echo                  '</div>'
}
