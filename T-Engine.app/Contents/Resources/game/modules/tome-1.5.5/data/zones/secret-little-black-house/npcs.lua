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

-- 鲤鱼战士基类
newEntity{
	define_as = "BASE_NPC_SQUID_WARRIOR",
	type = "horror", subtype = "corrupted",
	display = "h", color=colors.WHITE,
	blood_color = colors.BLUE,
	body = { INVEN = 10 },
	autolevel = "warrior",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=3, },
	faction = "horrors",

	combat_armor = 0, combat_def = 0,
	combat = { atk=2, dammod={str=0.6} },
--	max_life = resolvers.rngavg(30, 50),
	stats = { str=16, con=16 },
	infravision = 10,
	rank = 2,
	size_category = 3,

	blind_immune = 1,
	no_breath = 1,
}

-- 鲤鱼战士
newEntity{ 
	base = "BASE_NPC_SQUID_WARRIOR",
	define_as = "SQUID_WARRIOR",
	dredge = 1,
	name = "Squid warrior", 
	image="npc/squid_warrior.png",
	color=colors.SLATE,
	desc = "A squid-like monster emerges from the water. In addition to wearing armor and holding a weapon and holding a shield, it is a must-have warrior.",
	level_range = {1, nil}, exp_worth = 1,

	combat = { atk=6, dammod={str=0.6} },
	max_life = resolvers.rngavg(30, 50),

	rarity = 1,
	rank = 2,
	size_category = 2,
	autolevel = "warrior",

	open_door = true,

	resists = { [DamageType.BLIGHT] = 20, [DamageType.DARKNESS] = 20,  [DamageType.LIGHT] = - 20 },

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1, QUIVER=1 },
	resolvers.drops{chance=20, nb=1, {} },
	resolvers.drops{chance=60, nb=1, {type="money"} },

	resolvers.equip{
		{type="weapon", subtype="waraxe", autoreq=true},
		{type="armor", subtype="shield", autoreq=true},
	},

	resolvers.talents{
		[Talents.T_DWARF_RESILIENCE]={base=1, every=5, max=5},
	},

	resolvers.sustains_at_birth(),
}

-- 鳄鱼战士基类
newEntity{
	define_as = "BASE_NPC_CROCODILE_SOLDIER",
	type = "humanoid", subtype = "orc",
	display = "o", color=colors.UMBER,
	faction = "orc-pride",

	combat = { dam=resolvers.rngavg(5,12), atk=2, apr=6, physspeed=2 },

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1, QUIVER=1, TOOL=1 },
	resolvers.drops{chance=20, nb=1, {} },
	resolvers.drops{chance=10, nb=1, {type="money"} },
	infravision = 10,
	lite = 2,

	life_rating = 11,
	rank = 2,
	size_category = 3,

	open_door = true,

	autolevel = "warrior",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=3, },
	stats = { str=20, dex=8, mag=6, con=16 },
	resolvers.talents{ [Talents.T_WEAPON_COMBAT]={base=1, every=10, max=5}, },
	ingredient_on_death = "ORC_HEART",
}

-- 鳄鱼战士
newEntity{ base = "BASE_NPC_CROCODILE_SOLDIER",
	define_as = "CROCODILE_SOLDIER",
	name = "Crocodile soldier", 
	color=colors.LIGHT_UMBER,
	image="npc/crocodile_soldier.png",
	desc = [[A crocodile warrior with a big mouth, an axe and a shield rushed over to you, and waving an axe could fight you at any time.]],
	level_range = {7, nil}, exp_worth = 1,
	rarity = 1,
	max_life = resolvers.rngavg(70,80),
	resolvers.equip{
		{type="weapon", subtype="waraxe", autoreq=true},
		{type="armor", subtype="shield", autoreq=true},
	},
	resolvers.inscriptions(1, "infusion"),
	combat_armor = 2, combat_def = 0,
	resolvers.talents{
		[Talents.T_WEAPONS_MASTERY]={base=1, every=10, max=5},
		[Talents.T_SHIELD_PUMMEL]={base=1, every=6, max=5},
	},
	resolvers.racial(),
}

