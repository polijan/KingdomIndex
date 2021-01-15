#!/bin/sh

# Usage: $0
# create game-*.html page showing the cards in the various Dominion expansions
# MUST BE CALLED FROM THE APP DIRECTORY

. ../KingdomIndex/lib-util.sh
. ../KingdomIndex/lib-card.sh
msg "generating game: WDC100 set fan expansion"
html_begin 'WDC 1-100 Set'

cat << EOF

      <div class="w3-display-container w3-center">
         <a href="/start.html"><img src="res/shield.png" alt="shield"></a>
         <h1 class="w3-display-middle w3-jumbo w3-text-deep-orange"
             style="text-shadow:3px 3px 0 #dde">
             Weekly Design Contest<br>A WDC 1-100 Set
         </h1>
      </div>

      <div class="w3-card-4 w3-margin w3-padding w3-round-xlarge w3-container w3-section" style="background-color: rgba(255,255,255,.2); backdrop-filter: blur(6px);">
         <p><strong>Weekly Design Context: A set based on winner cards from WDC (1-100)</strong> (2021)<br>
         <br>This is a set of 25 "winner" cards celebrating the end of the 100th <a href="http://forum.dominionstrategy.com/index.php?board=74.0">Weekly Design Contest</a>.
         <br>Cards by the Dominion Community and compiled and re-arranged by X-tra.
         <br>See: <a href="http://forum.dominionstrategy.com/index.php?topic=20643.0">here</a>.<br>
         <br><details><summary>read more...</summary>
         <blockquote>
         Hello everyone!  Celebrating the end of the 100th Weekly Design
         Contest, an impressive milestone, I thought it could be cute to pool a
         couple of winning cards together into a community-created set. I’ve
         compiled my favourite quarter of these winning cards (25 cards),
         updated some of them with the ever-changing wording of Dominion and
         added/changed pictures on some of them. Multiple questions arise in the
         light of what I’ve just said:

         <h2>1. What determined which card made it into this set? Why wasn’t my submission included here?</h2>
         First of all, it’s nothing personal. These 100 cards all have their merits, if only by how creative they are. But I limited myself to multiple factors, and that filtered a bunch of cards out. Here’s my list of criteria:</li>
         <ul>
            <li>Card had to be the winner of a weekly competition. Runner-ups were sometimes extremely interesting, but there was too much to choose from. So winning cards only.</li>
            <li>No extra components. This eliminates all cards that come with their own tokens, mats, personal out-of-Supply piles and what not.</li>
            <li>No Landscape cards. It’d feel awkward to create a 25-card set with like... 3 Events, y’know. If Landscapes are to be included, there would need to be a good amount of them for them to not look out of place. But there weren’t enough winning Landscape cards, so I decided against including these.</li>
            <li>Simplicity rhymes with priority. The elegance of Dominion comes from the interaction of cards together in a given Kingdom. Not from a card alone doing everything and then some. Donald has been edging closer and closer toward simplicity with his recent-most expansions (Renaissance, Menagerie), and I agree with this design philosophy. So I avoided cards with a massive wall of text on them more than I didn’t.</li>
            <li>A set must hold itself together with a certain number of core cards. For instance, there needs to be enough trashing, enough draw cards, enough payload and enough villages for cards to work well together, should a player decide to play only with this set. But also, there mustn’t be too many Attack cards, too many Kingdom Treasure cards, too many cards with super-duper wacky effects, etc... There’s also a question of cost. The ratio of  -  -  cards in the set must be reasonable. So, sometimes, I had to filter out cards to be able to realize that vision.</li>
        </ul>

        <h2>2. Why did you change the wording on my card? Wasn’t it good enough to begin with?</h2>
        Of course it was! Sometimes, I only changed a couple of things to make the card perhaps less wordy, or perhaps because the Dominion lexicon changed over time. All of this will be explained in each card’s individual entry. But this was all done in good spirits: the mechanics on the card itself remain unchanged (or ultra close to what it was originally).

        <h2>3. What about the art? Why is it different than the art I originally submitted?</h2>
        Not all cards have a different art. But I’m a big sucker for crediting the original artists. Sometimes, I could not find the original piece of art submitted and as such, I could not find the artist to credit. In such cases, I searched for new art to credit it. And even on rarer cases could I not find the original artist on art I added. I hate when this happens… But anyway.
        </blockquote>
        </details>
        </p>
      </div>
