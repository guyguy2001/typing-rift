Currently, the things the player can move to with the `approach` component are:
* Empty build sites, to build in them (they must first select the building, and then when reaching the tile it will build it).
	* Action item - make it so the player can select the building after reaching the tile.
* Mines/Forests, which when reached, open a sidequest panel.
* Enemies, which the player basic-attacks upon reaching.
	* Action item - make the player follow the enemy when doing so. IDK if it's the responsibility of the `approach` componenet or the the `auto_attack` component.


Let's say I have an empty tile titled "new", and I can type "guardian" to select the guardian in the buidling menu.

I want to support the 2 following flows:
* The player types 'new', and while going to it, types "guardian". Then, when they reach the site, because the guardian is selected in the building menu, it will be built there.
* The player types "new", and gets to the empty tile before selecting the guardian. Then they type "guardian", and when they finish typing it, a guardian gets built in `new`, as the player selected that tile.
