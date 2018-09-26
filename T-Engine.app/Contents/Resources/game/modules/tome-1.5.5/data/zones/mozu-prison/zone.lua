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

return {
	name = "Mozu prison",
	level_range = {1, 3},
	level_scheme = "player",
	max_level = 2,
	decay = {50, 100},
	actor_adjust_level = function(zone, level, e) return zone.base_level + e:getRankLevelAdjust() + level.level-1 + rng.range(-1,2) end,
	width = 20, height = 20,
--	all_remembered = true,
--	all_lited = true,
	persistent = "zone",
	ambient_music = {"The Ancients.ogg","weather/dungeon_base.ogg"},
	min_material_level = function() return game.state:isAdvanced() and 2 or 1 end,
	max_material_level = function() return game.state:isAdvanced() and 5 or 3 end,
	generator =  {
		map = {
			class = "engine.generator.map.Maze",
			up = "UP",
			down = "DOWN",
			wall = "OLD_WALL",
			floor = "OLD_FLOOR",
			widen_w = 2, widen_h = 2,
		},
		actor = {
			class = "mod.class.generator.actor.Random",
			nb_npc = {5, 10},
			guardian = "MINOTAUR_MAZE",
			guardian_alert = true,
		},
		object = {
			class = "engine.generator.object.Random",
			nb_object = {6, 10},
		},
		trap = {
			class = "engine.generator.trap.Random",
			nb_trap = {0, 0},
		},
	},
	levels =
	{
		[1] = {
			generator = { map = {
				up = "UP_WILDERNESS",
			}, },
		},
		[2] = {
			width = 10, height = 10,
			generator = { 
				map = {
					force_last_stair = true,
					down = "BACK_MOONLIGHT_TOWN",
				}, 
				actor = {
					nb_npc = {4, 8},
				}, 
				object = {
					nb_object = {4, 6},
				},
			},
		},
	},

	post_process = function(level)
		-- Place a lore note on each level
		game:placeRandomLoreObject("NOTE"..level.level)

		local p = game.party:findMember{main=true}
		if level.level == 1 and p:knowTalentType("cunning/trapping") then
			local l = game.zone:makeEntityByName(level, "object", "NOTE_LEARN_TRAP")
			if not l then return end
			for _, coord in pairs(util.adjacentCoords(level.default_down.x, level.default_down.y)) do
				if game.level.map:isBound(coord[1], coord[2]) and (i ~= 0 or j ~= 0) and not game.level.map:checkEntity(coord[1], coord[2], engine.Map.TERRAIN, "block_move") then
					game.zone:addEntity(level, l, "object", coord[1], coord[2])
					return
				end
			end
		end

		game.state:makeAmbientSounds(level, {
			dungeon2={ chance=250, volume_mod=1, pitch=1, random_pos={rad=10}, files={"ambient/dungeon/dungeon1","ambient/dungeon/dungeon2","ambient/dungeon/dungeon3","ambient/dungeon/dungeon4","ambient/dungeon/dungeon5"}},
		})
	end,
}