EOF


################################################################################

echo '<hr><h1 id="game" class="w3-jumbo">Game Contents</h1>'
card_row  wdc100set#actor        wdc100set#lady                wdc100set#mouse         wdc100set#craftsman    wdc100set#giftexchange
card_row  wdc100set#kingscounsel wdc100set#neighbouringvillage wdc100set#porcelainshop wdc100set#silverworker wdc100set#cats
card_row  wdc100set#charity      wdc100set#countryside         wdc100set#cowrie        wdc100set#fanatic      wdc100set#valleytown
card_row  wdc100set#winecellar   wdc100set#bailiff             wdc100set#crumblingcity wdc100set#farmer       wdc100set#forbiddencity
card_row  wdc100set#judge        wdc100set#motherlywitch       wdc100set#savings       wdc100set#voyage       wdc100set#convoy

################################################################################


cat << EOF
<hr><h1 id="cards" class="w3-jumbo">Details</h1>
<div class="w3-row">


<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Card</strong>: Actor
   <br><strong>Creator</strong>: Belugawhale
   <br><strong>Description</strong>: A simple cantrip card that gives Villagers.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: Poor House now has some company in the 1$ range of Kingdom cards! I won’t be as angry Upgrading or Remaking my Coppers into Actors as I would with Poor House, to be fair. Worst case scenario: I just cantrip my Actors away.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Lady
   <br><strong>Creator</strong>: Fragasnap
   <br><strong>Description</strong>: A cheap utility card; and a cheap source of Buys.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: This card fluctuates between giving you +1 Card and +1 Action, depending on the village availability in the Supply. The +1 Card is perhaps not the best “bonus” you can gather out of your multiple available Actions, but then again, so is the disappearing money version of it too. Still, a cheap +Buy is a cheap +Buy. Sometimes you need that!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Mouse
   <br><strong>Creator</strong>: Somekindoftony
   <br><strong>Description</strong>: A top deck trashing Necropolis that gains copies of itself.
   <br><strong>Changes from the original card</strong>: “Gain a Mouse” was simply moved before the reveal/trashing clause. This was to mimic more how Rats function. Instinctively, it perhaps is better to gain a Mouse before proceeding with the instructions on the card.
   <br><strong>Thoughts</strong>: Mouse unconditionally gains copies of itself. Rats do that as well. But Rats has 20 cards in its Supply pile. As such, I’m pondering whether Mouse should get a bigger Supply pile or not. Otherwise, man, it would be depleted at Mach 5 speed. Mouse really loves being paired with big, juicy draw cards, like Hunting Grounds or Embassy. Since it constantly gains itself, your thirst for villages will probably be quenched after your first Mouse gain. Oh, and the trashing thingy is pretty nice too. Good Copper trasher and good Estate filterer.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Craftsman
   <br><strong>Creator</strong>: Grep
   <br><strong>Description</strong>: A cantrip gainer that works only once per turn.
   <br><strong>Changes from the original card</strong>: The vanilla bonuses were moved above the gaining part. This is just more intuitive and more elegant that way, in my opinion. This barely changes anything too, except that you get to see one more card before you decide whether or not you want to gain a card with Craftsman. Hardly consequential.
   <br><strong>Thoughts</strong>: Cantrip gainers are interesting. Perhaps too easy to spam. But Craftsman solves that issue by having it only work once per turn. So why invest in multiple Craftsman, then? Well, because you can simply decide to cantrip them until you reach the price point you want to gain from with your last Craftsman. Brilliant design! And hey, it may be a Province gainer too, if you work hard enough. Definitely possible on the right Kingdom. But hey, that’s still once per turn, so the abuse is well bounded!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Gift Exchange
   <br><strong>Creator</strong>: Snowyowl
   <br><strong>Description</strong>: A trasher that involves every player; and a gainer from the trash that also involves every player.
   <br><strong>Changes from the original card</strong>: Nearly identical to its original counterpart, save for a “then” I added just before the gaining part.
   <br><strong>Thoughts</strong>: This is the wacky card of the set. The Possession – Masquerade – Ambassador level of “huh?” card. And it’s highly interactive too. Everyone gets to trash from their hand... and if anyone doesn’t feel like it, they can simply move a Gold from the Supply into the trash instead. Careful though! This gives you some Gold gaining ammunition if anyone (including yourself) does. Very wacky card. Probably hard to use. But fun nonetheless!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: King’s Counsel
   <br><strong>Creator</strong>: Naitchman
   <br><strong>Description</strong>: A Throne Room variant involving another player.
   <br><strong>Changes from the original card</strong>: None
   <br><strong>Thoughts</strong>: A King’s Court 4$ cheaper. What! Why? Well, because King’s Counsel’s powers can be wasted by the player to your left, should you not plan carefully. The bigger your hand, the bigger the number of Action cards in it, the easier your opponent can make it “dud”. Ideally, you’ll plan a little bit with King Counsel to make sure just exactly the card you want to triple is forced to be played. King’s Courting has never been so puzzling!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Neighbouring Village
   <br><strong>Creator</strong>: Aquila
   <br><strong>Description</strong>: A utility Necropolis.
   <br><strong>Changes from the original card</strong>: Oof, quite a lot changed. First of all, since Neighbouring Village was first submitted, Menagerie came out and has given us precedence for things happening in this card. So Neighbouring Village now uses a mixture of the wording used in Kiln and Way of the Chameleon. Kiln for the “The next time you play an Action card this turn”, and Way of the Chameleon for the “each time it gives you +[Vanilla Bonus] this turn”. Yes, this means that Neighbouring Village now says “this turn” 2 times, but this was unavoidable.
   <br><strong>Thoughts</strong>: So Neighbouring Village, in itself, is a severely overpriced Necropolis. Truly, its real perk is to improve whichever Action card you play next. A simple Smithy is thus improved to a Hunting Grounds. A Village is now a Stable sans-Treasure discarding condition. A monument is a terminal Gold with double the amount of VP it usually gives! The possibilities are quite large (and fun)! The best cards to use this on are the ones that gives lotsa different vanilla bonuses, such as Market. You know, a Grand Market that says: “+2 Cards, +1 Action, +2 Buys and +3$” is quite a deal!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Porcelain Shop
   <br><strong>Creator</strong>: Snowyowl
   <br><strong>Description</strong>: A payload card that gives coffers.
   <br><strong>Changes from the original card</strong>: Simply merged the two non-Vanilla bonus sentences.
   <br><strong>Thoughts</strong>: Pretty nice how it wants you to accumulate Coffers for you to boom with them. ‘Course, you can immediately spend the one Coffers the moment you play Porcelain Shop. But that, my friend, would be equivalent to you having bought a terminal Silver Action card. Duchess costs 2$, so why did you pay 3$ for this? Letting the Coffers rest for a while brings you closer to a megaturn, which is what Porcelain Shop really wants you to do.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Silver Worker
   <br><strong>Creator</strong>: Chappy7
   <br><strong>Description</strong>: A draw card with Silver interactions.
   <br><strong>Changes from the original card</strong>: Simplified the top part with wording matching the one found on Royal Blacksmith.
   <br><strong>Thoughts</strong>: Smithy, but cheaper. Smithy doesn’t come with a drawback though; and the on-gain clause helps you force that drawback upon others. Indeed, when you gain a Silver Worker, each other player topdecks a Silver, à la Bureaucrat. Should they then play a terminal Silver Worker on their turn, they’re guaranteed to have to discard at least one card. Getting a Silver Worker in your opening split can kind of mess up the split of your opponents, and probably in a good way for them. This could bring them to have something like 4$/5$, perhaps not the most desirable outcome for you.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Cats
   <br><strong>Creator</strong>: Somekindoftony
   <br><strong>Description</strong>: A trash for benefits cantrip.
   <br><strong>Changes from the original card</strong>: Reworded a few things (ex: “If you do” > “If you did”). Changed the drawing wording to include “+Cards”. It interacts with stuff like Way of the Chameleon better like this. The old wording for drawing was also somewhat incomplete. What if you trashed an Overlord, for instance? The $ part of a card’s cost had to be mentioned. Most importantly, the name of this card was changed (the only one in this set who had a name change). It went from “Cat”, to “Cats”. I simply pluralized the name... to match the art better, lol. Also, to match fit with Rats. Rats... cats... only one letter sets them apart!
   <br><strong>Thoughts</strong>: This is pretty much Apprentice, but limited as to what it can trash. You’ll never get more than +2 Cards with it. But, it is cheaper than Apprentice, and it’s also a cantrip. Overall, it’s a pretty neat Estate trasher and you should probably open with Cats.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Charity
   <br><strong>Creator</strong>: Commodore Chuckles
   <br><strong>Description</strong>: A trasher/emulator hybrid.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: A funny way to play that one 5$ nasty Attack card via Estate trashing. The trashing clause is pretty novel. And I like novel ways of trashing. You can pull all sort of weird stuff with Charity, and its simple effects leading to intricate moments is super intriguing. Trashing has always been fun, but Charity makes it extra fun!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Countryside
   <br><strong>Creator</strong>: Scott_Pilgrim
   <br><strong>Description</strong>: A variable alt-VP card.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: This is just a plain awesome Victory card, proving that the design space of pure Victory cards is not that strangled yet. Man, Countryside is a game changer in whichever Kingdom it appears in. Because technically, simply with Estate/Duchy/Province, Countryside can be a Province at half the price. Quite a steal! But... how much green can your deck handle? For each Countryside you add in your deck, you must also add an extra Estate, Duchy and Province for it to keep its 6VP score. Perhaps you won’t want to trash your starting Estates to help them stay above the number of Countryside you add to your deck. Perhaps you can fish for other Victory cards in the Supply, such as Nobles or Harems. Countryside really makes you play a different game!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Cowrie
   <br><strong>Creator</strong>: D782802859
   <br><strong>Description</strong>: An on-call draw card that’s also a Silver.
   <br><strong>Changes from the original card</strong>: Extremely minor changes (capitalised “Buy” from “Buy phase”, separated the on-call effects in two sentences, “on top of” > “onto”).
   <br><strong>Thoughts</strong>: “Uh oh, it’s a Silver+”, they’ll say. Except not really. You’ll only get this one turn out of two. It acts sort of like Coin of the Realm. In fact, it shares the same types. But what Cowrie is trying to achieve is to give you a chance to draw more Treasures during your Buy phase. It even also come with a neat little anti-dud clause. Uselessly drawing an Action card in your Buy phase, save for some fringe cases, is frustrating. But Cowrie’s got you covered. Topdeck it and have it ready to play next turn!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Fanatic
   <br><strong>Creator</strong>: Silverspawn
   <br><strong>Description</strong>: A Lost City+ that worsen your cards with each play.
   <br><strong>Changes from the original card</strong>: Just changed “that card” to “copies of it”. This is less confusing about which particular card “that” card is (“that” implies only one card getting downgraded).
   <br><strong>Thoughts</strong>: Man, it’s bonkers when you first play Fanatic. A stronger Lost City, and cheaper! Of course, after that, it’s all downhill from there onward. The player to your left can simply say “Fanatic”, and then your strong Lost Cities are Abandoned Mines. Woops. If they’re cocky, they can name another card, waiting for you to play another Fanatic for them to have the opportunity to downgrade yet another card. I can’t wait to see that in action!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Valley Town
   <br><strong>Creator</strong>: Something_Smart
   <br><strong>Description</strong>: A self-Exiling village.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: It’s a village that can do a little more, not unlike Mining Village. Both at 4$, they can sacrifice themselves to help you go a little further. Unlike Mining Village though, I suspect you’ll use the extra push from Valley Town more often than not. I mean, you’ll see them back in your deck when you gain more of them. It’s not over until the Valley Town Supply pile is empty! Anyway. This is simple, elegant and useful. What’s not to love?
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Wine Cellar
   <br><strong>Creator</strong>: ConMan
   <br><strong>Description</strong>: A payload card that grows over time.
   <br><strong>Changes from the original card</strong>: This is the only card in this set that has changed slightly in how it functions. Here, the Coin token is put on Wine Cellar before you can call it. This accelerates it one turn ahead as opposed as to what it was before. This was changed because I felt that it’d be easier for players to remember and to see that they have to put a Coin token on Wine Cellar each turn it is on your Tavern mat, even when you decide not to call it.
   <br><strong>Thoughts</strong>: A nice card that wants to grow over time for an ultimate payload. Multiple Wine Cellars can rest on your Tavern mat, doing their thing until you’re ready to all call them for a bunch of $.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Bailiff
   <br><strong>Creator</strong>: King Leon
   <br><strong>Description</strong>: A draw payload card.
   <br><strong>Changes from the original card</strong>: “per Duchy in your hand” > “per Duchy revealed”.
   <br><strong>Thoughts</strong>: +Cards with +Buys are always cool. Margrave, Barge, Silk Merchant, etc. Bailiff does that as well. But it also provides you with a payload that could be quite large if you decide to invest in Duchies. Bailiff could justify that investment. Two Duchies revealed, for instance, brings it at: “+2 Cards, +1 Buy and +4$”. That’s pretty badass already. Still, the timing of Bailiff is quite awkward. It’s definitely no power card, but that doesn’t invalidate its right to exist.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Crumbling City
   <br><strong>Creator</strong>: Something_Smart
   <br><strong>Description</strong>: A Lost City variant.
   <br><strong>Changes from the original card</strong>: The whole dividing line has been abolished in favour of a simpler wording that imitates Encampment and Outpost (immediate set-aside effect and mentioning your next hand like Outpost does). Functionally slightly different, it still retains the purpose of this card at heart.
   <br><strong>Thoughts</strong>: This is such a cool card. It’s Lost City, but it stays the heck away from your next hand(s). As far as it can be in fact. You’ll have to be careful about triggering shuffles with that one. And if you draw your entire deck anyway, well... Crumbling City will probably be the last card you see as you draw your deck the following turn. Bwa ha ha! This is such a funny concept, I love it!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Farmer
   <br><strong>Creator</strong>: Gubump
   <br><strong>Description</strong>: A draw card which rewards variety.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: This is exactly the missing terminal draw card Cornucopia should’ve had, right down to the theming of this card. This card can technically be a +6 cards if you reveal the right cards. Realistically, it probably won’t go there. This is true for the opposite end of the spectrum too. You uh, probably won’t reveal 6 copies of the same card for +1 Card. You’ll probably end up somewhere in the middle. But Farmer’s high variance is dang cool. And perhaps one will build a deck around this variety-for-benefit it offers!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Forbidden City
   <br><strong>Creator</strong>: Spheremonk
   <br><strong>Description</strong>: A junker, emulator village.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: Man, the cool concepts are flying left and right, it’s baffling! This village can shapeshift into so many things, depending on the top Ruins. And if you’re sick of playing Survivors with Forbidden City, then open your turn with one and filter the Ruins to play something else. It works on so many levels, I’m damned impressed. Gotta love me some cool villages!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Judge
   <br><strong>Creator</strong>: Naitchman
   <br><strong>Description</strong>: A terminal Silver discarding Attack.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: This is a nastier Militia. But not completely game breaking and not as punishing as Pillage. It found quite a comfortable spot between these two cards in fact. A spot so perfect, so okay-to-exist, that I’m surprised we haven’t had a discarding Attack in Dominion like this as of yet. Other players get to protect their two most precious cards in their hand while they’ll probably say goodbye to their third strongest card. Judge is so reasonable, so interactively cool of an Attack that of course it had to be in this set.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Motherly Witch
   <br><strong>Creator</strong>: MeNowDealWithIt
   <br><strong>Description</strong>: A duration draw cursing Attack.
   <br><strong>Changes from the original card</strong>: Removed the dividing line to move away from the “while this is in play” wording Donald avoids more and more nowadays. The wording mimics the one found on Gatekeeper (“until then”, it says).
   <br><strong>Thoughts</strong>: This is Witch, but like, way stronger. In addition of being Witch, it also draws 2 cards on your next turn, just like Wharf does. And Wharf is strong. So if it’s Wharf and Witch, why does it just costs 5$ ? Because, should your opponents play Attack cards until your next turn, on top of the Attack, you’ll also be junked with a Copper. Imagine if they use that time to play a Mountebank. ‘Grats, you just gained a Curse and 2 Coppers. Ouch. So the risk is definitely there. For a card that strong, that risk is worth existing. And hey, look at that, Motherly Witch worsen significantly the more players there are!
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Savings
   <br><strong>Creator</strong>: X-tra
   <br><strong>Description</strong>: A Silver+ that adds/removes Buys.
   <br><strong>Changes from the original card</strong>: Simply switched the two bonuses so that the “+1 Buy” bonus appears first. I can’t explain why... but this felt more “right” this way.
   <br><strong>Thoughts</strong>: Shamelessly self-including a card of mine, harr harr! Bow down to my infinite modesty! So this is indeed a Silver+ for 5$. So far, it falls within the convention laid out by stuff like Royal Seal, Relic, Treasure Trove, etc. But here, you can choose to suck a buy to have a Treasure worth 4$ in play. You’ll need to get that Buy back somehow. Either with another Savings, or ideally, with an Action card like Market. If you can’t afford to remove that Buy, well, you’ve got a non-terminal Woodcutter, which is eeeehhh...
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Voyage
   <br><strong>Creator</strong>: Commodore Chuckles
   <br><strong>Description</strong>: An extra turn giver.
   <br><strong>Changes from the original card</strong>: Used the “during which” wording found on Mission. “at the end of your Action phase” turned into “at the start of your Buy phase”. I think it’s better practice to deal with start of phases over end of phases. Now. I had no choice but to add the “If the previous turn wasn’t yours” clause. Believe me, I really did not want to have to do this. The card already seemed perfectly bound to not give million of turns in a row. But... it’s definitely possible given the right circumstances. March, Village Green and Innovation all make 3+ turns in a row a little too easy to achieve. So unfortunately, Voyage needs that limiting clause.
   <br><strong>Thoughts</strong>: I love Voyage. It’s so beautifully put together. It’s very comparable to Outpost. But whereas Outpost lets you take another turn with a smaller hand size, this does not have such a restriction. However, Outpost still lets you play Treasures and Night cards while Voyage does not. It’s probably stronger than Outpost most of the time, but I’m alright with that. Voyage is too cool of a concept to let that opportunity pass.
