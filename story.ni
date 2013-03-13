"Murder at Midnight" by Brandon Tate and Thomas Johnston

[
	character interaction--------------------------------------------
	To do:
		AI, stress test when people go wacko n kill
]
[variables and relations]
A person has a number called maximum stress level.
A person has a number called current stress level.

After examining a person:
	Say "[the noun] is [if the current stress level of the noun is greater than the maximum stress level of the noun]stressed[otherwise]not stressed";

Trusts relates one person to another (called the trustee). The verb to trust(he trusts, she trusts) implies the trusts relation.

Dominates relates one person to another (called the dominated). The verb to dominate (he dominates) implies the dominates relation.

Likes relates one person to another (called the liked). The verb to like (he likes, she likes) implies the likes relation.

Dislikes relates one person to another (called the disliked). The verb to dislike (he dislikes, she dislikes) implies the dislikes relation.

Outsmart relates one person to another (called the less-smart). The verb to outsmart (he outsmarts, she outsmarts) implies the outsmart relation.

Table of Interactivity
agent	goal	target
Guy	"dislikes"	Harry
Harry	"seeking"	wep

[Character actions]
Leaving is an action applying to nothing.
Carry out someone leaving:
	let current be the holder of the person asked;
	let next be a random room which is adjacent to the current;
	let way be the best route from the current to the next;
	try the person asked going way.
	
Approaching is an action applying to one thing.
Carry out someone approaching:
	let current be the holder of the person asked;
	let next be the holder of the noun;
	let way be the best route from the current to the next;
	try the person asked going way.
	
Seeking is an action applying to one thing.
Carry out  Seeking something:
	let current be the holder of the person asked;
	let lookin be a random container in current;
	say "[person asked] attempts to open [lookin]";
	try opening lookin;
	if the noun is in lookin:
		say "[person asked] attempts to take [the noun]";
		try taking the noun;
	otherwise:
		Say "[The actor] says,'Guess [the noun] isn't in here'";

[Forced actions per tick]
Every turn:
	let operator be a random visible person that is not the player;
	repeat through the Table of Interactivity:
		if operator is the agent entry:
			[say "[operator], [agent entry], [goal entry], [target entry]";]
			[say "[line break]";]
			if goal entry is "dislikes":
				say "You catch [operator] gazing in annoyance at [target entry]";
				try operator leaving;
			otherwise if goal entry is "seeking":
				say "[operator] seeks [target entry]";
			break;

[TODO - put in an infinite loop with a random choice, once an action is done break the loop]
[Every turn:
	if someone (called disliker) who is visible dislikes someone (called dislikee) who is visible:
		say "[line break]You catch [disliker] gazing in annoyance at [dislikee]";
		try disliker leaving;
	otherwise:
		let looker be a random visible person that is not the player;
		try looker seeking wep.]
[plan rules]




[
	bodies -------------------------------------------------------------
]
[
A body is a kind of thing. A body is a part of every person.

Body-possession relates one person to one body. The verb to be owner of implies the body-possession relation.
]
[When play begins:
	repeat with victim running through people:
		let the corpse be a random body which is part of the victim;
		now the victim is the owner of the corpse.]

[actions to a body apply to the person]
[
Setting action variables when the noun is a body which is part of a person (called owner):
	now the noun is the owner.
Setting action variables when the second noun is a body which is part of a person (called owner):
	now the second noun is the owner.
]



[
	weapons------------------------------------------------------------
]
A weapon is a kind of thing.

[attacking something with a weapon]
Understand the commands "attack" and "punch" and "destroy" and "kill" and "murder" and "hit" and "thump" and "break" and "smash" and "torture" and "wreck" as something new.
Attacking it with is an action applying to one visible thing and one carried thing. Understand "attack [someone] with [something preferably held]" as attacking it with.
Understand the commands "punch" and "destroy" and "kill" and "murder" and "hit" and "thump" and "break" and "smash" and "torture" and "wreck" as "attack".

[can't attack without a weapon]
Check an actor attacking something with something :
	if the second noun is not a weapon:
		if the actor is the player, say "Before attacking with the [The second noun], you realize it will be roughly as effective as hitting someone with a rubber chicken and change your mind.";
		stop the action.

[can't attack something that isn't a person]
Check an actor attacking something with something:
	if the noun is not a person:
		if the actor is the player, say "You strike the inanimate object. [the noun] looks slightly more lifeless but it is hard to tell if you did anything at all to it.";
		stop the action.
		
[carry out attack]
Carry out an actor attacking something with something:
	say "You fell [the noun] with [the second noun]. [the noun]'s lifeless body falls to the ground.";
	remove the noun from play;

[
	ghost actions --------------------------------------------------
	
	ghost can lock doors
	ways of scaring ppl
		closing and locking doors.
]
[Instead of the player taking something when Controlled is the player:]
Instead of the player taking something:
	Say "You attempt to grasp [the noun] but your ghastly hand goes right through it";
	
After pushing or pulling something when Controlled is the player:
	repeat with X running through all the visible people:
		if X is the player:
			next;
		Increase the current stress level of X by 1;



[
	possession--------------------------------------------
	TODO
		-cleaner possessing when already possessing
			ie jumping from person to person
]
Controlled is a person that varies.

[move the possessee along with the player]
Every turn:
	if Controlled is not visible begin;
		if Controlled is possessed begin;
			move Controlled to the location of the player;
			say "The body you possessed follows you.";
		end if;
	end if.

[possessing]
A person can be possessed.
possessing is an action applying to one thing.
Understand "possess [something]" as possessing.
Check possessing when the noun is possessed:
	instead say "You possess [the noun] even more so than you just were.".
Check possessing when Controlled is not the player:
	instead say "You must leave the body you are currently in";
Carry out possessing:
	repeat with X running through (things carried by the noun):
		now the player has X;
	change Controlled to the noun;
	now the noun is possessed.
Report possessing:
	say "You dive into the body of [the noun]. Your new home is squishy and warm."
	
[unpossessing]
unpossessing is an action applying to one thing.
Understand "leave the body of [something]" as unpossessing.
Understand "leave [something]" as unpossessing.

Check unpossessing when the noun is not possessed:
	instead say "Your futile attempts to unpossess [the noun] whom you are not currently possessing are made in vain."
	
Carry out unpossessing:
	[give all items back to the possessee]
	repeat with X running through (things carried by the player):
		now the noun has X;
	[unpossess the noun and set variables]
	now the noun is not possessed;
	change Controlled to the player.
	
Report unpossessing:
	say "You leave the body of [the noun]."

[checking inventory]
Instead of taking inventory:
	if (Controlled is the player):
		say "Ghosts can't carry anything, you silly little ghost!";
	if (Controlled is not the player):
		say "[Controlled] is carrying:[line break]";
		list the contents of the player, with newlines, indented, giving inventory information, including contents, with extra indentation.




[
	hiding------------------------------------------------------------
]
[may just make objects for bodies and then you can put bodies in containers]

[
	debug area----------------------------------------------------
]
The place is a room.
The description of place is "[a list of persons in place]".
The building is a room.
The building is north of the place.

[L is a list of people that varies.
add Guy to L.
add Harry to L.]

Guy is a person in the place. The description of Guy is "[if possessed]He looks rather sickly.[otherwise]A broad shouldered fellow."
The current stress level of Guy is 0;
The maximum stress level of Guy is 3;

Harry is a person in the place.
The current stress level of Harry is 0;
The maximum stress level of Harry is 2;

guy dislikes harry.

The wardrobe is a closed openable container. It is in the place.
The wep is a weapon. The wep is in the wardrobe.
The not-wep is a thing. The not-wep is in the place.
