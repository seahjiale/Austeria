## NUS Orbital Milestone I

## Team Name
BelowMedian

## Proposed Level Of Achievement
Apollo

## Motivation
As casual fans of playing games, we’d like to try and challenge ourselves to create one on our own. We would like to create a game that is easy to learn and understand, and can be progressed as and when with no pressure, so that it can act as a fun game for study breaks. We decided to make a simple 2D pixel platformer game, similar to games like Super Mario Bros or Hollow Knight. Since creating a game from scratch requires the integration of many parts of computer science, this project allows us to apply programming concepts learned in school while developing practical software engineering and game design skills at the same time. 

## Aim
During the entire project, we hope to learn new knowledge and design concepts of game design, and to implement knowledge that we have learnt into our project such as Object-Oriented Programming (OOP). We hope to be able to develop a simple and fun game while learning the fundamentals of game development.  The project allows us to learn different languages and frameworks, and to build a complete and functional tech stack
that mimics how real-world applications function as well. We hope to learn plenty of hands-on experience in real-world programming, and to learn important concepts such as interlinking front-end and back-end smoothly together. A particular area that would be of interest is to delve into the design of the AI of the mobs, such as player detection range, pathfinding, and applying concepts like Finite State Machines.

## Storyline
The cheerful kingdom of Aurantia: a lush, vibrant land powered by a magical golden Sun Crystal that keeps the world warm, bright, and full of life.
Ribbit is a small, scrappy frog warrior who serves as a low-ranking guard in the kingdom of Aurantia. He's enthusiastic, a little clumsy, but has a heart of gold! One night, a mysterious cloaked figure sneaks into Solaris Tower and shatters the Sun Crystal, scattering its five Shards across the kingdom's most dangerous regions. As darkness begins to creep over Aurantia, the kingdom's elite warriors are struck down one by one and captured!
Ribbit, being small enough to slip through the chaos unnoticed, is the last one standing. The king with the last shimmer of hope declares him as Aurantia's only hope, where Ribbit has to travel across the kingdom to reclaim back the shards of the Sun Crystal, and to also free his captured friends to bring back peace to the kingdom.

## User Stories
1. As a player, I want to play a game that looks aesthetically pleasing.
2. As a player, I want the game to feel fulfilling and fun.
3. As a player, I want to be able to control a character that can have basic movement mechanics that are simple to learn so I can explore the map levels.
4. As a player, I want visible progression in the game to feel that there is improvement and feel satisfied. (e.g levelling up, new equipment, new skills)
5. As a more competitive player, I want a more challenging game that requires me to strategise my battle and movement mechanics against enemies to defeat mobs
6. As a player, I want to play with my friends to have a more fun experience.
7. As a player, I want the game to have different menu screens for equipment, skills, and character inventory that allow easy and accessible navigation.
8. As a player, I want to be able to customize my characters’ equipment to my own preference and playstyle.

## Poster
<img width="1587" height="2245" alt="VERSION 2" src="https://github.com/user-attachments/assets/a553d873-be28-4369-811f-57d0dd9dc7e4" />

## Scope Of Project
BelowMedian is a single-player PC 2D pixel platformer game 

Players will be navigating through different levels of increasing difficulty, and the game storyline gradually progresses as players get further to the end of the game. In each level, players face different types of monsters that have to be beaten to acquire experience points and equipment in order to get stronger to face the final boss.

We will tag and label our features into three categories for simpler tracking of our current progress. The different tags are as followed:

**[Proposed]** : Features for Minimum Viable Product (MVP) by the end of Orbital.
**[Current Progress]** : Elaboration on current progress on the stated feature.
**[Additional Features]** : Add-on features to improve product after Orbital.

## Features
###### MOVEMENT & COMBAT MECHANICS
**[Proposed]**
For player movement mechanics, the player can run, double jump, and attack. For enemies, different enemies will have different attack styles, such as melee swings or ranged projectiles.

**[Current]**
Currently, the movement and combat mechanics for the player has been completed, but the movement and combat mechanics for the enemies are still underway.

**[Additional Features]**
In the future, we could add dash movement for players to dodge by timing it well and making use of an “invincibility frame”, or to add parry movements to parry ranged projectiles with a melee swing.

##### MAP LEVELS
**[Proposed]**
There will be a total of about 3 to 4 levels as the base game. The first level would be the tutorial map where players learn basic movement and combat mechanics, whilst the next few levels would be fighting mobs to progress in the game, where the last level would be the final boss that players have to defeat.

**[Current]**
Currently, only the first level has been completed.

**[Additional Features]**
Each map level can have a certain theme with its own unique traits, such as ice leading to slippery terrain, fire leading to burn DoT, or darkness leading to impaired vision of the map. Each map would also have its own corresponding enemies.

| World | Terrain Trait | Enemy Types |
| :---: | :---: | :---: |
| Tanglewood Forest  | Normal terrain, no special trait | Wild boar, pigs, mushroom soldiers |
| Soggy Depths | Water based map where player swims around while keeping track of breathing capacity otherwise damage starts to tick | Crab guards, pufferfish, electric eels |
| Cinderpeak Volcano | Lava and fire scattered around the map that causes damage if touched | Fire beetles, armadillos, salamander |
| The Shattered Citadel | Dark castle with impaired vision, player can see less of the map | Skeleton guards, shadow wraiths, gargoyles |

###### USER INTERFACE, MENU SCREENS, MUSIC
**[Proposed]**
When opening the game, players are first directed to the main menu screen, where they can either start the game, or to change settings prior to playing. The player can:
1. Load Saved File: Load saved gamefile
2. Start New Game: Start new game
3. Settings: Change settings such as sound, resolution, controls

