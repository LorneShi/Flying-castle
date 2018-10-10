-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2017 Nicolas Casalini
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

local Talents = require("engine.interface.ActorTalents")

-- 蝎子基类
newEntity{
	define_as = "BASE_NPC_SCORPION",
	type = "scorpionkin", subtype = "scorpion",
	display = "S", color=colors.WHITE,

	combat = false,

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1 },

	infravision = 10,
	size_category = 2,
	rank = 1,

	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=4, },
	global_speed_base = 1,
	stats = { str=15, dex=15, mag=8, con=10 },
	resolvers.tmasteries{ ["technique/other"]=0.3 },
	resolvers.sustains_at_birth(),
	poison_immune = 0.9,
	never_move = 1,
	resists = { [DamageType.NATURE] = 20, [DamageType.LIGHT] = -20 },
}

-- 巨型蝎子
newEntity{ 
	base = "BASE_NPC_SCORPION",
	define_as = "GIANT_SCORPION",
	name = "Giant scorpion", 
	image="npc/giant_scorpion.png",
	color=colors.LIGHT_DARK,
	desc = [[This huge scorpion also knows that the toxicity is very strong, and I have to meet the far away.]],
	level_range = {4, nil}, 
	exp_worth = 1,
	rarity = 1,
	max_life = 100,
	life_regen = 50,
	life_rating = 10,
	ai = "tactical", 
	ai_state = { talent_in=1, },
	combat_armor = 30, 
	combat_def = 5,
	combat_physresist = 0,
	combat_spellresist = 0,
	combat_mentalresist = 0,
}

--骷髅基类
newEntity{
	define_as = "BASE_NPC_SKELETON",
	type = "undead", subtype = "skeleton",
	display = "s", color=colors.WHITE,
	level_range = {4, nil}, exp_worth = 1,

	combat = { dam=1, atk=1, apr=1 },

	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	energy = { mod=1 },

	open_door = true,

	blind_immune = 1,
	fear_immune = 1,
	see_invisible = 2,
	undead = 1,
}

-- 侏儒骷髅法师
newEntity{ 
	base = "BASE_NPC_SKELETON", 
	define_as = "GNOMISH_SKELETON_MAGE", 
	image="npc/gnomish_skeleton_mage.png",
	name = "Gnomish skeleton mage", 
	desc = [[Dressed in purple-gray robes, holding a sickle that is taller than himself, without a little fur, is horrible and strange and funny.]],
	color=colors.LIGHT_RED,
	rarity = 1,
	level_range = {4, nil}, exp_worth = 1,
	max_life = resolvers.rngavg(50,60),
	max_mana = resolvers.rngavg(70,80),
	combat_armor = 3, combat_def = 1,
	stats = { str=10, dex=12, cun=14, mag=14, con=10 },
	resolvers.talents{ [Talents.T_MANATHRUST]=3 },

	-- 穿装备会崩溃
	-- resolvers.equip{ {type="weapon", subtype="staff", autoreq=true} },

	autolevel = "caster",
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
}

-- 蟒基类
newEntity{
	define_as = "BASE_NPC_CLAM",
	type = "horror", subtype = "temporal",
	display = "h", color=colors.WHITE,
	blood_color = colors.BLUE,
	body = { INVEN = 10 },
	autolevel = "warrior",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=3, },

	stats = { str=20, dex=20, wil=20, mag=20, con=20, cun=20 },
	combat_armor = 5, combat_def = 10,
	combat = { dam=5, atk=10, apr=5, dammod={str=0.6} },
	infravision = 10,
	max_life = resolvers.rngavg(10,20),
	rank = 2,
	size_category = 3,

	no_breath = 1,
	cut_immune = 1,
	fear_immune = 1,
	not_power_source = {nature=true},
}

-- 食人巨蟒
newEntity{ 
	base = "BASE_NPC_CLAM",
	define_as = "GIANT_CLAM_CANNIBALISM",
	dredge = 1,
	image="npc/giant_clam_cannibalism.png",
	name = "Giant clam cannibalism", color=colors.TAN,
	desc = "A big snake, not right, a huge snake suddenly burst out of the trees in the forest, and the red letter in the mouth is at least 1 meter.",
	level_range = {5, nil}, exp_worth = 1,
	rarity = 1,
	rank = 2,
	size_category = 2,
	autolevel = "warriormage",
	max_life = resolvers.rngavg(50, 80),
	combat_armor = 1, combat_def = 10,
	combat = { dam=resolvers.levelup(resolvers.rngavg(15,20), 1, 1.1), atk=resolvers.rngavg(5,15), apr=5, dammod={str=1} },

	resists = { [DamageType.TEMPORAL] = 25},

	resolvers.talents{
		[Talents.T_DUST_TO_DUST]={base=1, every=7, max=5},
	},

	resolvers.sustains_at_birth(),
}

-- 狼基类
newEntity{
	define_as = "BASE_NPC_WOLF",
	type = "animal", subtype = "canine",
	display = "C", color=colors.WHITE,
	body = { INVEN = 10 },
	sound_moam = {"creatures/wolves/wolf_hurt_%d", 1, 2},
	sound_die = {"creatures/wolves/wolf_hurt_%d", 1, 1},
	sound_random = {"creatures/wolves/wolf_howl_%d", 1, 3},

	max_stamina = 150,
	rank = 1,
	size_category = 2,
	infravision = 10,

	autolevel = "warrior",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=2, },
	global_speed_base = 1.2,
	stats = { str=10, dex=17, mag=3, con=7 },
	combat = { dammod={str=0.6}, sound="creatures/wolves/wolf_attack_1" },
	combat_armor = 1, combat_def = 1,
	not_power_source = {arcane=true, technique_ranged=true},
}

