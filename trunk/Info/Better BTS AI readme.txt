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

New in Better BTS AI 1.00

Merged in Unoffical Patch 1.50
Added the Lead From Behind mod 1.2 by UncutDragon (improves selection of order for attack for both human and AI stacks, preserving GG, medics, experienced units)
Added CIV4LeaderHeadInfos.xml and CIV4CivilizationsSchema.xml to mod files for new victory strategy system

Bugfix
- Fixed divide by 0 issue with debug text which could cause crashes in debug logging when loading world builder scenarios using a non-Final_Release DLL
- Fixed bug (introduced) where giving pillage orders to a stack or multi-move unit would pillage multiple times
- Fixed bug (introduced) allowing ships to move diagonally over isthmuses under some circumstances
- Fixed bug (introduced) slowing AI expansion, especially on Archipelago maps
- Fixed bug where AI units could sleep indefinitely when using debug tools like ChangePlayer and AIAutoPlay
- Fixed issues with rounding off small commerce amounts leading to AI or governor working suboptimal tiles/specialists in some circumstances (reported by Caboose)
- Fixed bug in calculation of city closeness where city would consider its closeness to itself, so cities can now properly tell when they are close to other cities in their owner's empire (should now see more AI city razing)

Victory Strategy AI
- Switched all cultural victory logic to new victory strategy framework
- AIs gunning for cultural victory now much less likely to declare war the closer they get, biggest reduction for TOTAL war, smaller reduction for DOGPILE
- AIs in late stages of cultural victory more willing to agree to peace
- Updated close to cultural victory detection so that AIs who haven't been trying but get reasonably close will pursue it, and so that they can detect when human player is pursuing this strategy
- First complete implementation of AI victory strategy framework for Conquest, Domination, Space, and Diplomacy
- Levels 3 & 4 of each victory strategy are now based on observables, not hidden AI leader tendencies.  So, other AIs can now understand when other AIs are going for a particular victory, and it also serves as an estimate of what the human player is doing.
- AIs going for CONQUEST and DOMINATION victories willing to spend more gold on units
- Improved existing system for AI going for DOMINATION to build health buildings to help boost pop
- AIs going for culture/space now put defensive spies in important cities

War strategy AI
- AI now detects when other players are close to victory and greatly boosts start war value against them (still plays within leader's attitude no war probabilities, so won't declare on friendly)
- If enemy is (still) running higher levels of CULTURE or SPACE victory, AI will not accept capitulation until it ruins the enemies chance of winning
- AIs running highest levels of CONQUEST and DOMINATION strategies may ignore leader's attitude no war probabilities and attack highest value target
- AI calculations of the state of their wars now work better with minor civs (for mods)
- Smoothed AI valuation of how much bombard strength it needs to build for its attack stacks, upped desired bombard strength in era of walls and castles.  AI should now produce considerably more siege, especially the bigger AIs.
- Reduced AI valuation of interception probability as criteria for UNITAI_COUNTER units, to reduce drive to switch infantry to SAM
- AI now won't start air blitz build logic until it can build bombers (previously started with fighters)
- Added AI_STRATEGY_ALERT1 and AI_STRATEGY_ALERT2, AI will now analyze if it might be attacked in the near future and take pre-emptive action
- AI now generates extra defence in its high culture cities a bit earlier when going for cultural victory
- Removed some of the reductions to defender builds when AI is running AI_STRATEGY_GET_BETTER_UNITS (should help AI defend itself early in game)
- Added AI_STRATEGY_TURTLE implementation, if AI is badly outgunned and either recently attacked or losing badly, it will use any offensive stacks it has for defense and go into a defensive survival shell
- AI now plans ahead to counter units of enemies it is preparing for war against based on what it can see
- Added function so AI can calculate the air power of its rivals
- Corrected AI valuation on interception abilities for UNITAI_COUNTER units so that it doesn't switch Infantry to SAM until rivals have air units
- Adjusted Dagger and Crush strategy thresholds so if AI has started them it is more likely to keep them up
- AI will not do Crush if also doing ALERT2
- AI will now better defends its first few cities after invading a rivals continent
- Reduced effect of having vassals on AI aggressiveness (victory strategies replace this)
- AIs at war and looking for second front now adjusts it's power down for current enemies, and prefers weaker opponents
- AI will now always start last stand strategy after it launches space ship, even if other players haven't launched yet
- AI now much more willing to start final war strategy if enemy launches spaceship, if either Aggressive AI is on or AI is close to winning itself
- Vastly sped up AI war planning/declaration process in end of game situations, particularly enemy spaceship launch
- AI now targets cultural victory cities, capital if enemy is going for space

