## NUS Orbital Milestone II

## Team Name
BelowMedian

## Proposed Level Of Achievement
Apollo

## Motivation
As casual gamers who enjoy playing a wide variety of video games, we wanted to challenge ourselves by experiencing the game development process from a developer's perspective rather than just as players. Video games have various interconnected systems working together seamlessly, such as user interfaces, physics engines, artificial intelligence, animations, sound design, and progression systems. Through Orbital, we hope to gain deeper appreciation of the complexity involved in creating games that provide an enjoyable and fun experience.
We decided to create a 2D pixel platformer inspired by popular titles such as Super Mario Bros and Hollow Knight. These games are known for their simple and intuitive controls, rewarding exploration, and progressive style gameplay. We believe that a platformer genre is suitable for our project as it provides opportunities to implement and apply a wide range of technical concepts that we have thus learnt so far.
In addition, we wanted to create a game that could serve as a relaxing and enjoyable experience for players. As students ourselves, we understand the importance of taking short breaks during periods of intensive studying. Therefore, our goal is to design a game that is easy to pick up and play while still offering meaningful progression and a sense of accomplishment through character growth, equipment upgrades, and skill development.

## Aim
The primary objective of this project is to design and develop a complete 2D pixel platformer game while applying software engineering principles learned throughout our studies. Through the development process, we aim to strengthen our understanding of programming concepts such as Object-Oriented Programming (OOP), modular software design, event-driven programming, and state management.
We also aim to gain practical experience in designing systems that interact with one another within a larger software ecosystem. Examples include integrating player movement mechanics with combat systems, connecting enemy artificial intelligence with damage calculations, and linking progression systems such as experience points, equipment, and skills systems.
Another objective for us is to become familiar with modern game development tools and workflows. By using game engines, version control systems, asset creation tools, and collaborative development practices, we hope to simulate a real-world software development environment and process. As such, this allows us to better understand how large software projects are structured and maintained, and lets us dip our toes into how real-world programming works.
Furthermore, we are interested in the design and implementation of artificial intelligence systems for enemy behaviour. This includes concepts such as finite state machines, aggro detection, pathfinding, attack patterns, and behavioural state transitions. By developing these systems, we are able to gain valuable insight into how interactive game entities make decisions and respond to player actions.
Ultimately, our goal is not only to produce a functional game but also to develop a deeper understanding of software architecture, project management, and game design principles that can be applied to future projects and professional software development.

## Storyline
The cheerful kingdom of Aurantia: a lush, vibrant land powered by a magical golden Sun Crystal that keeps the world warm, bright, and full of life.

Ribbit is a small, scrappy frog warrior who serves as a low-ranking guard in the kingdom of Aurantia. He's enthusiastic, a little clumsy, but has a heart of gold! One night, a mysterious cloaked figure sneaks into Solaris Tower and shatters the Sun Crystal, scattering its five Shards across the kingdom's most dangerous regions. As darkness begins to creep over Aurantia, the kingdom's elite warriors are struck down one by one and captured!

Ribbit, being small enough to slip through the chaos unnoticed, is the last one standing. The king with the last shimmer of hope declares him as Aurantia's only hope, where Ribbit has to travel across the kingdom to reclaim back the shards of the Sun Crystal, and to also free his captured friends to bring back peace to the kingdom.

