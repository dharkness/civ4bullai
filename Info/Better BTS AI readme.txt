[B]Installation Instructions[/B]
_________________________

Better BTS AI requires Civ4: Beyond the Sword patched to 3.19.  There are two ways to use Better BTS AI:

1	As a mod.  Place the Better BTS AI folder which contains this readme and the Assets folder in your equivalent of "C:\Program Files\Firaxis Games\Sid Meier's Civilization 4\Beyond the Sword\Mods\".  You can then load Better BTS AI as a mod in the normal way or set BTS to autoload Better BTS AI in "\My Games\Beyond the Sword\CivilizationIV.ini".  This method maintains compatibility for online play but the changes in Better BTS AI will only apply when the mod is running (not in other mods, Firaxis scenarios).  [B]Recommended if[/B] you want to easily go back to standard BTS or play online.

2	Replace default files.  The contents of the Assets folder are intended to replace the files located in the same locations in "C:\Program Files\Firaxis Games\Sid Meier's Civilization 4\Beyond the Sword\Assets\".  It is strongly recommended that you copy or backup your current dll and other files which will be replaced (renaming them will work fine) before installing this version.  When the game is not running, simply paste the contents the mod's Assets folder into the same locations in BTS's Assets folder.  This method will make the Better BTS AI changes always apply unless you load a mod with its own DLL.  For online play everyone must have installed Better BTS AI in this way or things may not work correctly.  [B]Recommended if[/B] you always want to use Better BTS AI.

The source code for the changes is also included in a zip.  If you are not a modder, you do not need those files and there is no need to extract them from the zip file.


[B]Save Compatibility[/B]
_________________________

