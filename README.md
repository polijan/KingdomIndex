# Kingdom Index

* [Overview](#overview)
* [Running the “app”](#running-the-app)
   * [Installation](#installation)
   * [Starting the server](#starting-the-server)
   * [Starting the client](#starting-the-client)
* [F.A.Q.](#faq)


## Overview

**Kingdom Index** is a board set-up "app" for the deck-building game [Dominion](https://en.wikipedia.org/wiki/Dominion_%28card_game%29) featuring an "index system" designed to test play fan-created cards or community (unofficial) expansions.

[TODO: INSERT AN  IMAGE / GIF / MOVIE  HERE]

## Running the "app"

### Installation

1. clone the repository: `git clone https://github.com/notevenodd/KingdomIndex.git`
2. call the `./install` script, this will:
   1. clone blakevanlan's [KingdomCreator](https://github.com/blakevanlan/KingdomCreator "KingdomCreator") project. **Kingdom Creator** is a randomizer for Dominion cards and we use it to get the graphics of most Dominion cards (and it's nice being able to use the randomizer also).
   2. set up the `app` directory.

### Starting the server

Use the server script (check its usage), for example:
* `$ ./server` run locally on the default port (8888)
* `$ ./server -w 1234` run server on the network (-w), run it on port 1234

*Notes*:
* **Do NOT run this on a public network!!!** Kingdom Index server is meant to be run locally on your machine or your private secure LAN.
* The server needs the classic Unix utilities and also uses either `Python` or `busybox` to start a CGI-capable HTTP server. I have tested it on my RaspberryPi (Debian-based Linux distro) and my tablet (Android with [Termux](https://termux.com/ "Termux")), but it should run on other "Unix-like" systems too (e.g. Windows with [WSL](https://docs.microsoft.com/en-us/windows/wsl/ "WSL"), MacOS, Chromebook [with Linux support](https://support.google.com/chromebook/answer/9145439?hl=en), etc.) with no or minor modifications.

### Starting the client

Use a (modern) web browser to connect to the `start.html` page (it's important) on the server.
For example, if you have launched the server with no option, that would be: http://localhost:8888/start.html

Notes:
* If you have [qrencode](https://fukuchi.org/works/qrencode/) installed on the server, it will display a QR code with the URL to connect to. This can be convenient to quickly run the client from a tablet (note: displaying the board from a phone doesn't make much sense given the size of the screen)
* in the interface, the indexes next to the cards are editable.

---

## F.A.Q.

##### Q: Should I make my own "*index*" cards to play ? How?

Yes, that *is* the idea! *Index cards* are used as proxies to represent real cards. By watching the board by *Kingdom Index*, you can easily see what card each *index card* represents.

[TODO: INSERT IMAGE HERE]


*Index cards* are divided into twelve-cards piles:
* Each pile has one index, which is either:
 * a number (<span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">1</span> to <span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">10</span>). (numbers are assigned to kingdom cards piles)
 * or a letter (<span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">A</span>, <span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">B</span>, <span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">C</span>, ...) to be assigned to non-kindgom piles
* Each card in a pile also gets an individual number from 1 to 12. (*this is useful for split piles, knights,etc.*)

I designed my *index cards* piles from various medieval/fantasy-themed artwork I picked from the Internet (which is why I don't distribute a hi-res version of them). As I own the 1<sup>st</sup> version of Intrigue (which used to be a 500-cards stand-alone game instead of a 300-cards expansion), I immediately found >200 unused cards to transform into my *index cards* deck. As my Dominion cards are sleeved, I used a regular inkjet printer to prepare papers (18 images with a <span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">1</span>-<span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">10</span>/<span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">A</span>-<span style="background-color:#2196F3;color:#fff;display:inline-block;padding-left:8px;padding-right:8px;text-align:center;border-radius:50%">H</span> "shield" + a 1-12 number) which, once inserted in the sleeves, looked exactly like regular Dominion cards.


##### Q: I want to play Dominion on my computer, not fiddle with cards!

You might want to use the official [Dominion Online](https://www.dominion.games/) port of the game instead.

##### Q: Where to find fan-made cards and expansions?

Look online, at places such as:

* [Dominion Strategy](https://dominionstrategy.com/ "Dominion Strategy") has an active [forum dedicated to Variants, Expansions, and Fan Cards](http://forum.dominionstrategy.com/index.php?board=11.0 "a great forum dedicated to Variants and Fan Cards") where you can find many interesting expansions, cards ideas, and a fantastic [weekly card contest](http://forum.dominionstrategy.com/index.php?topic=18987.0 "weekly card contest").
* Redditors also post custom cards on the [r/dominion](https://old.reddit.com/r/dominion/ "r/dominion") sub-reddit.
* A few expansions can be found [here on BoardGameGeek](https://www.boardgamegeek.com/boardgame/36218/dominion/expansions "here on BoardGameGeek").

##### Q: How to include new cards / expansions into Kingdom Index ?

They should be added in the `games` directory. I included four fan-based expansions ([Antiquities](https://drive.google.com/drive/folders/19r-veyGWQOBQpYZGGdAZpN9A0PNaqvkW), [Salvation](https://boardgamegeek.com/boardgame/80435/salvation-fan-expansion-dominion), [FairyTale](https://boardgamegeek.com/boardgameexpansion/68281/fairy-tale-fan-expansion-dominion), and a [Christmas](https://reddit.com/r/dominion/comments/a6jauy/a_very_dominion_christmas) expansion) as examples so that you can see how they should be included... *(todo: add more explanation)*

##### Q: How can I **design** my own cards / expansion?

* First anf foremost, you should read the **Fan Card Creation Guide**: [here](http://forum.dominionstrategy.com/index.php?topic=20045.0) and [here](http://wiki.dominionstrategy.com/index.php/Fan_Card_Creation_Guide).
* When it comes to graphics design, this [tool](https://shardofhonor.github.io/dominion-card-generator/index.html "tool") may help you.

##### Q: I made my own fan expansion! Could you include it in your project?

Hmmm... I could consider that if:
* your cards have been test-played, reviewed, and well-received (ideally from [here](http://forum.dominionstrategy.com/index.php?board=11.0))
* your cards have graphics, and you can provide them (ideally cards should be 293x473 jpeg images) along with a description, and also your expansion shoudn't infringe copyrights.


##### Q: Can I use *index cards* to map some of the (official) Dominion cards?

*Kingdom Index* can assign indexes to official Dominion cards (except for the basic treasure/victory/curse cards from the base game as those are needed for *every* game)... but if you do so, **you *must* make sure you own the games that include those cards**.

##### Q: I need help! I want Feature X,Y, or Z! I require this and that... 

You're free to ask, however I make **no promise** to consider your request, respond to it, or even read it. I might consider correcting bad bugs or adding important features *if* I could use the change myself *and* it's easy to do. Please understand (and don't get mad at me): I hacked this project quickly for my *personal* use, and do *not* intend to spend much time polishing or maintaining it.