War tactics AI
- Tweaked AI_finalOddsThreshold to reduce suicide attacks in stack v stack combat, especially at sea
- Reworked AI logic for when to raze cities it conquers
- Rewrote logic in AI_attackCityMove so AI stacks behave more intelligently around enemy cities, will pillage if not strong enough to attack or choke from defensive terrain if outgunned
- AI carriers will now move to support/air defend ground troops, support invasions
- AI now values active wonders a little more in deciding cities to target
- Fixed bug where AI would over value holy cities of religions other than its state religion
- Upped threat cities feel when they are next to much more powerful rivals
- The strategy FAST_MOVERS no longer limits the AI from forming main stacks of mixed fast and slow units, but it will still form small fast attack groups
- Augmented the strategy LAND_BLITZ, a more restrictive case of FAST_MOVERS, so that main stacks will be made of multi-move units when possible in the modern era
- Fixed bug blocking under many circumstances AI from using logic to attack without bombarding when bombarding will take a long time
- Fixed bugs in AI calculations of how many turns they need to bombard defenses
- AI will now pillage with healthy, fast, non-bombard units in stack first
- AI will now pillage plot it is on before bombarding city (since need to bombard means there's a chance it won't take city)
- AI_choke now works better for multiple units if head unit is no defensive bonus, won't accidentally attack enemy units
- Added function for AI attack stacks to pillage around target city to buy time if not strong enough to attack.  Favors pillaging defensive terrain
- AI attack stacks load in transports if land path is too long
- Added option to AI_anyAttack to block attacking cities
- Attack city stacks will now considering taking transports if overland path is long
- Tactical nukes retreat better from cities when threatened
- AI now moves missles safely
- Fixed issues causing AI to rebase missles into empty forts
- AI attack stacks now do not head out for conquest unless they have some non-seige units which can capture cities
- AI attack stacks will wait for unit upgrades before heading out for conquest (helps most when AI has just been surprise attacked)
- AI attack units will now more readily band together in threatened cities and go after enemy units applying a choke

Unit AI
- Greatly improved speed and turn efficiency for loading of large stacks onto many transports
- AI pillage units now value healing in enemy territory more
- AI should now promote a few more units to medics

Naval AI
- Assault transports no longer set off to join transport groups already mounting assaults
- When assault transports head out for invasion, other transport groups which were going to join them will now pick a new mission
- Improved handling for when multiple transports are moving to pickup a stack of stranded units, the closest set of transports will now get the task
- Loaded transports with no escorts now try to join a local flotilla first
- Loaded transports with no escorts will now wait if there are waiting escorts on the same plot (catches case where transport just got troops loaded last turn, takes off before escorts can react)

Pirate AI
- Reduced suicide of pirateers starting from inside their own borders

Worker AI
- Fixed several issues and improved efficiency of CvUnitAI::AI_nextCityToImprove