## Scope Of Project
Austeria is a single-player 2D pixel-platformer game developed for the PC platform. The game combines exploration, combat, character progression, and equipment collection to provide players with an engaging gameplay experience. Players take control of Ribbit, a frog warrior tasked with recovering the scattered shards of the Sun Crystal and restoring peace to the kingdom of Aurantia.
The core gameplay revolves around traversing different levels, defeating enemies, acquiring stronger equipment, and progressing through a character development system. As players advance through the game, they encounter increasingly difficult enemies and environmental challenges that require both mechanical skill and strategic decision-making. Through defeating enemies, players gain Experience Points (EXP), level up their character, unlock new skills, and obtain stronger equipment to aid them in future battles.
The scope of this project includes the implementation of several gameplay systems. Firstly, there are basic player movement mechanics such as running, jumping, and double-jumping. Combat mechanics involve both melee and ranged attacks. Enemies are equipped with their own artificial intelligence and unique attack behaviours. There is also an equipment system that allows players to acquire and equip weapons, a levelling system that rewards progression through experience gain, and a skill system that enables players to customize their playstyle through skill acquisition and allocation.
In addition to gameplay mechanics, the project also includes the development of user interface systems such as the main menu, inventory menu, skill book, settings menu, and pause menu. Audio components such as background music and sound effects are also incorporated to enhance the overall player experience and improve immersion.
Overall, the scope of Austeria is centred on creating a fully functional platformer game that demonstrates the integration of multiple software engineering concepts, including object-oriented programming, game state management, user interface design, and artificial intelligence systems, while providing players with a fun and rewarding gameplay experience.
Proceeding on to the features section, we will use tags and labels for our features into three categories for simpler tracking of our current progress. The different tags are as followed:

[Proposed] : Features for Minimum Viable Product (MVP) by the end of Orbital.
[Current Progress] : Elaboration on current progress on the stated feature.
[Additional Features] : Add-on features to improve product after Orbital.

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
<p align="center">
  <img width="1587" height="2245" alt="VERSION 2 (1)" src="https://github.com/user-attachments/assets/8b83d356-905b-420c-b08a-8115381b5bfd" />
  <br/>
  <em>Poster</em>
</p>

## Technology Stack
The development of Austeria utilises a combination of software tools and platforms that support programming, game design, asset creation, collaboration, and deployment. These technologies were selected based on their suitability for developing a 2D pixel platformer while allowing the team to gain practical experience with modern software development workflows.

#### Godot Engine
Godot 4 serves as the primary game engine used throughout the development of Austeria. The engine provides built-in systems for scene management, physics simulation, animation handling, audio integration, and user interface design. Godot's node-based architecture enables different game systems to be organised into modular and reusable components, improving maintainability as the project grows.
Godot was utilised extensively throughout the project. The player movement system was implemented using CharacterBody2D nodes and Godot's built-in physics engine. Combat mechanics make use of collision detection through Area2D and CollisionShape2D nodes. User interface elements such as the inventory menu, skill book, settings menu, and pause menu were implemented using Godot's Control node hierarchy.
<p align="center">
  <img width="373" height="382" alt="image" src="https://github.com/user-attachments/assets/174aaf35-51c0-4aa1-ae37-20759fa7957b" />
  <img width="390" height="161" alt="image" src="https://github.com/user-attachments/assets/779dad49-219a-467c-aa1c-a2f6e5ca179e" />
  <br/>
  <em>Node hierachy of SkillBook</em>
</p>

#### GDScript
GDScript is the primary programming language used within the project. As Godot's native scripting language, it provides seamless integration with the engine while maintaining a simple and readable syntax. Most gameplay systems are implemented using GDScript, including player movement, combat mechanics, enemy artificial intelligence, experience progression, equipment management, and skill acquisition systems. The language allows rapid development and easy communication between different game systems.

#### Aseprite
Aseprite is used for creating and editing pixel-art assets. Character sprites, enemy sprites, weapon animations, and environmental assets are produced using Aseprite's pixel-art editing tools. The software's animation workflow enables frame-by-frame animation creation, allowing smooth movement, attack animations, enemy behaviours, and visual effects to be integrated into the game.

#### Tiled
Tiled is used for designing and constructing game maps. Through its tile-based editing system, levels can be created efficiently while maintaining consistency in terrain layouts and environmental design.
Using Tiled allows the separation of level design from gameplay programming, making it easier to modify maps without affecting the underlying game systems. This improves development efficiency and allows rapid iteration during testing.

#### GitHub
GitHub is used as the project's version control platform. Through GitHub, team members are able to collaborate effectively while maintaining a history of code changes throughout development.
Version control enables safe experimentation with new features while providing backup and recovery capabilities. GitHub also facilitates issue tracking, task assignment, and progress monitoring throughout the project lifecycle.

