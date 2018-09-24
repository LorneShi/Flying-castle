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

-- 村长的对话-中文

newChat{ id="welcome",
	text = [[格雷你终于来了！村里消失了好几个人，并且最近后山森林中有好多怪物，这和村民的消失已定脱不了关系！]],
	answers = {
		{
			"请放心，我现在立刻去森林中查看。", 
			cond=function(npc, player) 
				return not player:hasQuest("the-beast-within-forest")
			end,
			action=function(npc, player) 
				player:grantQuest("the-beast-within-forest") 
			end,
			jump = "accept"
		},
		{
			"我正在调查...", 
			cond=function(npc, player) 
				return player:hasQuest("the-beast-within-forest") and not player:hasQuest("the-beast-within-forest"):isCompleted()
			end,
		},
		{
			"我已经救出了村民，并且消灭了怪物！", 
			cond=function(npc, player) 
				return player:hasQuest("the-beast-within-forest") and player:hasQuest("the-beast-within-forest"):isCompleted()
			end,
			jump = "thanks"
		},
	}
}

newChat{ id="accept",
	text = [[祝你好运！]],
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
	text = [[谢谢！]],
	answers = {
		{
			"好的",
		},
	}
}

return "welcome"
