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


local dungeon_wall_editer = { method="sandWalls_def", def="smooth_dungeon_wall"}



-- Normal dungeon  floor
newEntity{
	define_as = "DUNGEON_FLOOR",
	type = "floor", subtype = "floor",
	name = "floor", image = "terrain/dungeon/dungeon-floor1.png",
	display = '.', color_r=255, color_g=255, color_b=255, back_color=colors.BLACK,
	grow = "WALL",
	nice_tiler = { method="floor3d", inner={"DUNGEON_FLOOR", 100, 1, 50}}, -- 50表示FLOOR图元的个数
}


for i=1, 50 do 	 -- 50对应FLOOR图元的最大数
	newEntity{
		base = "DUNGEON_FLOOR", define_as = "DUNGEON_FLOOR"..i,
  		image = "terrain/dungeon/dungeon-floor1_"..i..".png", 
	}
end


-- Normal dungeon wall
newEntity{
	define_as = "DUNGEON_WALL",
	type = "wall", subtype = "floor",
	name = "wall", image = "terrain/dungeon/wall.png",
	display = '#', color_r=255, color_g=255, color_b=255, back_color=colors.GREY,
	z = 3,
    nice_tiler = { method="wall3d", inner={"DUNGEON_WALL", 100, 1, 30}, north={"DUNGEON_WALL_NORTH", 100, 1, 30}, south={"DUNGEON_WALL_SOUTH", 100, 1, 30}, east = "DUNGEON_WALL_EAST", west = "DUNGEON_WALL_WEST", west_north = "DUNGEON_WALL_WEST_NORTH", east_north = "DUNGEON_WALL_EAST_NORTH", north_south="DUNGEON_WALL_NORTH_SOUTH", small_pillar="DUNGEON_WALL_SMALL_PILLAR"},
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "DUNGEON_FLOOR",
	-- nice_editer = slime_wall_editer,
}
for i = 1, 30 do    --  30表示普通墙壁的图元最大个数， 和inner中的30保持一致
	newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL"..i, image = "terrain/dungeon/wall_"..i..".png", z = 18}
	
end

for i = 1, 30 do   -- 30表示正向墙壁图元的最大个数， 和north中的30保持一致
	newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_NORTH"..i, image = "terrain/dungeon/wall_north_bottom_"..i..".png", z = 1, add_displays = {class.new{image="terrain/dungeon/wall_north_middle_"..i..".png", z=3}, class.new{image="terrain/dungeon/wall_north_top_"..i..".png", z=18, display_y=-1}}}
	newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_SOUTH"..i, 
		image = "terrain/dungeon/wall_north_bottom_"..i..".png", z = 1, 
		add_displays = {class.new{image="terrain/dungeon/wall_north_middle_"..i..".png", z=3}, class.new{image="terrain/dungeon/wall_north_top_"..i..".png", z=18, display_y=-1}}
    } 
end


newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_NORTH_SOUTH", image = "terrain/dungeon/wall_north_bottom_1.png", z = 1, add_displays = {class.new{image="terrain/dungeon/wall_north_middle_1.png", z=3}, class.new{image="terrain/dungeon/wall_north_top_1.png", z=18, display_y=-1}}}
newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_SOUTH", image = "terrain/dungeon/wall_north_bottom.png", z = 1, add_displays = {class.new{image="terrain/dungeon/wall_north_middle.png", z=3}, class.new{image="terrain/dungeon/wall_north_top.png", z=18, display_y=-1}}}
newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_EAST", image = "terrain/dungeon/wall_east_bottom.png", z = 1, add_displays = {class.new{image="terrain/dungeon/wall_east_middle.png", z=3}, class.new{image="terrain/dungeon/wall_east_top.png", z=18, display_y=-1}}}
newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_WEST", image = "terrain/dungeon/wall_wast_bottom.png", z = 1, add_displays = {class.new{image="terrain/dungeon/wall_west_middle.png", z=3}, class.new{image="terrain/dungeon/wall_west_top.png", z=18, display_y=-1}}}
newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_WEST_NORTH", image = "terrain/dungeon/wall_west_north_bottom.png", z = 1, add_displays = {class.new{image="terrain/dungeon/wall_west_north_middle.png", z=3}, class.new{image="terrain/dungeon/wall_west_north_top.png", z=18, display_y=-1}}}
newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_EAST_NORTH", image = "terrain/dungeon/wall_east_north_bottom.png", z = 1, add_displays = {class.new{image="terrain/dungeon/wall_east_north_middle.png", z=3}, class.new{image="terrain/dungeon/wall_east_north_top.png", z=18, display_y=-1}}}

