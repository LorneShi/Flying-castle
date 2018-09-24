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

-- 铁匠的对话

newChat{ id="welcome",
	text = [[Gray, I still have some XXX items on my baby. If you can help me find 10 XXX, I will send him to you!]],
	answers = {
		{
			"That's great! I will collect it right away.", 
			cond=function(npc, player) 
				return not player:hasQuest("blacksmith-gifts")
			end,
			action=function(npc, player) 
				player:grantQuest("blacksmith-gifts") 
			end,
		},
		{
			"Collecting...", 
			cond=function(npc, player) 
				return player:hasQuest("blacksmith-gifts") and not player:hasQuest("blacksmith-gifts"):isCompleted()
			end,
		},
		{
			"I have found 10 XXX.", 
			cond=function(npc, player) 
				return player:hasQuest("blacksmith-gifts") and player:hasQuest("blacksmith-gifts"):isCompleted()
			end,
			jump = "thanks"
		},
	}
}


newChat{ id="thanks",
	text = [[Thanks! Give you endless battle.]],
	answers = {
		{
			"Thanks",
		},
	}
}

return "welcome"