#### itch.io
The completed game prototype is distributed through itch.io. This platform allows external users to access and test the game without requiring access to the development environment. Deployment through itch.io also enables the collection of feedback from testers, helping identify areas for improvement before future releases.

## System Architecture
Austeria is designed using a modular architecture where individual gameplay systems operate independently while communicating with one another when necessary. This approach improves maintainability, scalability, and code reusability by ensuring that each system is responsible for a specific set of functionalities.

At the centre of the architecture is the Player Controller, which serves as the primary interface between player inputs and gameplay actions. The Player Controller manages movement, combat actions, skill activation, and interactions with other game systems.

The Combat System is responsible for handling damage calculations, hit detection, attack animations, and combat interactions between players and enemies. Whenever an enemy is defeated, the Combat System communicates with the Experience (EXP) System to award experience points to the player.

The EXP System tracks the player's accumulated experience and determines when a level-up occurs. Upon reaching the required experience threshold, the Levelling System increases the player's level and awards skill points that can be spent within the Skill System.

The Skill System manages skill acquisition, skill progression, and skill activation. Through the skillbook interface, players can unlock abilities and assign them to available hotkey slots for use during gameplay.

The Inventory and Equipment Systems work closely together to manage items acquired throughout the game. Weapons obtained from defeated enemies are stored within the inventory before being equipped by the player. Equipped weapons directly influence combat performance by modifying damage output and combat effectiveness.

Enemy AI operates independently from the player systems and controls enemy movement, attack behaviour, player detection, and combat interactions. Different enemy types utilise different AI behaviours, creating a variety of combat encounters throughout the game.

Finally, the UI System provides players with visual access to the various gameplay systems. Menus such as the inventory menu, skillbook, settings menu, and experience indicators communicate information to the player while allowing interaction with the underlying game mechanics.
This modular architecture allows each system to be developed, tested, and maintained independently while still functioning together as a cohesive game experience.

<p align="center">
  <img width="568" height="637" alt="image" src="https://github.com/user-attachments/assets/391bee57-cbe0-4e16-900f-b97582d80d0b" />
  <br/>
  <em>Architecture</em>
</p>


## Features
###### MOVEMENT & COMBAT MECHANICS
**[Proposed]**
For player movement mechanics, the player can run, double jump, and attack. For enemies, different enemies will have different attack styles, such as melee swings or ranged projectiles.

**[Current]**
The player currently has all basic movement mechanics, such as run, jump, and double jump. Combat mechanics for the player have also been completed, where there are two main methods of basic attacking : melee and ranged. Combat mechanics for enemies have also been completed, where each enemy has their own unique way of attacking.

<p align="center">
  <img width="752" height="712" alt="image" src="https://github.com/user-attachments/assets/e2ba4619-860e-49ce-9647-df3451b3bf56" />
  <br/>
  <em>Example of double-jump mechanic being implemented</em>
</p>

**[Additional Features]**
Future improvements may include advanced movement mechanics such as a dash ability that allows players to quickly evade incoming attacks. The dash could incorporate temporary invincibility frames, rewarding players who time their dodges correctly during combat encounters.

Another potential feature is a parry system, which would allow players to deflect enemy attacks or projectiles through precise timing. Successfully performing a parry could temporarily stun enemies, create opportunities for counterattacks, or reflect projectiles back towards opponents. These additions would increase the skill ceiling of combat and provide experienced players with more opportunities to demonstrate mastery of the game's mechanics.


##### MAP LEVELS
**[Proposed]**
There will be a total of about 4 to 5 levels as the base game. The first level would be the tutorial map where players learn basic movement and combat mechanics, whilst the next few levels would be fighting mobs to progress in the game, where the last level would be the final boss that players have to defeat.

**[Current]**
Currently, three playable maps have been completed and integrated into the game. Each map contains its own terrain layout, enemy placements, and platforming challenges. The completed maps provide players with opportunities to practice movement mechanics, engage in combat encounters, and progress through the game's content.