Upon starting the game, players will be able to access multiple in-game menus such as:
1. Pause Menu: Pauses the game if a break is required
2. Inventory Menu: Manage equipment acquired during the game
3. Skills Menu: Manage abilities and experience points gained

The game will contain royalty-free music and in-game sound effects.

**[Current]**
Currently, BelowMedian has a basic main menu screen that starts a new game and changes the settings, but has yet to implement the back-end save/load file system. For the in-game menus, only the pause menu has currently been implemented. The in-game music has also yet to be added.



<p align="center">
  <img width="413" height="228" alt="main_menu" src="https://github.com/user-attachments/assets/a4fe22b6-60f8-435f-b2d4-caba285c80d5" />
  &nbsp;&nbsp;&nbsp;
  <img width="244" height="232" alt="options_menu" src="https://github.com/user-attachments/assets/261196f9-0c57-483c-8064-f217ef840fbb" />
</p>

##### LEVELLING SYSTEM
**[Proposed]**
Players will earn experience points when killing mobs, and will level up once it hits a certain threshold. Once levelled up, players are given one skill point that can be used to enhance or learn new skills in the skill tree.

**[Current]**
Currently, the levelling system has yet to be implemented.

**[Additional Features]**
Rather than only giving skill points, we can give players further flexibility to their playstyles by adding a player attribute system. Besides learning skills, players can also be granted attribute points that can be used to level up attributes like strength, dodge chance, or luck (higher loot droprate), similar to MapleStory mechanics.

<p align="center">
  <img width="315" height="302" alt="player_stats" src="https://github.com/user-attachments/assets/f3f7a945-2b8c-4984-a7c3-c92f4f9a96a5" />
  <br/>
  <em>Screenshot of MapleStory player attributes</em>
</p>

##### EQUIPMENT SYSTEM
**[Proposed]**
Players can gain dropped equipment loot when killing mobs, and can be equipped accordingly. There will be several different classes of weapons, each with a different playstyle, such as ranged weapons like bows and melee weapons like swords, hammer, spears.

**[Current]**
Currently, the equipment system has yet to be implemented.

**[Additional Features]**
Besides having a different class system, different weapons can have their own unique abilities, such as having Damage over Time (DoT) effects like burn, or a chance to freeze/paralyze enemies.

##### SKILL SYSTEM
**[Proposed]**
Players gain skill points when levelling up, and these skill points can be used to acquire passive or active skills. There will be several different skills for players to explore and find their own unique playstyle.

**[Current]**
Currently, the skill system has yet to be implemented.

**[Additional Features]**
We can reorganise the skill system into a class skill system instead, where players choose a specific class and thus open up a skill tree specific to that class, rather than having a wide broad range of any skill. This allows players to have an easier time to find skills that suit their playstyle.

<p align="center">
  <img width="466" height="319" alt="classes" src="https://github.com/user-attachments/assets/e6d07511-5a3a-40ae-baba-c02101b1370c" />
  <br/>
  <em>Screenshot of different MapleStory classes - each class has a different playstyle</em>
</p>

##### ENEMY AI
**[Proposed]**
For our enemies, there will be several different types of enemies with their own movement and attack mechanics, alongside a final boss to defeat. The AI mobs would also have player detection range and an “aggro” system to drop chase. Each mob would drop varying amounts of experience points, alongside a small chance of dropping equipment.

**[Current]**
Currently, the enemy AI has not been implemented. There are however basic enemy sprites created that move around the map.
<div align="center">

| <img width="120" height="91" alt="mushroom_enemy" src="https://github.com/user-attachments/assets/fdc3090d-c218-414b-89ec-a73937dc7934" />| <img width="108" height="88" alt="pig_enemy" src="https://github.com/user-attachments/assets/db8a1176-98e6-4889-a43d-afd78c061994" /> |
|:--:|:--:|
| *Mushroom Enemy* | *Pig Enemy* |

</div>

##### SAVE & LOAD GAME SYSTEM
**[Proposed]**
Basic file save and file load so that players can continue their progress, or start afresh.

**[Current]**
Currently, such a system is yet to be implemented.

## Timeline and Development Plan
| Milestone | Task | Description | Date |
|:---------:|------|-------------|------|
| 1 | Basic Terrain | Create basic tiles that have physics for the player to run on | By 2nd week of May |
| | Player Movement Mechanics | Basic movement such as jump, run, double jump | By 3rd week of May |
| | Player Animation | Different animations for the different movement states | By 3rd week of May |
| | Health System | Health system to track the player health and damage taken | By 4th week of May |
| | Mob Creation | Create new mobs and animation | By 4th week of May |
| 2 | Combat Mechanics | Player able to do basic attacks, enemy able to also attack back | By 1st week of June |
| | Enemy AI | Enemy aggro detection range | By 1st week of June |
| | Mob Loot | Mobs able to drop EXP and weapons | By 2nd week of June |
| | EXP System | Gain EXP to acquire skills | By 3rd week of June |
| | Weapon System | Different weapon types such as melee and ranged | By 3rd week of June |
| | Skill System | Players are able to acquire new skills | By 3rd week of June |
| 3 | Sound | In-game music and sound effects for animations | By 4th week of June |
| | Save/Load System | Save file and load file | By 4th week of June |

## Diagram
TBC

## Work Log
<https://docs.google.com/spreadsheets/d/1-H6oaFY2L6BY4-YaL7F36m0kk8Bkl7HuoZIN0np3lW8/edit?usp=sharing>
