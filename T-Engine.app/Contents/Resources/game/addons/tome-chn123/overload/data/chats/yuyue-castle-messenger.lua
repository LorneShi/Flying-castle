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

--sll 羽月城堡的信使对话-中文

newChat{ id="welcome",
	text = [[总算找到人了！我们月色镇最近好多人莫名其妙的消失了，整个镇子死气沉沉，您能帮帮我们吗？（月色镇在城堡的西边）]],
	answers = {
		{
			"不要着急，我马上去看看！", 
			action=function(npc, player) 
				game:changeLevel(1, "moonlight-town", {direct_switch=true}) 
				npc:die()
			end
		},
	}
}

return "welcome"