-- 河蚌女妖基类
newEntity{
	define_as = "BASE_NPC_RIVER_SLUT",
	type = "humanoid", subtype = "human",
	display = "p", color=colors.BLUE,

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

-- 河蚌女妖
newEntity{ 
	base = "BASE_NPC_RIVER_SLUT", 
	define_as = "RIVER_SLUT",
	name = "River slut", 
	image="npc/river_slut.png",
	color_r=resolvers.rngrange(0, 10), color_g=resolvers.rngrange(0, 10), color_b=resolvers.rngrange(0, 10),
	desc = [[The huge river otter suddenly opened, and a long-haired banshee curled up inside. It seemed to be the food that the river otter had just swallowed. In fact, the banshee occupied the river.]],
	level_range = {7, nil}, exp_worth = 1,
	rarity = 3,
	combat_armor = 3, combat_def = 10,
	resolvers.talents{
		[Talents.T_STEALTH]={base=3, every=6, max=7},
		[Talents.T_EXPOSE_WEAKNESS]={base=3, every=6, max=7},
		[Talents.T_DUAL_WEAPON_MASTERY]={base=2, every=6, max=6},
		[Talents.T_TEMPO]={base=2, every=6, max=6},
		[Talents.T_DUAL_STRIKE]={base=1, every=6, max=6},
		[Talents.T_COUP_DE_GRACE]={base=1, every=6, max=6},
		[Talents.T_SHADOWSTRIKE]={base=2, every=6, max=6},
		[Talents.T_LETHALITY]={base=5, every=6, max=8},
		[Talents.T_DISARM]={base=3, every=6, max=6},
	},
	max_life = resolvers.rngavg(70,90),

	resolvers.sustains_at_birth(),
	autolevel = "rogue",
}

-- 人鱼基类
newEntity{
	define_as = "BASE_NPC_MERMAID",
	type = "animal", subtype = "bear",
	display = "q", color=colors.WHITE,
	body = { INVEN = 10 },
	sound_moam = {"creatures/bears/bear_moan_%d", 1, 2},
	sound_die = {"creatures/bears/bear_moan_%d", 3, 4},
	sound_random = {"creatures/bears/bear_growl_%d", 1, 3},

	max_stamina = 100,

	autolevel = "zerker",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=5, },
	global_speed_base = 0.9,
	stats = { str=18, dex=13, mag=5, con=15 },
	infravision = 10,
	rank = 2,
	size_category = 4,

	combat_armor = 1, combat_def = 1,
	combat = { dam=resolvers.levelup(resolvers.rngavg(12, 25), 1, 1), atk=10, apr=3, physspeed=2, dammod={str=0.8} },
	life_rating = 12,

	resists = { [DamageType.FIRE] = 20, [DamageType.COLD] = 20, [DamageType.NATURE] = 20 },
	ingredient_on_death = "BEAR_PAW",
	not_power_source = {arcane=true, technique_ranged=true},
}

-- 人鱼
newEntity{ 
	base = "BASE_NPC_MERMAID",
	define_as = "MERMAID",
	name = "Mermaid", 
	color=colors.LIGHT_UMBER, 
	image = "npc/mermaid.png",
	resolvers.nice_tile{image="invis.png", add_mos = {{image="npc/mermaid.png",}}},
	desc = [[A green-haired mermaid was about to approach, but she suddenly opened her bloody mouth and judged the two.]],
	level_range = {8, nil}, exp_worth = 1,
	rarity = 4,
	max_life = resolvers.rngavg(110,120),
	combat_armor = 10, combat_def = 5,
	combat = { dam=resolvers.levelup(resolvers.rngavg(15, 20), 1, 1), atk=10, apr=3, physspeed=2 },
	resolvers.talents{ [Talents.T_STAMINA_POOL]=1, [Talents.T_STUN]=3, [Talents.T_KNOCKBACK]=2, [Talents.T_DISARM]=3,},
}