Environmental assets, terrain collision systems, enemy spawning locations, and level transitions have also been implemented. These systems allow players to move smoothly between different areas while maintaining a consistent gameplay experience.

<p align="center">
  <img width="750" height="425" alt="image" src="https://github.com/user-attachments/assets/d931f4d9-e354-4eaa-b62d-fa7fed6e6ee7" />
  <br/>
  <em>Area 1</em>
  <br/>
  <br/>
  
  <img width="751" height="427" alt="image" src="https://github.com/user-attachments/assets/db1c93e8-629a-4496-97e7-8c7db1f94b40" />
  <br/>
  <em>Area 2</em>
  <br/>
  <br/>
  
  <img width="753" height="421" alt="image" src="https://github.com/user-attachments/assets/5feff094-45cf-4cbf-b656-be81799c027b" />
  <br/>
  <em>Area 3</em>
  <br/>
  <br/>
</p>

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
Austeria currently has a main menu screen that can start the game, change settings, or quit the game. When entering the game, players can press the respective buttons to open up the skills menu, inventory menu, or the same settings menu to pause the game. In-game background music has been added to the game, alongside sound effects such as jump sound effects and basic attack sound effects. The back-end save/load file system has yet to be completed.

<p align="center">
  <img width="413" height="228" alt="main_menu" src="https://github.com/user-attachments/assets/a4fe22b6-60f8-435f-b2d4-caba285c80d5" />
  <br/>
  <em>Main menu</em>
</p>
<p align="center">
  <img width="244" height="232" alt="options_menu" src="https://github.com/user-attachments/assets/261196f9-0c57-483c-8064-f217ef840fbb" />
  <br/>
  <em>Settings menu</em>
</p>

##### LEVELLING SYSTEM
**[Proposed]**
Players gain Experience Points (EXP) by defeating enemies throughout their journey. Upon accumulating sufficient EXP to meet the required threshold, the player character levels up. Each level gains one Skill Point, which can be invested in the Skill Book to unlock new abilities. This system provides a sense of progression and allows players to customize their playstyle as they advance. 

**[Current]**
The levelling system has been successfully implemented. Players can earn EXP from defeating enemies and level up upon reaching the required EXP threshold. A level-up animation and visual indicator is also displayed whenever a player advances to the next level, allowing players to easily recognize their progression during gameplay.

<p align="center">
  <img width="376" height="647" alt="image" src="https://github.com/user-attachments/assets/498f6b00-b2b1-40e5-b641-4d326eed8ed2" />
  <br/>
  <em>EXP system</em>
</p>

**[Additional Features]**
Rather than only giving skill points, we can give players further flexibility to their playstyles by adding a player attribute system. Besides learning skills, players can also be granted attribute points that can be used to level up attributes like strength, dodge chance, or luck (higher loot droprate), similar to MapleStory mechanics.

<p align="center">
  <img width="315" height="302" alt="player_stats" src="https://github.com/user-attachments/assets/f3f7a945-2b8c-4984-a7c3-c92f4f9a96a5" />
  <br/>
  <em>Screenshot of MapleStory player attributes</em>
</p>

##### EQUIPMENT SYSTEM
**[Proposed]**
Players can obtain equipment through loot drops from defeated enemies. These items can be collected and equipped to enhance the player's combat capabilities. The game will have mainly two separate classes, each offering a unique playstyle and combat strategy. There will be ranged weapons such as bows, as well as melee weapons such as swords. 

**[Current]**
The equipment system has been successfully implemented. Mini-bosses are capable of dropping weapons that players can collect and equip, granting additional damage and improving combat effectiveness. Core functionalities, including weapon acquisition and equipping mechanics, are fully operational. However, the graphical user interface (GUI) is still undergoing refinement, with planned improvements to its visual design and overall user experience.

<p align="center">
  <img width="367" height="416" alt="image" src="https://github.com/user-attachments/assets/193d8255-362a-40c4-969b-798dea813fa6" />
  <br/>
  <em>Inventory menu</em>
