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

-- 蜗牛基类
newEntity{
	define_as = "BASE_NPC_INSECT",
	type = "insect", 
	subtype = "snail",
	display = "C", 
	color=colors.WHITE,
	body = { INVEN = 10 },
	sound_moam = {"creatures/wolves/wolf_hurt_%d", 1, 2},
	sound_die = {"creatures/wolves/wolf_hurt_%d", 1, 1},
	sound_random = {"creatures/wolves/wolf_howl_%d", 1, 3},

	max_stamina = 150,
	rank = 1,
	size_category = 2,
	infravision = 10,

	autolevel = "warrior",
	ai = "dumb_talented_simple", 
	ai_state = { ai_move="move_complex", talent_in=2, },
	global_speed_base = 1.2,
	stats = { str=10, dex=17, mag=3, con=7 },
	combat = { dammod={str=0.6}, 
	sound="creatures/wolves/wolf_attack_1" },
	combat_armor = 1, 
	combat_def = 1,
	not_power_source = {arcane=true, technique_ranged=true},
}

-- 变异蜗牛
newEntity{ 
	base = "BASE_NPC_INSECT",
	name = "Variation snail", 
	color = colors.UMBER, 
	image = "npc/variation_snail.png",
	desc = [[This snail with a huge mouth is so crazy that even the wolf is afraid. How big is the food and how big the mouth is.]],
	level_range = {1, nil}, 
	exp_worth = 1,
	rarity = 1,
	max_life = resolvers.rngavg(40,70),
	combat_armor = 1, 
	combat_def = 3,
	combat = { dam=resolvers.levelup(5, 1, 0.7), atk=0, apr=3 },
	resolvers.talents{
		[Talents.T_RUSH]={base=0, every=10},
	},
}

-- 青蛙基类
newEntity{
	define_as = "BASE_NPC_AMPHIBIAN_CRITTER",
	type = "amphibian", 
	subtype = "critter",
	blood_color = colors.DARK_GREY,
	display = "E", 
	color=colors.DARK_GREY,
	faction = "cosmic-fauna",

	combat = { dam=resolvers.levelup(resolvers.mbonus(40, 15), 1, 1.2), atk=15, apr=15, dammod={mag=0.8}, damtype=DamageType.ARCANE },

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1 },

	infravision = 10,
	life_rating = 8,
	life_regen = 0,
	rank = 2,
	size_category = 3,
	levitation = 1,
	can_pass = {pass_void=70},

	autolevel = "dexmage",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=2, },
	stats = { str=10, dex=8, mag=6, con=16 },

	resists = { [DamageType.PHYSICAL] = -30, [DamageType.ARCANE] = 100 },

	no_breath = 1,
	poison_immune = 1,
	disease_immune = 1,
	cut_immune = 1,
	stun_immune = 1,
	blind_immune = 1,
	knockback_immune = 1,
	confusion_immune = 1,
	power_source = {arcane=true},
}

-- 变异青蛙
newEntity{ 
	base = "BASE_NPC_AMPHIBIAN_CRITTER",
	name = "Variation frog", 
	image = "npc/variation_frog.png",
	desc = [[The tentacles on the frog's head are terrifying and will release the dark magic, so don't think that hiding far away will be fine.]],
	color = colors.GREY,
	level_range = {2, nil}, 
	exp_worth = 1,
	rarity = 1,
	max_life = resolvers.rngavg(40,60),
	combat_armor = 0, 
	combat_def = 20,
	on_melee_hit = { [DamageType.ARCANE] = resolvers.mbonus(20, 10), },

	resolvers.talents{
		[Talents.T_VOID_BLAST]={base=1, every=7, max=7},
	},
}

