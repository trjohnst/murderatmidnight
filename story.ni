"Murder at Midnight" by Brandon Tate and Thomas Johnston

[

Index
	character interaction
		controls character goals etc
	bodies
		how bodies are created and what they do
	weapons
		definition of kind and actions involving weapons
	ghost actions
		actions ghosts can do
	possession
		gets it's own section cuz it's so big :)
	hiding
		possibly deprecated -> just put an item in a container
	debug area
		area to test features
	game area
		area with pieces for the final game
		
]

[
	character interaction--------------------------------------------
	To do:
		AI, stress test when people go wacko n kill
]
[variables and relations]
A person has a number called maximum stress level.
A person has a number called current stress level.

A person has a list of stored actions called the current plan.

After examining a person:
	Say "[the noun] is [if the current stress level of the noun is greater than the maximum stress level of the noun]stressed[otherwise]not stressed[line break]";

Table of Interactivity
agent	goal	target
Guy	"dislikes"	Harry
Harry	"seeking"	not-wep

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
[Understand "seek in [a container]" as seeking;]
Carry out someone seeking:
	repeat through the Table of Interactivity:
		if person asked is the agent entry:
			let agent be the agent entry;
			let target be the target entry;
			try silently agent taking target;
			if the agent is carrying target:
				say "[agent] says,'Nice, I found [target]'";
				blank out the whole row;
				break;
			try agent opening the noun;
			try silently agent taking target;
			if the agent is carrying target:
				say "[agent] says,'Nice, I found [target]'";
				blank out the whole row;
			break;

[Forced actions per tick]
Every turn:
	[don't need to check vs. player because if it is then nothing will happen]
	let agent be a random visible person that is not Controlled;
	repeat through the Table of Interactivity:
		if agent is the agent entry:
			[next line is for debugging]
			[say "[agent], [agent entry], [goal entry], [target entry][line break]";]
			let target be the target entry;
			if goal entry is "dislikes":
				say "You catch [agent] gazing in annoyance at [target]";
				try agent leaving;
			otherwise if goal entry is "seeking":
				let current be the holder of the person asked;
				let lookin be a random container in current;
				try agent seeking lookin;
			break;

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
[Instead of the player taking something:
	Say "You attempt to grasp [the noun] but your ghastly hand goes right through it";]
Check the player taking something:
	if Controlled is the player:
		say "Your ghastly hands cannot do much with the physical world.";
		stop the action;
	
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

The wardrobe is a closed openable container. It is in the place.
The wep is a weapon. The wep is in the wardrobe.
The not-wep is a thing. The not-wep is in the place.

[
	game area----------------------------------------------------
]
[The player is in the foyer.]
[Jock]
Jeff is a person. He is in the foyer.
The current stress level of Jeff is 0.
The maximum stress level of Jeff is 5.

[Shy, Comforting]
Amanda is a person. She is in the foyer.
The current stress level of Amanda is 0.
The maximum stress level of Amanda is 2.

[Smart]
Eric is a person. He is in the foyer.
The current stress level of Eric is 0.
The maximum stress level of Eric is 3.

[Partier]
Fred is a person. He is in the foyer.
The current stress level of Fred is 0.
The maximum stress level of Fred is 3.
Fred has a number called previous stress level.
The previous stress level of Fred is 0.
Every turn:
	if the previous stress level of Fred is not the current stress level of Fred:
		say "Fred wants to look for a beer";

	

[Events in the Living Room'] 

Living Room is a room.The couch is fixed in place in the Living Room. The Fireplace is fixed in place in the Living Room.  "5 college kids entered with excitement and joy to get the party started. Then 20 seconds later they start to hear voices below the house. " 

 [Setting up the doors for each room ] 

The white door is east of the Living Room and west of The Kitchen. The white door is a door. The door is closed and openable. 

The wood door is west of the Living Room and east of The Basement. The wood door is a door. The door is closed and openable. 

The black door is north of the Living Room and south of The Bedroom. The black door is a door. The door is closed and openable. 

The giant wood door is northeast of the Living Room and southwest of the Foyer. The giant wood door is a door. The door is closed and openable. 

[Events in The Kitchen]

The Kitchen is a room. The stove is fixed in place in The Kitchen.  The Sink is fixed in place in The Kitchen. The cabinet is fixed in place in The Kitchen.   "Jeff went to the kitchen to get some food" 

[Events in The Basement] 

The Basement is a room. "A dark presence lures around the room asking them to leave or die!"  

The skull key is in The Basement.

After taking skull key: say "This will come in handy!"

[Events in The Bedroom] 

The Bedroom is a room.  The bed is fixed in place in the Bedroom. The drawer is fixed in place in the Bedroom. The closet is fixed in place in the Bedroom. "Amanda changed clothes." 

The ancient book is in the Bedrooom. 

[Events in The Foyer] 

The Foyer is a room. "THATS A BIGASS FOYER!" 

[Events in The Secret Room + locakable door + key to unlock the room] 

The Secret Room is a room.  The description is "BOO!" The giant black door is south of the Secret Room and north of the Foyer. The giant black door is a door. The giant black door is lockable and locked. The matching key of the giant black door is a skull key.