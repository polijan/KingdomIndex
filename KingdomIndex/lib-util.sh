#!/bin/sh

################################################################################
# MODULE "UTIL": small util functions (mostly for logging)
################################################################################

log()   { local c; c=$1; shift; printf '%b %s\n' "$c" "$*" >&2; }

msg()   {
   if [ -t 2 ]
      then log '\033[32m[ msg ]\033[0m'                          "$*"
      else log '<span class="w3-text-green">[ msg ]</span>'      "$*"
   fi
}

die()   {
   if [ -t 2 ]
      then log '\033[1;31m[abort]\033[0m'                        "$*"
      else log '<strong class="w3-text-red">[abort]</strong>'    "$*"
   fi
   exit 3
}

warn()  {
   if [ -t 2 ]
      then log '\033[1;33m[warn!]\033[0m'                        "$*"
      else log '<strong class="w3-text-yellow">[warn!]</strong>' "$*"
   fi
}

debug() {
   if [ -t 2 ]
      then log '\033[1;36m[debug]\033[0m'                        "$*"
      else log '<span class="w3-text-blue">[debug]</span>'       "$*"
   fi
}


html_begin() {
cat << EOF
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>$1 - Kingdom Index</title>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="res/w3.css">
   <link rel="stylesheet" href="res/style.css">
</head>
<body class="wood">
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

# feature set: title 'comma-separated-cards'
# create a <h2>title</h2> and a link to the board
# generator page filled with the given cards.
html_set() {
cat << EOF
<div class="w3-cell-row w3-section">
   <div class="w3-cell">
EOF
      printf '<h2>%s</h2>\n' "$1"
      shift
cat << EOF
   </div>

   <div class="w3-cell w3-right-align">
      <a class="w3-large w3-btn w3-ripple w3-hover-white w3-hover-text-blue w3-indigo w3-animate-left"
EOF
         printf %s      '   href="/board-generator.html?cards='
         printf %s      "$*" | sed -e 's/ //g' -e 's/#/%23/g' -e 's/,/%2C/g'
         printf %s      '"'
cat << EOF
      > Generate </a>
   </div>
</div>
EOF
}