-- 蚯蚓基类
newEntity{
	define_as = "BASE_NPC_EARTHWORM",
	type = "insect", 
	subtype = "earthworm",
	display = "p", 
	color=colors.BLUE,

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1 },
	resolvers.drops{chance=20, nb=1, {} },
	resolvers.equip{
		{type="weapon", subtype="dagger", autoreq=true},
		{type="weapon", subtype="dagger", autoreq=true},
		{type="armor", subtype="light", autoreq=true}
	},
	resolvers.drops{chance=100, nb=2, {type="money"} },
	infravision = 10,

	max_stamina = 100,
	rank = 2,
	size_category = 3,

	resolvers.racial(),
	resolvers.sustains_at_birth(),

	open_door = true,

	resolvers.inscriptions(1, "infusion"),

	autolevel = "rogue",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=5, },
	stats = { str=8, dex=15, mag=6, cun=15, con=7 },

	resolvers.talents{
		[Talents.T_LETHALITY]={base=1, every=6, max=5},
		[Talents.T_KNIFE_MASTERY]={base=0, every=6, max=6},
		[Talents.T_WEAPON_COMBAT]={base=0, every=6, max=6},
	},
	power_source = {technique=true},
}

-- 食人蚯蚓
newEntity{ base = "BASE_NPC_EARTHWORM",
	name = "Earthworm of cannibalism", 
	image = "npc/earthworm_of_cannibalism.png",
	color_r=0, color_g=0, color_b=resolvers.rngrange(195, 215),
	desc = [[This cannibalism is strong and strong. Many adventurers walk around and become the food in their mouth. Who can expect it to be drilled from your feet in the next second?]],
	level_range = {3, nil}, 
	exp_worth = 1,
	rarity = 1,
	combat_armor = 3, 
	combat_def = 5,
	resolvers.talents{
		[Talents.T_STEALTH]={base=2, every=6, max=8},
		[Talents.T_DISARM]={base=2, every=6, max=6},
		[Talents.T_APPLY_POISON]={base=0, every=6, max=5},
		[Talents.T_VILE_POISONS]={last=15, base=0, every=6, max=5},
		[Talents.T_VENOMOUS_STRIKE]={last=15, base=0, every=6, max=5},
	},
	max_life = resolvers.rngavg(70,90),
}

-- boss：影魔
newEntity{ 
	base = "BASE_NPC_AMPHIBIAN_CRITTER", 
	define_as = "SHADOW_MAGIC",
	unique = true,
	name = "Shadow magic",
	color=colors.VIOLET,
	resolvers.nice_tile{
		image="invis.png", 
		add_mos = {{image="npc/shadow_magic.png", display_h = 1, display_y = -1}}
	},
	desc = [[The Shadow Devil is a monster living in the darkness. Any light will make him violent, trying to devour all the people who can produce light and even the torch.]],
	killer_message = "and folded out of existence",
	level_range = {4, nil}, exp_worth = 2,
	max_life = 150, life_rating = 10, fixed_rating = true,
	mana_regen = 7,
	stats = { str=10, dex=10, cun=12, mag=20, con=10 },
	rank = 4,
	tier1 = true,
	size_category = 4,
	infravision = 10,
	instakill_immune = 1,
	can_pass = {pass_void=0},

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1, LITE=1 },
	equipment = resolvers.equip{
		{defined="VOID_STAR", autoreq=true},
	},
	resolvers.drops{chance=100, nb=3, {tome_drops="boss"} },

	resolvers.talents{
		[Talents.T_VOID_BLAST]={base=1, every=7, max=7},
		[Talents.T_MANATHRUST]={base=1, every=7, max=7},
		[Talents.T_PHASE_DOOR]=2,
	},
	resolvers.inscriptions(1, {"manasurge rune"}),

	autolevel = "caster",
	ai = "tactical", ai_state = { talent_in=1, ai_move="move_astar", },
	ai_tactic = resolvers.tactic"ranged",

	on_die = function(self, who)
		local q = game.player:hasQuest("start-archmage")
		if q then q:stabilized() end
		game.player:resolveSource():setQuestStatus("start-archmage", engine.Quest.COMPLETED, "abashed")
	end,
}
