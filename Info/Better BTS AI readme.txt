[B]Installation Instructions[/B]
_________________________

Better BTS AI requires Civ4: Beyond the Sword patched to 3.19.  There are two ways to use Better BTS AI:

1	As a mod.  Place the Better BTS AI folder which contains this readme and the Assets folder in your equivalent of "C:\Program Files\Firaxis Games\Sid Meier's Civilization 4\Beyond the Sword\Mods\".  You can then load Better BTS AI as a mod in the normal way or set BTS to autoload Better BTS AI in "\My Games\Beyond the Sword\CivilizationIV.ini".  This method maintains compatibility for online play but the changes in Better BTS AI will only apply when the mod is running (not in other mods, Firaxis scenarios).  [B]Recommended if[/B] you want to easily go back to standard BTS or play online.

2	Replace default files.  The contents of the Assets folder are intended to replace the files located in the same locations in "C:\Program Files\Firaxis Games\Sid Meier's Civilization 4\Beyond the Sword\Assets\".  It is strongly recommended that you copy or backup your current dll and other files which will be replaced (renaming them will work fine) before installing this version.  When the game is not running, simply paste the contents the mod's Assets folder into the same locations in BTS's Assets folder.  This method will make the Better BTS AI changes always apply unless you load a mod with its own DLL.  For online play everyone must have installed Better BTS AI in this way or things may not work correctly.  [B]Recommended if[/B] you always want to use Better BTS AI.

The source code for the changes is also included in a zip.  If you are not a modder, you do not need those files and there is no need to extract them from the zip file.


[B]Save Compatibility[/B]
_________________________

