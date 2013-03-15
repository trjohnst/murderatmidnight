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

A person can be tough, caring or spineless.
A person is usually spineless.

After examining a person:
	Say "[the noun] is [if the current stress level of the noun is greater than the maximum stress level of the noun]stressed[otherwise]not stressed[line break]";

[If a target value is unused, fill in the name of the agent]
Table of Interactivity
agent	goal	target	target2
Jeff	"seeking"	knife	Jeff
Jeff	"none"	Jeff	Jeff
Jeff	"none"	Jeff	Jeff
Amanda	"dislikes"	Jeff	Amanda
Amanda	"comfort"	Eric	Amanda
Amanda	"none"	Amanda	Amanda
Eric	"explore"	Fred	Fred
Eric	"none"	Fred	Fred
Eric	"none"	Fred	Fred
Fred	"seeking"	beer	Eric
Fred	"none"	Eric	Eric
Fred	"none"	Eric	Eric


[Character actions]
[explore]
Exploring is an action applying to nothing.
Carry out someone exploring:
	let current be the holder of the person asked;
	let checkout be a random thing in current that is not the player;
	silently try taking checkout;
	if person asked carries checkout:
		say "[person asked] looks at [checkout]";
		[if checkout is the ancient book:
			if person asked is Eric:
				say, "dsa";]
	otherwise:
		say "[person asked] looks at [checkout]";
			

[leaving]
Leaving is an action applying to nothing.
Carry out someone leaving:
	let current be the holder of the person asked;
	let next be a random room which is adjacent to the current;
	let way be the best route from the current to the next;
	try the person asked going way.

[seeking
	try picking it up
	else try opening a specified container
		then try picking it up if its in the container
]
Seeking is an action applying to one thing.
Carry out someone seeking:
	repeat through the Table of Interactivity:
		if person asked is the agent entry:
			let agent be the agent entry;
			let target be the target entry;
			try silently agent taking target;
			if the agent is carrying target:
				say "[agent] says,'Nice, I found [target]'";
				now the goal entry is "none";
				break;
			try agent opening the noun;
			try silently agent taking target;
			if the agent is carrying target:
				say "[agent] says,'Nice, I found [target]'";
				now the goal entry is "none";
			otherwise:
				say "[agent] says,'I'm going to go look around'";
				try agent leaving;
			break;

[giving
	if can see receiver -> give
	else -> go to random room to look for receiver'
	
	TODO
		-giving while possessed
]
Giving is an action applying to one thing.
Carry out someone giving something:
	repeat through the Table of Interactivity:
		if person asked is the agent entry:
			let agent be agent entry;
			let receiver be target entry;
			let target be target2 entry;
			if agent carries the target:
				if receiver is visible:
					say "[agent] says,'Here [receiver], you can have this.'[receiver] replies,'Thank you'";
					now the receiver carries the target;
					now the goal entry is "none";
					repeat through the Table of Interactivity:
						if goal entry is "seeking":
							if agent entry is receiver:
								if target entry is target:
									now the goal entry is "none";
				otherwise:
					say "[agent] says,'Hmm, I wonder where [receiver] is'";
					try agent leaving;

[kill
	if has a weapon and target visible -> kill
	if has a weapon and target not visible -> look for target
	if doesn't have a weapon
		add seeking weapon to table if not there
		pursue that
]
Killing is an action applying to one thing.
Carry out someone killing someone:
	if person asked carries a weapon:
		let implement be a random weapon carried by person asked;
		if the noun is visible:
			say "[person asked]'s eyes fill red with blood and they start seizuring. [person asked] screams, 'GAAAAAH', and lunges at [noun] with [implement]";
			try person asked attacking noun with implement;
			say "[line break] With the willful murder of [noun], you're ghastly form thickens and a physical body forms around you. Your curse is lifted and you are free to wander the earth as a mortal.";
			end the game in victory;
		otherwise:
			say "[person asked] says,'Hmm, I wonder where [noun] is'";
			try person asked leaving;
	otherwise:
		let agent be the person asked;
		let isseeking be "false";
		repeat through the Table of Interactivity:
			if agent is the agent entry:
				if the goal entry is "seeking":
					if the target entry is a weapon:
						let current be the holder of the person asked;
						let lookin be a random container in current;
						try agent seeking lookin;
						now isseeking is "true";
		[if isseeking is "false":
			choose a blank row in Table of Interactivity;
			now agent entry is agent;
			now goal entry is "seeking";
			now target entry is knife;
			now target2 entry is agent;]


