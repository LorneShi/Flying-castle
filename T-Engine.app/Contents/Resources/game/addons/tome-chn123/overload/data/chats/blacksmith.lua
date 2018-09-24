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

-- 铁匠的对话-中文

newChat{ id="welcome",
	text = [[我的宝贝上还差一些XXX物品，如果你能帮我找到10个XXX，我就送给你一样孤品！]],
	answers = {
		{
			"太棒了！我马上去帮你找。", 
			cond=function(npc, player) 
				return not player:hasQuest("blacksmith-gifts")
			end,
			action=function(npc, player) 
				player:grantQuest("blacksmith-gifts") 
			end,
		},
		{
			"收集中...", 
			cond=function(npc, player) 
				return player:hasQuest("blacksmith-gifts") and not player:hasQuest("blacksmith-gifts"):isCompleted()
			end,
		},
		{
			"我已经找了 10 XXX.", 
			cond=function(npc, player) 
				return player:hasQuest("blacksmith-gifts") and player:hasQuest("blacksmith-gifts"):isCompleted()
			end,
			jump = "thanks"
		},
	}
}


newChat{ id="thanks",
	text = [[谢谢！给你XXX宝贝。]],
	answers = {
		{
			"谢谢！",
		},
	}
}

return "welcome"
