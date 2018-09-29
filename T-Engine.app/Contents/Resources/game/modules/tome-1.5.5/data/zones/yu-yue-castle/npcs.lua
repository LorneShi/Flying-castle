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
newEntity{ define_as = "YUYUE_CASTLE_MESSENGER",
	type = "humanoid", 
	subtype = "shalore",
	display = "p",
	faction = "Yu Yue Castle",
	name = "Messenger", 
	color=colors.CRIMSON,
	unique = true,
	resolvers.nice_tile{image="invis.png", 
		add_mos = {{image="npc/humanoid_human_cryomancer.png", display_h=2, display_y=-1}}
	},
	desc = [[Messenger]],
	level_range = {30, nil}, 
	exp_worth = 2,
	never_move = 1,
	can_talk = "yuyue-castle-messenger",
	seen_by = function(self, who)
		if not game.party:hasMember(who) then return end
		self.seen_by = nil
		self:doEmote("Help! Help! Help!!!", 120, colors.RED)
	end,	
}