[comfort
	Character seeks the target to comfort them.
]
Comforting is an action applying to one thing.
Carry out someone comforting someone:
	if the noun is visible:
		say "[person asked] says,'Hey it's alright, [noun]. You don't have to worry.' [the noun] replies, 'Sorry, I guess I got carried away there'";
		now the current stress level of the noun is 0;
		repeat through the Table of Interactivity:
			if goal entry is "comfort":
				if agent entry is person asked:
					if target entry is noun:
						now the goal entry is "none";
	otherwise:
		say "[person asked] says,'Hmm, I wonder where [the noun] is'";
		try person asked leaving;

[Forced actions per tick]
Every turn:
	[don't need to check vs. player because if it is then nothing will happen]
	let agent be a random visible person that is not Controlled;
	repeat through the Table of Interactivity:
		if agent is the agent entry:
			[next line is for debugging]
			[say "[agent], [agent entry], [goal entry], [target entry][line break]";]
			let target be the target entry;
			let target2 be the target2 entry;
			if goal entry is "dislikes":
				if target is visible:
					say "You catch [agent] gazing in annoyance at [target]";
					try agent leaving;
				break;
			otherwise if goal entry is "seeking":
				let current be the holder of the person asked;
				let lookin be a random container in current;
				try agent seeking lookin;
				break;
			otherwise if goal entry is "give":
				try agent giving target2;
				break;
			otherwise if goal entry is "comfort":
				try agent comforting target;
				break;
			otherwise if goal entry is "kill":
				try agent killing target;
				break;
			otherwise if goal entry is "explore":
				try agent exploring;
				break;
			otherwise if goal entry is "fears":
				if target entry is visible:
					try agent leaving;
					break;

[
	bodies--------------------------------------------------------------
]
Table of Bodies
owner	body
Jeff	Jeff's body
Amanda	Amanda's body
Eric	Eric's body
Fred	Fred's body

[Jeffs]
Jeff's body is a thing.
[Amanda]
Amanda's body is a thing.
[Eric]
Eric's body is a thing.
[Fred]
Fred's body is a thing.

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
	let current be the holder of the person asked;
	if Controlled is the player:
		say "[person asked] fells [the noun] with [the second noun]. [the noun]'s lifeless body falls to the ground.";
		[repeat through the Table of Interactivity:
			if agent entry is visible:
				now goal entry is "fears";
				now target entry is person asked;]
	otherwise:
		say "You force [Controlled]'s body to fell [the noun] with [the second noun]. [the noun]'s lifeless body falls to the ground.";
		repeat with X running through visible people:
			if X is player:
				next;
			if X is Controlled:
				next;
			if X is the noun:
				next;
			say "[X] runs in fear";
			try X leaving;
	repeat through the Table of Bodies:
		if the owner entry is the noun:
			now the body entry is in current;
	remove the noun from play;

[
	ghost actions --------------------------------------------------
	
	ghost can scare people by pushing and pulling on things
		if people get too stressed, they go mad and kill another person
]
Check the player taking something:
	if Controlled is the player:
		say "Your ghastly hands cannot do much with the physical world.";
		stop the action;
	
After pushing or pulling something when Controlled is the player:
	let crier be a random visible person;
	say "[crier] says,'Alright tell me someone just [one of]saw[or]heard[stopping] that'";
	repeat with X running through all the visible people:
		if X is the player:
			next;
		Increase the current stress level of X by 1;
		if the current stress level of X is the maximum stress level of X:
			[add kill to goals]
			choose row with a agent of X in Table of Interactivity;
			now the agent entry is X;
			now the goal entry is "kill";
			let target be a random person;
			while X is X:
				if target is the player:
					now target is a random person;
				if target is X:
					now target is a random person;
				if target is not the player:
					if target is not X:
						break;
			now the target2 entry is X;
			



[
	possession--------------------------------------------
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
	debug area----------------------------------------------------
]
The player is in the foyer.
When play begins:
	say "You are eternally cursed by a dark witch for the murder of your wife to be forever bound in the walls of the cabin in which the act was committed. Your only hope is such that someone, in their own free will, commits the same mortal sin that you have done so many years before. As you're ghastly form sits drearily on the floor of your cabin's foyer, you hear the sound of hope knocking at your door.[line break][line break]You hear a muffled voice, 'Yo Eric, you think you gonna finally hook up with Amanda?' Another male voice stutters, 'Well, haha umm you ... umm should no be so discourteous to a la...' A female's voice cuts in, 'Shut up Jeff, you're such a jerk, do you know that?' Then a fourth voice cuts in, 'Woah dudes, chill. Let's just get messed up and party in this house'[line break][line break]The front door opens and a jock bursts in saying,'I am Jeff! Hear me roar. Let's rage it! Spring break '09'Amanda says,'You're such an idiot, It's 2013'Jeff replies, 'Whatever, years are for queers, I call master bedroom!'[line break][line break]As Jeff begins running for your bedroom, lighting strikes the house and Amanda jumps. A red aura surrounds the cabin. Fred says, 'Woah dudes! Look out the windows! Am I trippin?' Eric says,'No you're not I see it too.' Jeff says, 'Whatever nerds, you've never seen a house surrounded by a red glow before? It's just like physics and stuff.' Fred replies, 'Yeah, sure man, I need a drink. I wonder if there's any beer here. Let's all split up and try and find a way out of here.'[line break][line break] Only you know that the witches curse has been reinvigorated. One of these teens must die by their kins hand before the next day for you to return to the mortal world.";

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
		if Fred carries beer:
			say "Fred tenses up, then takes a sip of beer and mellows out";
			now the current stress level of Fred is 0;

The knife is a weapon. The knife is in the kitchen.

[Events in the Living Room'] 
Living Room is a room. The description is "The couch's color has faded and it is torn in various places. There is also a fireplace set in brick. " ;
The couch is a enterable supporter in the Living Room. The couch is fixed in place. The Fireplace is fixed in place in the Living Room. 

 [Setting up the connections for each room ] 
The Kitchen is east of the Living room.
The Kitchen is south of the Foyer.
The basement is west of the Living room.
The bedroom is north of the Living room.
The bedroom is west of the foyer;
The Foyer is northeast of the Living room.

[The Kitchen]
The Kitchen is a room. The description is "Small and in dire need of cleaning. Paint is chipping off of most everything in here."
The stove is fixed in place in The Kitchen.  The Sink is fixed in place in The Kitchen.    
The Icebox is a closed openable container. The Icebox is fixed in place in the Kitchen.
beer is a thing in the icebox.
[After opening the Icebox : say "EWW A DEAD BODY!"]


[The Basement] 
The Basement is a room. The description is "A dark cellar. There is barely room to stand up straight."  

[container - chest] 
The old chest  is a closed openable container.  The old chest is in the The Basement.  The skull key is in the old chest.

Before opening the old chest:
	if the person asked is Amanda:
		say "Amanda struggles to lift the heavy top of the old chest";

After taking skull key: say "[person asked] says, 'Creepy, I wonder if this can get us out of here!'"

[Events in The Bedroom] 
The Bedroom is a room.  The bed is fixed in place in the Bedroom. The bed is a enterable supporter.The drawer is fixed in place in the Bedroom. The closet is fixed in place in the Bedroom. "A meager twin bed sits in the middle of the room. You see a set of drawers, all of which are jammed. There is also a closet." 

[Book item and  decription] 
The ancient book is in the Bedrooom.  

The description of the ancient book is "If you read this you already know that I'm dead. This house is not from our world... It's from the gates of hell! Every minute of every hour made me lose my mind, turning into something that i'm not. An evil spirit is roaming across the rooms tasting your fear. There's a key in the chest somewhere in the house that lead you to freedom. You must leave the house before midnight or else you may be slain by the hand of another."

[container - closet] 
The closet is a closed openable container.  
 
[The Foyer] 
The Foyer is a room. "The foyer is not large but also not small. Although it is not meant as an attractive area of the house, there is a wooden chair to sit in and enjoy the surroundings." 
The wooden chair is in the foyer;

 A wooden chest  is fixed in place in the Foyer. A wooden chest is a closed locked container. 