</div></div>
<div class="w3-half"><div class="w3-margin w3-padding w3-card w3-white w3-round-xlarge">
   <strong>Name</strong>: Convoy
   <br><strong>Creator</strong>: Gubump
   <br><strong>Description</strong>: A draw card that can give Horses.
   <br><strong>Changes from the original card</strong>: None.
   <br><strong>Thoughts</strong>: A big 6$ card. It draws like Smithy does, but it has the possibility of not being terminal by discarding an Action card. In a pinch, maybe you’ll want to do so. But overall, this is subpar. Compared to Stables, for instance, this is both weaker and more expensive. Now, getting the Horse, that’s more like it! Ideally, you’ll aim for that. But you know what? For all I’ve said about Stables being better and blablabla, simply having the option of discarding an Action for +1 Action is still a nice ability to have.
</div></div>

</div>
<hr>


<div class="w3-card-4 w3-margin w3-padding w3-round-xlarge w3-container w3-section" style="background-color: rgba(255,255,255,.2); backdrop-filter: blur(6px);">
   Some final thoughts:<br>
   I really love how well together these cards synergize! It looks pretty complete to me. However, there are lacking patterns I have noticed over the course of me compiling these cards together. Here are what I believe to be the shortcomings:
   <ul>
      <li>There are simply not enough payload cards. Not enough cards simply give a “+” vanilla bonus for instance. There are payload cards in there, but some of them aren’t too straightforward, like Porcelain Shop and Wine Cellar. Bailiff is too conditional to reliably be a payload card. Meanwhile, Treasures like Cowrie won’t be in play as much as other Treasures can. And Savings needs help to give a decent payload.</li>
      <li>Likewise, trashing is too scarce in this 25-card set. Both Mouse and Cats are limited in what they can trash. Gift Exchange is too erratic to be the centralising trasher in your deck. This pretty much only leaves Charity as a normal trashing card.</li>
      <li>Perhaps there is a little bit too much focus on revealing in this set. (Mouse, King’s Counsel, Silver Worker, Bailiff, Farmer, Judge).</li>
      <li>Finally, it’s a shame that certain concepts only appear once in this set. This makes them stand out as outliers in a less-than-cohesive set. Mechanics appearing on only one card are: Villagers, Coffers, Exile, Ruins, Night and Horses.</li>
   </ul>
   Anyway, that’s all! Enjoy folks. And thank you for all these beautifully crafted cards. I plan on posting one or multiple Kingdom mock-up(s) solely using cards from this set in the near future (perhaps even tonight). It’d be fun to discuss strategy over these Kingdoms. :)
</div>

EOF
html_end