Better BTS AI will always maintain backwards save game compatibility, meaning that you will always be able to load a save from either plain BTS or an earlier version of the mod.  (Note:  If you installed as a mod, then you will be able to load saves with the same mod name.  If you replaced default files, then you'll be able to load games from plain BTS)  However, saves from some versions of the mod cannot be opened in plain BTS or in earlier versions of the mod.  Save-game compatibility (save version:  opens with):

0.90 and higher: Only 0.90 and higher
0.80 - 0.84:  0.80 and higher
0.01 - 0.78:  Any BBAI
Plain BTS:  BTS, any BBAI


[B]New User Interface Features[/B]
_________________________

- Holding down SHIFT+ALT and clicking on a leader in the scoreboard toggles your civ's warplan between WARPLAN_PREPARING_TOTAL and NO_WARPLAN.  This feature can be used to signal to your vassals that they should begin preparing for war with a particular player as well, allowing them to be much better prepared when you declare.  Any warning you can give your vassals will help, but enough time to build one to two units in a city is best.  WARNING: Use of this feature is not multiplayer compatible, WARPLANs are not sent across the network since they're otherwise only used by the AI and so it will lead to OOS errors if you have vassals.
- The scoreboard will show WAR in yellow instead of red when you have declared you are planning a war using the above feature.
- Added line to contact help text explaining that SHIFT+ALT clicking toggles war preparation plans.
- Air units can now be set to explore, they use the same explore logic as AI planes and then have additional logic if that doesn't push a mission.  Note that planes on auto explore always move at the very beginning of your turn!


[B]Customization[/B]
_________________________

There are now several XML global define files controlling different aspects of the mod.  See the particular file for more information.

[I]BBAI_Game_Options_GlobalDefines.xml[/I]: Controls options for new features, including options to change how defensive pacts work, disable victory strategy system, and allow the human player to become a vassal of an AI.

[I]TechDiffusion_GlobalDefines.xml[/I]: Enable and set up the new tech diffusion code which changes how BTS lowers research costs of techs known to many other players.

[I]LeadFromBehind_GlobalDefines.xml[/I]: Controls for the Lead From Behind mod component used in BBAI to help AI make better decisions with its units in stack v stack combat.

[I]BBAI_AI_Variables_GlobalDefines.xml[/I]: Some controls on AI in game decision making at various levels, including stack attacks of cities.

The new AI victory strategy system is also customizable.  There are five new settings for each leader in CIV4LeaderHeadInfos.xml controlling the odds they have of starting the game looking to win a particular type of victory.  The early stages of victory strategy system depend on these odds and have small effects on AI decisions all game long.  Later stages are independent of these odds and depend mainly on the AI detecting it is close to winning in a particular way.

Finally, BBAI includes a new system for easily scaling tech costs by era.  The idea is that tech rates can be easily scaled for all later era techs to adjust for the AI's better handling of its economy.  In CIV4EraInfos.xml, adjust the values for iTechCostModifier.


[B]Merge instructions[/B]
_________________________

DLL:  If the other mod has a custom DLL, you will need to merge the source code and compile a new DLL.  If you don't know what this means, ask for help from the community.  All of the changes in this mod are marked with one of the following tags:  BETTER_BTS_AI_MOD, AI_AUTO_PLAY_MOD, CHANGE_PLAYER, or UNOFFICIAL_PATCH.

Python:  Only the file in Assets\Python\Screens\ contains a fix, the other Python files are only to facilitate testing.  AIAutoPlay and ChangePlayer are very useful for general testing, so consider including them.  Tester contains some test popups specific to this mod.  These components use DrElmerGiggles custom event manager to manage their subscriptions to different Python events.

XML:  You will need to merge over all of the XML files for the mod to work properly, particularly the _GlobalDefines.xml files (which has updated AI variables), the new leader XML files, the new CIV4EraInfos.xml, and the text files Text\CIV4GameText_BetterBTSAI.xml and Text\CIV4GameText_AIAutoPlay.xml (for AI Autoplay python component).  The unit and building XML files included with the mod are from the unofficial patch and are not strictly necessary.


[B]Debug Keyboard Commands[/B]
_________________________

This mod includes the AIAutoPlay and ChangePlayer debug suites from the Revolution mod.  These commands are intended to help debug the game plus are also kind of fun (if you're not playing for real):

Ctrl+Shift+X    AIAutoPlay      Opens popup to start automation for any number of turns.  Pressing while in automation cancels automation.
Ctrl+Shift+M    AIAutoPlay      Automate the rest of the current turn only.
Ctrl+Shift+P    ChangePlayer    Open popup to change the civ and leader type for any player in the game.
Ctrl+Shift+L    ChangePlayer    Open popup to switch which player the human controls.


[B]Changelog[/B]
_________________________

The full change log from plain BTS is in changelog.txt, only the most recent changes are listed below.  There are hundreds of places where AI logic has been overhauled, tweaked, or better integrated with other pieces.

New in Better BTS AI 1.01

Bugfixes


Victory strategy
- Tweaked Conquest 3 and 4 so that they work better for isolated starts and continents maps

War strategy
- Changes to encourage aggressive AI players to consider limited wars in early game to choke opponents, should make first couple eras a little less predictable in normal games
- If AI wants to declare war for a long time but doesn't and has no units moving to start war, it will eventually re-plan its wars (mainly handles case where AI can't move its units into position)
- If AI is preparing a dogpile attack and the enemies of its target break off war, then it will replan
- Improved AI detection of when its wars were cold and it might as well break them off
- When AI has many more units in enemy territory or en route than its enemies have in its territory, it is now less inclined make peace.  Conversely, you can now move a big attack force into AI territory and sue for peace.  Replaced prior flawed city danger based method and expanded to include non-Aggressive AI games.

War tactics
- Fixed issue where AI would pull back its troops to its own borders to regroup instead of regrouping in enemy territory

Tech AI
- Big boost to value placed on ocean-capable transports when AI has naval assault war plans

General AI
- Changed AI_enemyTargetMissionAIs to AI_enemyTargetMissions, now counts how many units are in enemy territory or making war like moves into potential enemy territory