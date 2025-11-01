# 2D RPG Visual Novel game built with Godot Engine and classic storytelling gameplay.

```

Tale_of_Drea_Land/
│
├── addons/                          # Thư mục các plugin/addon
│   ├── dialogue_nodes/              # Plugin hệ thống đối thoại
│   │   ├── editor/                  # Scripts cho editor dialogue
│   │   │   ├── characters.gd
│   │   │   ├── editor.gd
│   │   │   ├── files.gd
│   │   │   ├── graph.gd
│   │   │   ├── Graph.tscn
│   │   │   ├── variableItem.gd
│   │   │   ├── VariableItem.tscn
│   │   │   ├── variables.gd
│   │   │   └── Variables.tscn
│   │   ├── icons/                   # Icons cho plugin (20 SVG, 1 PNG)
│   │   ├── nodes/                   # Các loại node cho dialogue graph
│   │   │   ├── commentNode.gd/.tscn
│   │   │   ├── conditionNode.gd/.tscn
│   │   │   ├── dialogueNode.gd/.tscn
│   │   │   ├── DialogueNodeOption.tscn
│   │   │   ├── option.gd
│   │   │   ├── setNode.gd/.tscn
│   │   │   ├── signalNode.gd/.tscn
│   │   │   └── startNode.gd/.tscn
│   │   ├── objects/                 # Objects liên quan đến dialogue
│   │   │   ├── bbcodeGhost.gd
│   │   │   ├── bbcodeMatrix.gd
│   │   │   ├── bbcodeWait.gd
│   │   │   ├── Character.gd
│   │   │   ├── CharacterList.gd
│   │   │   ├── DialogueBox.gd
│   │   │   ├── DialogueBubble.gd
│   │   │   ├── DialogueData.gd
│   │   │   └── DialogueParser.gd
│   │   ├── themes/                  # Themes cho editor (5 .theme files)
│   │   ├── Editor.tscn
│   │   ├── plugin.cfg
│   │   └── plugin.gd
│   │
│   └── SignalVisualizer/            # Plugin debug signal
│       ├── Common/                  # Utilities chung
│       │   ├── signal_connection.gd
│       │   ├── signal_description.gd
│       │   ├── signal_graph_utility.gd
│       │   └── signal_graph.gd
│       ├── Debugger/                # Debugger components
│       │   └── SignalDebugger.gd/.tscn
│       ├── Visualizer/              # Visualizer components
│       │   └── (4 .gd, 3 .tscn files)
│       ├── SignalVisualizer.gd
│       ├── plugin.cfg
│       └── (icon files: Clear.svg, GraphEdit.svg, Play.svg, Stop.svg)
│
├── Assets/                          # Tài nguyên game
│   ├── Demo/
│   │   └── demo0.jpg
│   ├── Fonts/
│   │   └── the-bold-font-free-version/
│   │       └── (.otf, .ttf files)
│   └── Images/
│       ├── Avatar/                  # Ảnh avatar (2 PNG, 1 JPG)
│       ├── Frame_rank/              # Frame ranking (10 PNG)
│       └── Icon/                    # Icons game (5 JPG, 4 PNG)
│
├── Resource/                        # Resource definitions
│   ├── Character/                   # Character resources
│   │   ├── Alice.gd
│   │   └── Okami.gd
│   └── ListSkill/                   # Skill definitions
│       ├── Skill1.gd đến Skill7.gd
│       ├── ListSkillforClass.gd
│       └── TabBar.tres
│
├── Scenes/                          # Scene files (.tscn)
│   ├── Battle.tscn
│   ├── Characters.tscn
│   ├── Inventory.tscn
│   ├── MainScene.tscn               # Scene chính (main_scene)
│   ├── SkillTree.tscn
│   └── testscene.tscn
│
├── Scripts/                         # Scripts game logic
│   ├── Implement/                   # Implementation classes
│   │   ├── CharacterManager.gd
│   │   ├── Effectable.gd
│   │   ├── EquipmentGenerator.gd
│   │   ├── EquipmentManager.gd
│   │   ├── EquipmentUpgrader.gd
│   │   └── GemManager.gd
│   │
│   ├── Objects/                     # Base classes và game objects
│   │   ├── BaseSkill.gd
│   │   ├── CharacterBase.gd
│   │   ├── CharacterStats.gd
│   │   ├── Equipments.gd
│   │   ├── Gems.gd
│   │   ├── InfoSkill.gd
│   │   ├── Inventory.gd
│   │   ├── Items.gd
│   │   ├── Materials.gd
│   │   ├── Others.gd
│   │   ├── Player.gd
│   │   ├── PlayerStats.gd
│   │   ├── States.gd
│   │   └── StoryItems.gd
│   │
│   ├── Scenes/                      # Scripts cho scenes
│   │   ├── Battle.gd
│   │   ├── Characters.gd
│   │   ├── Inventory.gd
│   │   ├── Skill_tree.gd
│   │   └── testscene.gd
│   │
│   ├── Skills/                      # Skill implementations
│   │   └── FireBall.gd
│   │
│   ├── UI/                          # UI scripts
│   │   ├── Avatar.gd
│   │   ├── Character_hud.gd
│   │   ├── Detail.gd
│   │   ├── Equipped_ui.gd
│   │   └── Inventory_slot.gd
│   │
│   ├── main_scene.gd
│   └── Player.gd
│
├── Shader/                          # Shader files
│   ├── blackwhite.gdshader
│   └── blur.gdshader
│
├── Singletons/                      # Autoload singletons
│   └── globals.gd                   # Global variables/functions
│
├── UI/                              # UI scene files (.tscn)
│   ├── Avatar.tscn
│   ├── btn.tscn
│   ├── Button.tscn
│   ├── CharacterHUD.tscn
│   ├── CharacterHUDmini.tscn
│   ├── Detail.tscn
│   ├── EquippedSlot.tscn
│   ├── EquippedUI.tscn
│   └── InventorySlot.tscn
│
├── icon.svg                         # Icon của project
└── project.godot                    # File config chính của Godot

```

## Menu Characters:
<img width="417" height="741" alt="image" src="https://github.com/user-attachments/assets/54ac853e-2a18-46cd-9efe-6b28454df561" />
<img width="257" height="405" alt="image" src="https://github.com/user-attachments/assets/d5c3a327-d830-45ec-bfb4-3d2fef992ced" />

## Menu Inventory:
<img width="416" height="683" alt="image" src="https://github.com/user-attachments/assets/40c20e7d-f78c-416d-8db6-d1ab24b925c5" />
<img width="250" height="413" alt="image" src="https://github.com/user-attachments/assets/2eb82226-8f24-44ba-9e12-9701bda2b114" />

## Menu Skill Tree:
<img width="422" height="663" alt="image" src="https://github.com/user-attachments/assets/a6b3df1e-f48c-4369-b65a-c759c7949f70" />
<img width="268" height="415" alt="image" src="https://github.com/user-attachments/assets/48c3d148-b61a-46c6-97e5-740fd63334a6" />

