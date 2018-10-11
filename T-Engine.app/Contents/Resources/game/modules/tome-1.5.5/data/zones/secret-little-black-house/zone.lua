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
	name = "Secret little black house",
	level_range = {6, 12},
	level_scheme = "player",
	max_level = 3,
	decay = {50, 100},
	actor_adjust_level = function(zone, level, e) return zone.base_level + e:getRankLevelAdjust() + level.level-1 + rng.range(-1,2) end,
	width = 40, height = 40,
--	all_remembered = true,
--	all_lited = true,
	persistent = "zone",
	ambient_music = {"The Ancients.ogg","weather/dungeon_base.ogg"},
	min_material_level = function() return game.state:isAdvanced() and 2 or 1 end,
	max_material_level = function() return game.state:isAdvanced() and 5 or 3 end,
	generator =  {
		map = {
			class = "engine.generator.map.TileSet",
			tileset = {"7x7/base", "7x7/tunnel",},
			['.'] = "DUNGEON_FLOOR_SMOOTH",
			['#'] = "DUNGEON_WALL_SMOOTH",
      		['+'] = "DOOR",
			["'"] = "DOOR",
			up = "DUNGEON_SMOOTH_LADDER_UP",
			down = "DUNGEON_SMOOTH_LADDER_DOWN",
			door = "DUNGEON_FLOOR_SMOOTH",
			force_down = true,		
		},
		actor = {
			class = "mod.class.generator.actor.Random",
			nb_npc = {16, 30},
			guardian = "MINOTAUR_MAZE",
			guardian_alert = true,
		},
		object = {
			class = "engine.generator.object.Random",
			nb_object = {4, 6},
		},
		trap = {
			class = "engine.generator.trap.Random",
			nb_trap = {0, 0},
		},
	},
	levels =
	{
		[1] = {
			level_range = {6, 8},
			generator = { 
				map = {
					up = "UP_WILDERNESS",
				}, 
			},
		},
		[2] = {
			level_range = {6, 9},
			width = 30, 
			height = 30,
			generator = { 
				actor = {
					nb_npc = {20, 25},
				}, 
				object = {
					nb_object = {4, 5},
				},
			},
		},
		[3] = {
			level_range = {6, 12},		
			width = 20, 
			height = 20,
			generator = { 
				actor = {
					nb_npc = {14, 16},
				}, 
				object = {
					nb_object = {5, 6},
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