Better BTS AI will always maintain backwards save game compatibility, meaning that you will always be able to load a save from either plain BTS or an earlier version of the mod.  (Note:  If you installed as a mod, then you will be able to load saves with the same mod name.  If you replaced default files, then you'll be able to load games from plain BTS)  However, saves from some versions of the mod cannot be opened in plain BTS or in earlier versions of the mod.  Save-game compatibility (save version:  opens with):

0.80 BBAI and higher:  Only 0.80 and higher
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

Some mod options can be enabled or disabled by changing settings in GlobalDefinesAlt.xml.  Here are the important options in that file:

- BBAI_AIR_COMBAT:  Controls modification for air v air combat to make veteran units more valuable, especially when wounded.  Air v air combat is now more much more similar to land combat.  Defaults to ON.
- BBAI_HUMAN_VASSAL_WAR_BUILD:  This setting makes vassals of human players build more military units, anticipating that their human masters will engage in more wars.  In single player, it's better to use the new SHIFT+ALT click feature to set war preparation plans described above, this is intended mainly for multiplayer where that feature should not be used.  Defaults to OFF.
- BBAI_ALLIANCE_OPTION: Changes how defensive pacts work to be more like alliances from earlier versions of Civ.  Pacts now do not cancel on war declarations and your allies will also declare war.  This can easily be abused by a human player, but the option is now avaialable.
- BBAI_HUMAN_AS_VASSAL_OPTION: Allows human player to offer themselves as a vassal to an AI.  The AI has been taught to consider this offer appropriately and some exploits have been resolved.
- TECH_DIFFUSION:  This collection of settings enables and controls the diffusion of technology between a player who knows a tech and one who does not.  A form of tech diffusion exists in vanilla Civ4 where research rate increases based on how many civs you've met who already know a tech.  BBAI includes a revamped system where diffusion rates are higher under open borders and are not affected by how many civs there are on the map.  Defaults to ON.
- TECH_DIFFUSION_WELFARE:  These settings are an extension of tech diffusion which give an extra percentage boost to the research rate of civs who are significantly behind in tech.  It has been designed to keep most smaller civs technologically relevant, while not opening the door for free-loaders.  Defaults to ON.
- TECH_COST:  These settings provide additional control over the rate of tech research.  Since AI research rates are increasing in BBAI, these variables have been exposed to allow customization research rates.

Next, several AI variables have been exposed to XML to allow custom tweaking of AI behavior.  See the BBAI AI variables section of GlobalDefinesAlt.xml.

Finally, BBAI includes a new system for easily scaling tech costs by era.  The idea is that tech rates can be easily scaled for all later era techs to adjust for the AI's better handling of its economy.  In CIV4EraInfos.xml, adjust the values for iTechCostModifier.


[B]Merge instructions[/B]
_________________________

DLL:  If the other mod has a custom DLL, you will need to merge the source code and compile a new DLL.  If you don't know what this means, ask for help from the community.  All of the changes in this mod are marked with one of the following tags:  BETTER_BTS_AI_MOD, AI_AUTO_PLAY_MOD, CHANGE_PLAYER, or UNOFFICIAL_PATCH.

Python:  Only the file in Assets\Python\Screens\ contains a fix, the other Python files are only to facilitate testing.  AIAutoPlay and ChangePlayer are very useful for general testing, so consider including them.  Tester contains some test popups specific to this mod.  These components use DrElmerGiggles custom event manager to manage their subscriptions to different Python events.

XML:  Most XML changes are fixes from the unofficial patch, if you already have these changes then you are fine, otherwise you should merge them.  The exceptions to this are GlobalDefinesAlt.xml (which has updated AI variables), and two files with game text, Text\CIV4GameText_BetterBTSAI.xml and Text\CIV4GameText_AIAutoPlay.xml.  You will want to copy these files over, although the AIAutoPlay text is only needed if you also are using the AIAutoPlay python component.


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

New in Better BTS AI 0.83

Merged in UP 1.40

Bugfix
- Fixed bug where AI would avoid techs leading to maintenance reducing buildings when in financial trouble (thanks Afforess)
- Fixed bug where AI calculated benefit of maintenance reducing buildings and then ignored it when picking techs
- Fixed bug where an AI city with civ, civic, or city bonuses for GP rate would be less inclined to use specialists (thanks Maniac)

City AI
- Cities now consider how many missionaries they already have plus those being trained when deciding whether to train another
- Same as above for executives
- Under most circumstances, barracks now a few steps later in AI build priority queue in early game
- Split early game worker logic out into separate clause to customize
- AI may now build workers first in its capital if it has things for them to do
- Fixed logic for high priority first worker to get access to bonuses, now only counts bonuses which can be improved now or with tech currently being researched
- Cities for a player in a strike situation (very very rare) now will build buildings to help lower costs/raise income, instead of training defenders which would be disbanded anyway
- Removed improper dependence on need for land workers when deciding whether to build early sea workers
- AI cities will now pop or gold rush defenses when civ is in big trouble, especially right after being attacked

Worker AI
- Fixed illogical ordering where city decided how many workers it needed before selecting what it would have them do (caused small problems for deciding when to build workers)

Victory Strategy
- AIs will now send their spaceships even if someone else looks like they're going to beat them, as the other player's capital might be captured (thanks r_rolo1)

Diplomacy
- WHEOOHRN no longer shows exactly when AI begins war plans in all circumstances.  If AI is just planning war, it now only shows after attitude and power denial checks.
- Vassal master no longer will give away techs to vassals that are close to it in tech score
- Some fixes and hacks so that trade denials appear correctly when the human player offers themselves as a vassal to an AI

General
- Fixed issue blocking all terrain units from planning paths to distant areas
- Added option to CvPlayer::countReligionSpreadUnits and CvPlayer::countCorporationSpreadUnits to include units being trained

Customization
- Added BBAI_ALLAINCE_OPTION to change defensive pacts so they do not cancel after war declaration, cause allies to declare war as well.  This is easy for human players to abuse.
- Added BBAI_HUMAN_AS_VASSAL_OPTION to enable human players to offer themselves as vassals to AIs.  Some AI logic has also been added to make this work better.

CIV4UnitInfos
- Removed UNITAI_CITY_DEFENSE from Swordsmen