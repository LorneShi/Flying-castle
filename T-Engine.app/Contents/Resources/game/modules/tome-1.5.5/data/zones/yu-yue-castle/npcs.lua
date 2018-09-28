-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2018 Nicolas Casalini
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

-- sll

-- 任务NPC
newEntity{ define_as = "MOONLIGHT_TOWN_VILLAGE_HEAD",
	type = "humanoid", 
	subtype = "shalore",
	display = "p",
	faction = "Moonlight town",
	name = "Village head", 
	color=colors.CRIMSON,
	unique = true,
	resolvers.nice_tile{image="invis.png", 
		add_mos = {{image="npc/humanoid_human_cryomancer.png", display_h=2, display_y=-1}}
	},
	desc = [[Manager of Moonlight Town]],
	level_range = {30, nil}, 
	exp_worth = 2,

	can_talk = "village-head",
}

newEntity{ define_as = "MOONLIGHT_TOWN_BLACKSMITH",
	type = "humanoid", 
	subtype = "shalore",
	display = "p",
	faction = "Moonlight town",
	name = "Blacksmith", 
	color=colors.CRIMSON,
	unique = true,
	resolvers.nice_tile{image="invis.png", 
		add_mos = {{image="npc/humanoid_human_pyromancer.png", display_h=2, display_y=-1}}
	},
	desc = [[The first blacksmith in the mainland]],
	level_range = {30, nil}, 
	exp_worth = 2,

	can_talk = "blacksmith",
}


-- 村民
newEntity{
	define_as = "BASE_NPC_ANGOLWEN_TOWN",
	type = "humanoid", subtype = "human",
	display = "p", color=colors.WHITE,
	faction = "angolwen",
	anger_emote = "Catch @himher@!",
	hates_antimagic = 1,

	resolvers.racial(),

	combat = { dam=resolvers.rngavg(1,2), atk=2, apr=0, dammod={str=0.4} },

	body = { INVEN = 10, MAINHAND=1, OFFHAND=1, BODY=1, QUIVER=1 },
	lite = 3,

	life_rating = 11,
	rank = 2,
	size_category = 3,

	open_door = true,

	autolevel = "caster",
	ai = "dumb_talented_simple", ai_state = { ai_move="move_complex", talent_in=3, },
	stats = { str=8, dex=8, mag=16, wil=18, con=10 },

	emote_random = resolvers.emote_random{allow_backup_guardian=true},
}

newEntity{ base = "BASE_NPC_ANGOLWEN_TOWN",
	name = "apprentice mage", color=colors.RED,
	desc = [[An apprentice, learning the ways of the arcane arts.]],
	level_range = {1, nil}, exp_worth = 1,
	rarity = 3,
	max_life = resolvers.rngavg(70,80),
	resolvers.equip{
		{type="weapon", subtype="staff", forbid_power_source={antimagic=true}, autoreq=true},
		{type="armor", subtype="cloth", forbid_power_source={antimagic=true}, autoreq=true},
	},
	combat_armor = 2, combat_def = 0,
	resolvers.talents{ [Talents.T_MANATHRUST]=2, [Talents.T_FREEZE]=1, },
}