</p>

<p align="center">
  <img width="392" height="306" alt="image" src="https://github.com/user-attachments/assets/d2a57fe2-f3f5-490e-9286-2e8e4bb710d2" />
  <br/>
  <em>Weapon dropped by Area 1 boss</em>
</p>

<p align="center">
  <img width="380" height="425" alt="image" src="https://github.com/user-attachments/assets/eead1167-3eaf-4121-9f37-0f1fc529b701" />
  <br/>
  <em>Inventory menu after picking up item</em>
</p>

**[Additional Features]**
Besides having a different class system, different weapons can have their own unique abilities, such as having Damage over Time (DoT) effects like burn, or a chance to freeze/paralyze enemies.

##### SKILL SYSTEM
**[Proposed]**
The Skill System serves as one of the primary progression mechanics within Austeria. As players gain Experience Points (EXP) and level up throughout their journey, they are rewarded with Skill Points that can be invested into unlocking new abilities. These skills provide players with additional combat options and allow them to customise their character according to their preferred playstyle.

The system is designed to encourage long-term progression by gradually expanding the player's arsenal of abilities as they advance through the game. Skills may be categorised into different types, such as active skills that can be manually activated during combat, and passive skills that provide permanent bonuses to the player.

By offering a variety of skills with different effects, the system promotes experimentation and replayability. Players are able to explore different combinations of abilities and discover strategies that best suit their preferred approach to combat.

**[Current]**
The Skill system has been successfully implemented and fully integrated with the levelling system. Whenever a player levels up, they are awarded Skill Points that can be used to unlock new abilities within the skillbook.

Players can access the skillbook by pressing the designated hotkey, which opens a dedicated menu displaying all available skills. The skillbook interface provides clear visual feedback regarding locked skills (greyed out), unlocked skills, and the player's remaining Skill Points.

Once a skill has been unlocked, players are able to equip it through a drag-and-drop interface. Skills can be dragged directly from the skillbook and assigned to one of four available hotkey slots. These slots correspond to the keys '1', '2', '3', and '4', allowing players to quickly activate their chosen abilities during gameplay.

The drag-and-drop functionality provides a more intuitive user experience compared to traditional menu-based systems. Players can freely rearrange their equipped abilities, enabling them to adapt their loadout according to different situations and combat encounters.

The current implementation successfully connects multiple gameplay systems together, including levelling, skill acquisition, user interface interactions, and combat mechanics. This creates a rewarding progression loop where players are continuously motivated to gain experience, level up, and unlock stronger abilities.

<p align="center">
  <img width="682" height="426" alt="image" src="https://github.com/user-attachments/assets/e8c2771e-0e8a-44d9-ac3e-4334a362e61b" />
  <br/>
  <em>Skills menu</em>
</p>

**[Additional Features]**
Future versions of the Skill System may introduce specialised class-based skill trees. Rather than allowing access to every available skill, players would choose a specific class that grants access to unique abilities and progression paths.

For example, a Warrior class may focus on close-range combat and defensive abilities, while an Archer class may specialise in ranged attacks and mobility. This would create greater differentiation between playstyles and encourage players to make meaningful decisions regarding character development.

Additional features may also include skill upgrades, where abilities can be enhanced multiple times to improve their effectiveness. Players could choose between different upgrade paths, allowing further character customisation and strategic depth.

These improvements would significantly increase replayability by encouraging players to experiment with different builds and character specialisations across multiple playthroughs.

The separation of class-specific skills would be similar to MapleStory’s class selection, where there are different classes, and in the classes themselves have different job advancements at certain levels that mark as milestones to unlock new sets of skills and abilities.

<p align="center">
  <img width="466" height="319" alt="classes" src="https://github.com/user-attachments/assets/e6d07511-5a3a-40ae-baba-c02101b1370c" />
  <br/>
  <em>Screenshot of different MapleStory classes - each class has a different playstyle</em>