City AI
- When at war, AI now is less zealotful in building production buildings.  They have to be able to be completed faster, and it will only start them probabilistically so not all cities will be building them at once
- Improved AI city build decisions when empire is under seige, especially for small empires
- Added calculations of actual health/happy effects of buildings from BUG mod (thanks EmperorFool)
- Fixed logic bugs in AI valuation of when happy or healthy from buildings was extra important
- AI now actually considers health effects of power, dirty power, coal, and oil
- Reworked AI valuation of buildings with health effects so all effects are considered
- Buildings with negative health effects are now strongly avoided if city has health problems
- AI now better evaluates when building bAreaCleanPower building is useful
- Reworked AI valuation of buildings with happiness effects so all effects are considered
- Buildings with negative happiness effects are now strongly avoided if city has happiness problems
- AI now values buildings which reduce war weariness, previously only avoided buildings which increased it
- AI now values religious buildings for AP religion more than other relgious buildings based on boosted yield
- AI now values religious buildings for state religion more than other religious buildings based on yield boosts from wonders
- Tweaks to help AI build mobile defense/counter attack force when outgunned
- Lowered max build turn limit for high priority production buildings when AI is in a tough war
- AI will now probably only build one workboat using very early capital logic as originally intended (speeds expansion in water resource heavy starts)
- Resolved issues where AI early game build logic would get confused because Warriors cannot be built as UNITAI_CITY_DEFENSE
- Improved AI logic for when to conscript defenders, AI now conscripts less unless it is in dire situation.  Tied in with TURTLE strategy
- AI now will build more attack units to break a choke
- Fixed issue where AI cities with lots of food available would not avoid growth when angry under some circumstances

Tech AI
- Separated out building and unit valuation into own function for debugging and future efforts
- Adjusted valuation of tech based on units enabled, boost to defensive units under ALERT and TURTLE and offensive when going for conquest victory
- AIs going for DOMINATION victory will aim for Galleons earlier
- AIs going for SPACE emphasize getting Apollo earlier
- AIs with Apollo now better emphasize getting techs for parts
- AIs with high odds of starting a total war now value units as if always at war

Civic AI
- If AI is leader of AP, it now values state religion civics more
- AI now values benefits it receives from wonders for state religion buildings when computing value for state religion civics
- AIs with high odds of starting a total war now stay in militaristic civics during short peace intervals
- AIs will now more often stay with peaceful civics when engaged in wars they're not really committed to, not losing

Diplomacy AI
- All AIs will check more frequently for tech trades when well behind in tech race, biggest benefit for those who typically wait longest

Gold AI
- Improved AI budgeting for unit upgrades in scenarios, advanced start

Missionary AI
- Fixed issues and improved logic in AI usage of MISSIONARY strategy (religious full-court press)

Great People AI
- AI Great Generals will no longer lead units which can't kill enemy units such as catapults
- Great Generals are always willing to lead units whose class has MaxGlobalInstances set regardless of UNITAI (for mods)

Barbarian AI
- No barb stacks sitting on goody huts, only single units
- If barbs have upper hand in an area (like new world), then they'll group stacks more actively

General AI
- Changed player consistent random method for picking strategies from being based on capital city location to a stored rand, so AI player tendencies will be consistent even if capital moves
- Changed how building defense is handled when unit is estimating its defensive strength against unknown attacker (CvUnit::maxCombatStr(pPlot,NULL)).  Firaxis took conservative approach and always ignored defense in this case (so defensive strength could be considerably higher in castled low culture city).  This lead to AIs suiciding stacks on city walls in early/mid game.  New method is to use ignoreBuildingDefense flag of defender which should have fewer fatal side effects.

Player Interface
- Added automate explore option for spies

Efficiency
- Several efficiency improvements were added with Lead From Behind
- Improved efficiency of several unit motion selection loops, reducing number of calls to generatePath

Customization
- Split GlobalDefinesAlt.xml into a few separate files by type
- Improved handling of default values for new BBAI variables in case xml files are accidentally missing or something
- Tweaked variables for AI stack attacks of cities to reduce suicides
- Added BBAI_TURTLE_ENEMY_POWER_RATIO to BBAI_AI_Variables
- Added BBAI_VICTORY_STRATEGY_CONQUEST, etc to BBAI_Game_Options so that you can turn off any parts of the new AI playing to win logic that you wish.  The code already checks for whether the victories are enabled or blocked by other things like the always peace option, so this is really just for if you don't like how it plays for some reason.
- Changed BBAI_ALLIANCE_OPTION to BBAI_DEFENSIVE_PACT_BEHAVIOR, now has three options

CvUnitInfos.xml
- Returned UNITAI_CITY_DEFENSE to Roman Praetorians
- Returned work boats to original tags of military support (exploit) and military production (faster with drydock) (thanks Fuyu)

CIV4LeaderHeadInfos.xml
- Added new AI weights for five victory strategies