-- 飞天骷髅基类
newEntity{
	define_as = "BASE_NPC_FLYING_SKELETION",
	type = "animal", subtype = "canine",
	display = "C", color=colors.WHITE,
	level_range = {1, nil}, exp_worth = 1,

	ai = "dumb_talented_simple", ai_state = { talent_in=2, },
	energy = { mod=1.1 },
	combat = { dammod={str=0.6} },
	combat_armor = 1, combat_def = 1,
}

-- 飞天骷髅
newEntity{ 
	base = "BASE_NPC_FLYING_SKELETION",
	define_as = "FLYING_SKELETION",
	name = "Flying skeleton", color=colors.WHITE, 
	image="npc/flying_skeleton.png",
	desc = [[A strange one has grown a pair of wings, flying under the moonlight to fly the unspeakable horror.]],
	level_range = {8, nil},
	rarity = 3,
	max_life = resolvers.rngavg(70,100),
	combat_armor = 3, combat_def = 4,
	combat = { dam=8, atk=15, apr=3 },
}

-- 蛇发女妖基类
newEntity{
	define_as = "BASE_NPC_SNAKE_BANSHEE",
	type = "demon", subtype = "minor",
	display = "u", color=colors.WHITE,
	blood_color = colors.GREEN,
	faction = "fearscape",
	body = { INVEN = 10 },
	autolevel = "warrior",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=1, },
	stats = { str=12, dex=10, mag=3, con=13 },
	life_rating = 7,
	combat_armor = 1, combat_def = 1,
	combat = { dam=resolvers.mbonus(46, 20), atk=15, apr=7, dammod={str=0.7} },
	max_life = resolvers.rngavg(100,120),
	infravision = 10,
	open_door = true,
	rank = 2,
	size_category = 3,
	no_breath = 1,
	demon = 1,
	random_name_def = "demon",
}

-- 蛇发女妖
newEntity{ 
	base = "BASE_NPC_SNAKE_BANSHEE",
	define_as = "SNAKE_BANSHEE",
	image="npc/snake_banshee.png",
	name = "Snake banshee", color=colors.GREEN,
	desc = "With a snake-filled hair and a huge snaketail, the hand rushed over with a spear, and you felt a nausea.",
	level_range = {16, nil}, exp_worth = 1,
	rarity = 1,
	rank = 2,
	size_category = 1,
	autolevel = "caster",
	combat_armor = 1, combat_def = 0,
	combat = {dam=resolvers.mbonus(55, 15), apr=10, atk=resolvers.mbonus(50, 15), damtype=DamageType.ACID, dammod={mag=1}},

	resists={[DamageType.ACID] = 100},

	resolvers.talents{
		[Talents.T_RUSH]=6,
		[Talents.T_ACID_BLOOD]={base=3, every=10, max=6},
		[Talents.T_CORROSIVE_VAPOUR]={base=3, every=10, max=6},
	},

	make_escort = {
		{type="demon", subtype="minor", name="wretchling", number=rng.range(1, 4), no_subescort=true},
	},
	ingredient_on_death = "WRETCHLING_EYE",
}

