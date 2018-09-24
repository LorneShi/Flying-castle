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

-- 村长的对话

newChat{ id="welcome",
	text = [[Gray, you are finally here! There are several people disappeared in the village, and there are many monsters in the forest in the back mountain recently. This has nothing to do with the disappearance of the villagers! Can you help me check it out?]],
	answers = {
		{
			"Of course, I will go to the forest right now.", 
			cond=function(npc, player) 
				return not player:hasQuest("the-beast-within-forest")
			end,
			action=function(npc, player) 
				player:grantQuest("the-beast-within-forest") 
			end,
			jump = "accept"
		},
		{
			"I am investigating", 
			cond=function(npc, player) 
				return player:hasQuest("the-beast-within-forest") and not player:hasQuest("the-beast-within-forest"):isCompleted()
			end,
		},
		{
			"I have rescued the villagers and eliminated the monsters.", 
			cond=function(npc, player) 
				return player:hasQuest("the-beast-within-forest") and player:hasQuest("the-beast-within-forest"):isCompleted()
			end,
			jump = "thanks"
		},
	}
}

newChat{ id="accept",
	text = [[Good luck!]],
	answers = {
		{
			"[teleport]",
			action=function(npc, player) 
				game:changeLevel(1, "trollmire", {direct_switch=true}) 
			end
		},
	}
}

newChat{ id="thanks",
	text = [[Thanks!]],
	answers = {
		{
			"OK",
		},
	}
}

return "welcome"