-- 暗影狼
newEntity{ 
	base = "BASE_NPC_WOLF",
	define_as = "SHADOW_WOLF",
	name = "Shadow wolf", color=colors.BLACK, 
	image="npc/shadow_wolf.png",
	desc = [[A strong, huge purple-gray fur wolf appears in front of you, and it seems to be the master of the forest on a dark night.]],
	level_range = {5, nil}, exp_worth = 1,
	rarity = 4,
	max_life = resolvers.rngavg(60,100),
	combat_armor = 5, combat_def = 7,
	combat = { dam=resolvers.levelup(10, 1, 1), atk=10, apr=5 },
	resolvers.inscriptions(1, "infusion"),
	resolvers.talents{
		[Talents.T_RUSH]={base=0, every=10},
		[Talents.T_HACK_N_BACK]={base=1, every=10},
		[Talents.T_VITALITY]={base=3, every=8},
		[Talents.T_UNFLINCHING_RESOLVE]={base=1, every=8},
		[Talents.T_DAUNTING_PRESENCE]={base=0, every=8},
		[Talents.T_HOWL]=3,
	},
	ingredient_on_death = "WARG_CLAW",
}

-- 恶魔法师基类
newEntity{
	define_as = "BASE_NPC_DEMON_MAGE",
	type = "giant", subtype = "ice",
	display = "P", color=colors.WHITE,

	combat = { dam=resolvers.levelup(resolvers.mbonus(50, 10), 1, 1), atk=15, apr=15, dammod={str=0.8} },

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1 },
	resolvers.drops{chance=100, nb=1, {type="money"} },

	infravision = 10,
	life_rating = 12,
	max_stamina = 90,
	rank = 2,
	size_category = 4,

	autolevel = "warrior",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=2, },
	stats = { str=20, dex=8, mag=6, con=16 },

	resolvers.inscriptions(1, "infusion"),

	resists = { [DamageType.PHYSICAL] = 20, [DamageType.COLD] = 50, },

	no_breath = 1,
	confusion_immune = 1,
	poison_immune = 1,
	ingredient_on_death = "SNOW_GIANT_KIDNEY",
}

-- 恶魔法师
newEntity{
	base = "BASE_NPC_DEMON_MAGE",
	define_as = "DEMON_MAGE",
	name = "Demon mage", color=colors.LIGHT_BLUE,
	resolvers.nice_tile{image="invis.png", add_mos = {{image="npc/demon_mage.png",}}},
	desc = [[The demon mage with green skin, a group of black crows around him has been hovering, and seems to have meat at any time with the demonic mage.]],
	level_range = {6, nil}, exp_worth = 1,
	rarity = 3,
	max_life = resolvers.rngavg(100,120),
	combat_armor = 0, combat_def = 0,
	on_melee_hit = {[DamageType.COLD]=resolvers.mbonus(15, 5)},
	melee_project = {[DamageType.COLD]=resolvers.mbonus(15, 5)},
	autolevel = "warriormage",
	resolvers.talents{ [Talents.T_LIGHTNING]={base=3, every=6, max=6}, [Talents.T_CHAIN_LIGHTNING]={base=3, every=6, max=6}, },
}

-- boss 蛮牛怪
newEntity{ 
	define_as = "PRETTY_BULL",
	allow_infinite_dungeon = true,
	type = "horror", subtype = "corrupted", unique = true,
	name = "Pretty bull",
	display = "h", color=colors.VIOLET,
	resolvers.nice_tile{image="invis.png", add_mos = {{image="npc/pretty_bull.png", display_h=2, display_y=-1}}},
	desc = [[A monster of a bullhead, with a big axe slashed at you, it is so strong that anything that is cut by its axe will become broken.]],
	killer_message = "and revived as a mindless horror",
	level_range = {12, nil}, exp_worth = 2,
	max_life = 250, life_rating = 17, fixed_rating = true,
	stats = { str=20, dex=20, cun=20, mag=10, wil=10, con=20 },
	rank = 4,
	size_category = 4,
	infravision = 10,
	move_others=true,
	instakill_immune = 1,
	blind_immune = 1,
	no_breath = 1,

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1, HANDS=1, },
	resolvers.equip{
		{type="armor", subtype="hands", defined="STORM_BRINGER_GAUNTLETS", random_art_replace={chance=75}, autoreq=true},
	},
	resolvers.drops{chance=100, nb=5, {tome_drops="boss"} },

	combat_mindpower = 20,
	resolvers.talents{
		[Talents.T_ARMOUR_TRAINING]={base=3, every=9, max=4},
		[Talents.T_UNARMED_MASTERY]={base=2, every=6, max=5},
		[Talents.T_UPPERCUT]={base=2, every=6, max=5},
		[Talents.T_DOUBLE_STRIKE]={base=2, every=6, max=5},
		[Talents.T_SPINNING_BACKHAND]={base=1, every=6, max=5},
		[Talents.T_FLURRY_OF_FISTS]={base=1, every=6, max=5},
		[Talents.T_TENTACLE_GRAB]={base=1, every=6, max=5},
	},

	autolevel = "warrior",
	ai = "tactical", ai_state = { talent_in=1, ai_move="move_astar", },
	ai_tactic = resolvers.tactic"melee",
	resolvers.inscriptions(1, {"invisibility rune"}),

	on_die = function(self, who)
		game.state:activateBackupGuardian("NIMISIL", 2, 40, "Have you hard about the patrol that disappeared in the maze in the west?")
		game.player:resolveSource():grantQuest("starter-zones")
		game.player:resolveSource():setQuestStatus("starter-zones", engine.Quest.COMPLETED, "maze")
		game.player:resolveSource():setQuestStatus("starter-zones", engine.Quest.COMPLETED, "maze-horror")
	end,
}