newEntity{ base = "DUNGEON_WALL", define_as = "DUNGEON_WALL_SMALL_PILLAR", image = "terrain/dungeon/statue1_bottom.png", z = 3, add_displays = {class.new{image="terrain/dungeon/statue1_top.png",z=18, display_y=-1}}}




-- Smooth dungeon floor, 类似于沙地的效果
newEntity{
	define_as = "DUNGEON_FLOOR_SMOOTH",
	type = "floor", subtype = "sand",
	name = "sand", image = "terrain/dungeon/dungeon_sand.png",
	display = '.', color={r=203,g=189,b=72}, back_color={r=93,g=79,b=22},
	nice_tiler = { method="replace", base={"DUNGEON_FLOOR_SMOOTH", 10, 1, 11}},
}
for i = 1, 11 do newEntity{ base = "DUNGEON_FLOOR_SMOOTH", define_as = "DUNGEON_FLOOR_SMOOTH"..i, image = "terrain/dungeon/dungeon_sand_"..i..".png"} end



-- Smooth dungeon wall
newEntity{
	define_as = "DUNGEON_WALL_SMOOTH",
	type = "wall", subtype = "sand",
	name = "sandwall", image = "terrain/dungeon/dungeon_sand_V3_5_01.png",
	display = '#', color={r=203,g=189,b=72}, back_color={r=93,g=79,b=22},
	always_remember = true,
	can_pass = {pass_wall=1},
	does_block_move = true,
	block_sight = true,
	air_level = -10,
	-- Dig only makes unstable tunnels
	-- dig = function(src, x, y, old)
	-- 	local sand = require("engine.Object").new{
	-- 		name = "unstable sand tunnel", image = "terrain/sand.png",
	-- 		show_tooltip = true,
	-- 		desc = [[Loose sand is steadily filling this void, which could collapse suddenly and completely.]],
	-- 		display = '.', color={r=203,g=189,b=72}, back_color={r=93,g=79,b=22},
	-- 		canAct = false,
	-- 		act = function(self)
	-- 			self:useEnergy()
	-- 			self.temporary = self.temporary - 1
	-- 			if self.temporary <= 0 then
	-- 				game.level.map(self.x, self.y, engine.Map.TERRAIN, self.old_feat)
	-- 				game.level:removeEntity(self, true)
	-- 				game.logSeen(self, "The unstable sand tunnel collapses!")
	-- 				game.nicer_tiles:updateAround(game.level, self.x, self.y)

	-- 				local a = game.level.map(self.x, self.y, engine.Map.ACTOR)
	-- 				if a and not a:attr("sand_dweller") then
	-- 					game.logPlayer(a, "You are crushed by the collapsing tunnel! You suffocate!")
	-- 					a:suffocate(30, self, "was buried alive")
	-- 					engine.DamageType:get(engine.DamageType.PHYSICAL).projector(self, self.x, self.y, engine.DamageType.PHYSICAL, a.life / 2)
	-- 				end
	-- 			end
	-- 		end,
	-- 		tunneler_dig = 1,
	-- 		dig = function(src, x, y, old)
	-- 			old.temporary = 20
	-- 			return nil, old, true
	-- 		end,
	-- 		tooltip = mod.class.Grid.tooltip
	-- 	}
	-- 	sand.summoner_gain_exp = true
	-- 	sand.summoner = src
	-- 	sand.old_feat = old
	-- 	sand.temporary = 20
	-- 	sand.x = x
	-- 	sand.y = y
	-- 	game.level:addEntity(sand)
	-- 	return nil, sand, true
	-- end,
	nice_editer = dungeon_wall_editer,
	nice_tiler = { method="replace", base={"DUNGEON_WALL_SMOOTH", 20, 1, 6}},
}
for i = 1, 6 do newEntity{ base = "DUNGEON_WALL_SMOOTH", define_as = "DUNGEON_WALL_SMOOTH"..i, image = "terrain/dungeon/dungeon_sandwall_5_"..i..".png"} end


newEntity{
	define_as = "DUNGEON_SMOOTH_LADDER_DOWN",
	type = "floor", subtype = "sand",
	name = "ladder to the next level", image = "terrain/dungeon/dungeon_sand.png", add_displays = {class.new{image="terrain/dungeon/ladder_down.png"}},
	display = '>', color_r=255, color_g=255, color_b=0,
	notice = true,
	always_remember = true,
	change_level = 1,
	nice_editer = sand_editer,
}


newEntity{
	define_as = "DUNGEON_SMOOTH_LADDER_UP",
	type = "floor", subtype = "sand",
	name = "ladder to the previous level", image = "terrain/dungeon/dungeon_sand.png", add_displays = {class.new{image="terrain/dungeon/ladder_up.png"}},
	display = '<', color_r=255, color_g=255, color_b=0,
	notice = true,
	always_remember = true,
	change_level = -1,
	nice_editer = sand_editer,
}