</p>

##### ENEMY AI
**[Proposed]**
For our enemies, there will be several different types of enemies with their own movement and attack mechanics, alongside a final boss to defeat. The AI mobs would also have player detection range and an “aggro” system to drop chase. Each mob would drop varying amounts of experience points, alongside a small chance of dropping equipment.

**[Current]**
Currently, there are several different mobs with different movement/attack systems.

<p align="center">
  <img width="767" height="472" alt="image" src="https://github.com/user-attachments/assets/3deef49d-0407-4a9c-b73a-afa69a6460aa" />
  <br/>
  <img width="760" height="527" alt="image" src="https://github.com/user-attachments/assets/70e095d9-5caf-46c6-b882-fd41dc4547b6" />
  <br/>
  <img width="757" height="451" alt="image" src="https://github.com/user-attachments/assets/38abb067-55e9-43eb-b9cd-de7796f955ca" />
</p>

The enemy AI follows a Finite State Machine (FSM) architecture. Each state represents a specific behaviour, such as patrolling, chasing, or attacking. State transitions occur when predefined conditions are met, such as the player entering an aggro radius or leaving the enemy's detection range. This design improves maintainability and allows new enemy types to be developed efficiently by reusing existing states while modifying behaviour parameters.

<p align="center">
  <img width="787" height="516" alt="image" src="https://github.com/user-attachments/assets/32ce2186-246b-49cb-8cc1-eec16d461c1b" />
  <br/>
  <em>Finite State Machine that is used by most of the enemies</em>
</p>

Currently, there are 2 bosses with their own unique movesets.
<p align="center">
  <img width="760" height="532" alt="image" src="https://github.com/user-attachments/assets/0987996c-d103-4bda-a6dc-21c36bc6da63" />
  <br/>
  <img width="758" height="206" alt="image" src="https://github.com/user-attachments/assets/23e52a2e-7c0e-495a-a7a3-52673125032f" />
  <br/>
</p>

The boss AI also uses a FSM architecture, however the bosses have more states as compared to the regular monsters.
<p align="center">
  <img width="393" height="232" alt="image" src="https://github.com/user-attachments/assets/ad02b4cf-f173-4f40-bf6a-27dcecd06a8b" />
  <em>Golem FSM</em>
  <br/>
  <img width="377" height="230" alt="image" src="https://github.com/user-attachments/assets/175a2348-a8b0-4f99-a3df-097c26d591eb" />
  <em>Grim Reaper FSM</em>
  <br/>
</p>



##### SAVE & LOAD GAME SYSTEM
**[Proposed]**
Basic file save and file load so that players can continue their progress, or start afresh.

**[Current]**
Currently, such a system is yet to be implemented.

## Testing & Validation
To ensure the reliability and quality of Austeria, various testing methodologies were conducted throughout the development process. These tests were designed to verify that individual features functioned correctly, that different systems interacted properly with one another, and that players could enjoy a smooth gameplay experience.

#### Test Case Design
The following test cases were designed to verify the functionality of major gameplay systems.
| Test | Feature | Test Case | Result |
|:---------:|------|-------------|------|
| 1 | Movement | Perform double jump | Player can only jump a maximum of two times |
| 2 | Combat | Attack an enemy | Enemy health decreases |
| 3 | Equipment | Equip a weapon | Player damage increases |
| 4 | Inventory | Pick up a dropped weapon | Weapon is added to the inventory |
| 5 | EXP System | Defeat an enemy | Experience points awarded |
| 6 | Levelling System | Reach EXP threshold | Player levels up, one skill point is given, and EXP bar is resetted back to zero, with its threshold increased by a percentage |
| 7 | Skill System | Unlock skill | Skill point gets consumed and selected skill is unlocked |
| 8 | Skill System | Mobs able to drop EXP and weapons | By 2nd week of June |
| 9 | Enemy AI | Enter aggro range | Enemy begins chasing player |
| 10 | UI System | Open respective menus | Correct menu displayed, and able to open/close correctly |

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