-- boss 骷髅法师
newEntity{ 
	define_as = "NPC_BOSS_SKELETON_MAGE",
	name = "Skeleton mage",
	unique = true,
	type = "humanoid", subtype = "human", image = "npc/skeleton_mage_boss.png",
	female = true,
	display = "p", color=colors.GREY,
	resolvers.nice_tile{image="invis.png", add_mos = {{image="npc/skeleton_mage_boss.png", display_h=2, display_y=-1}}},
	desc = [[Dark magical elders, because they are old, their bodies are already decaying, but spiritual energy still dominates the broken body for evil destruction, and it is necessary to defeat all the magic of the world.]],
	autolevel = "caster",
	stats = { str=12, dex=17, mag=22, wil=22, con=12 },

	infravision = 10,
	move_others = true,

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1, QUIVER=1 },
	rank = 4,
	exp_worth = 1.5,
	level_range = {12, nil},

	equipment = resolvers.equip{
		{type="weapon", subtype="staff", force_drop=true, tome_drops="boss", forbid_power_source={antimagic=true}, autoreq=true},
		{type="armor", subtype="cloth", force_drop=true, tome_drops="boss", forbid_power_source={antimagic=true}, autoreq=true},
	},
	resolvers.drops{chance=100, nb=3, {tome_drops="boss"} },
	resolvers.drops{chance=100, nb=1, {unique=true} },

	max_life = 500, life_regen = 0,
	mana_regen = 10,
	mana_rating = 10,
	life_rating = 20,

	soul = 6,
	resolvers.talents{
		[Talents.T_STAFF_MASTERY]={base=2, every=8, max = 5},
		[Talents.T_INVOKE_DARKNESS]={base=5, every=5, max=10},
		[Talents.T_NECROTIC_AURA]=1,
		[Talents.T_CREATE_MINIONS]=2,
		[Talents.T_AURA_MASTERY]=5,
		[Talents.T_SURGE_OF_UNDEATH]={base=2, every=4, max=7},
		[Talents.T_CHILL_OF_THE_TOMB]={base=3, every=5, max=10},
		[Talents.T_WILL_O__THE_WISP]={base=3, every=5, max=10},
		[Talents.T_COLD_FLAMES]={base=4, every=5, max=10},
		[Talents.T_VAMPIRIC_GIFT]={base=2, every=5, max=10},
		[Talents.T_BLURRED_MORTALITY]={base=5, every=5, max=10},
		[Talents.T_CIRCLE_OF_DEATH]={base=3, every=5, max=10},
		[Talents.T_RIGOR_MORTIS]={base=3, every=5, max=10},
		[Talents.T_FORGERY_OF_HAZE]={base=3, every=5, max=10},
		[Talents.T_FROSTDUSK]={base=3, every=5, max=10},
	},
	resolvers.sustains_at_birth(),

	ai = "tactical", ai_state = { talent_in=1, ai_move="move_astar", },
	ai_tactic = resolvers.tactic"ranged",
	resolvers.inscriptions(2, "rune"),
	resolvers.inscriptions(1, {"manasurge rune"}),

	on_takehit = function(self, val)
		if not game.zone.open_all_coffins then return val end
		self.on_takehit = nil
		game.zone.open_all_coffins(game.player, self)
		local p = game:getPlayer(true)
		p:setQuestStatus("grave-necromancer", engine.Quest.COMPLETED, "coffins")
		return val
	end,

	on_die = function(self)
		local p = game:getPlayer(true)
		if game.player:hasQuest("lichform") then
			game.player:setQuestStatus("lichform", engine.Quest.COMPLETED, "heart")

			local o = game.zone:makeEntityByName(game.level, "object", "CELIA_HEART")
			o:identify(true)
			if p:addObject(p.INVEN_INVEN, o) then
				game.logPlayer(p, "You receive: %s.", o:getName{do_color=true})
			end

			local Dialog = require("engine.ui.Dialog")
			Dialog:simpleLongPopup("Celia", "As you deal the last blow you quickly carve out Celia's heart for your Lichform ritual.\nCarefully weaving magic around it to keep it beating.", 400)
			p:setQuestStatus("grave-necromancer", engine.Quest.COMPLETED, "kill-necromancer")
		else
			if game.party:knownLore("necromancer-primer-1") and
			   game.party:knownLore("necromancer-primer-2") and
			   game.party:knownLore("necromancer-primer-3") and
			   game.party:knownLore("necromancer-primer-4") then
				game:setAllowedBuild("mage_necromancer", true)
			end
			p:setQuestStatus("grave-necromancer", engine.Quest.COMPLETED, "kill")
		end
		p:setQuestStatus("grave-necromancer", engine.Quest.COMPLETED)
	end,
}
