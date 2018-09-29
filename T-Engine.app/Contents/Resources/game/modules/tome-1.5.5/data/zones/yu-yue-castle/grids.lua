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

load("/data/general/grids/basic.lua")
load("/data/general/grids/forest.lua")
load("/data/general/grids/water.lua")
load("/data/general/grids/mountain.lua")
load("/data/zones/wilderness/grids.lua")

newEntity{ base = "GRASS", define_as = "FIELDS",
	name="cultivated fields",
	display=';', image="terrain/cultivation.png",
	nice_tiler = { method="replace", base={"FIELDS", 100, 1, 4}},
}
for i = 1, 4 do newEntity{ base = "FIELDS", define_as = "FIELDS"..i, image="terrain/grass.png", add_mos={{image="terrain/cultivation0"..i..".png"}} } end

newEntity{ base = "FLOOR", define_as = "COBBLESTONE",
	name="cobblestone road",
	display='.', image="terrain/stone_road1.png",
	special_minimap = colors.DARK_GREY,
}

newEntity{ base = "FLOOR", define_as = "ROCK",
	name="magical rock",
	image="terrain/grass.png", add_displays = {class.new{image="terrain/maze_rock.png", z=4}},
	does_block_move = true
}

newEntity{ base = "DEEP_WATER", define_as = "FOUNTAIN",
	name="fountain",
	does_block_move = true,
	block_move=function(self, x, y, e, act, couldpass)
		if e and e.player and act then game.party:learnLore("angolwen-fountain") end
		return true
	end,
}

newEntity{ base = "DEEP_WATER", define_as = "FOUNTAIN_MAIN",
	name="fountain",
	does_block_move = true,
	add_displays = {class.new{
		z = 17,
		image = "terrain/statues/angolwen_fountain.png",
		display_w = 6, display_h = 5,
		display_x = -2.5, display_y = -2,
	}},
}

-- sll Room
newEntity{
	define_as = "ROOM",
	type = "room", 
	subtype = "room",
	name = "room", 
	image = "terrain/grass.png",
	display = 'a', color_r=255, color_g=255, color_b=255, back_color=colors.GREY,
	z = 3,
	does_block_move = true,
}

for i = 1, 144 do
	newEntity{ base = "ROOM", define_as = "BUILDS_GROUP_1_"..i, image="terrain/grass.png", add_displays = {class.new{image="terrain/builds/builds_group_1_"..i..".png", z=4}}}
end

for i = 1, 80 do
	newEntity{ base = "ROOM", define_as = "GRASS_1_"..i, image="terrain/grass.png", add_displays = {class.new{image="terrain/grass_new/grass_1_"..i..".png", z=4}}}
end

for i = 1, 256 do
	newEntity{ base = "ROOM", define_as = "ORNAMENTS_1_"..i, image="terrain/grass.png", add_displays = {class.new{image="terrain/ornaments/ornaments_1_"..i..".png", z=4}}}
end

for i = 1, 5 do
	if i == 3 then
		newEntity{
			base = "ROOM", 
			define_as = "BOX_1_"..i, 
			image="terrain/grass.png", 
			add_displays = {class.new{image="terrain/box/box_1_"..i..".png", z=4}},
			does_block_move = false,
		}
	else
		newEntity{ base = "ROOM", define_as = "BOX_1_"..i, image="terrain/grass.png", add_displays = {class.new{image="terrain/box/box_1_"..i..".png", z=4}}}
	end
end

-- 城堡地板
for i = 1, 5 do
	newEntity{ 
		base = "ROOM", 
		define_as = "CASTLE_1_FLOOR_"..i,
		image = "terrain/castle_floor/castle_1_floor__"..i..".png",
		does_block_move = false,
	}
end

-- 城堡墙
for i = 1, 142 do
	if i == 4 or i == 3 or i == 78 or i == 85 or i == 92 or i == 83 or i == 47
		or i == 93  or i == 96  or i == 97 or i == 90 or i == 5 or i == 44 or i == 42 or i == 41
		or i == 36 or i == 37 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_WALL_"..i,
			image="terrain/grass_worldmap/grass_main_01.png",
			add_displays = {class.new{image="terrain/castle_wall/castle_1_wall__"..i..".png", z=4}},
			does_block_move = true,
		}		
	elseif i == 89 or i == 86 or i == 38 or i == 39 or i == 40 or i == 79 or i == 82 or i == 113 
		or i == 119 or i == 129 or i == 131 or i == 132 or i == 133 or i == 134 or i == 130 or i == 122 
		or i == 116 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_WALL_"..i,
			image="terrain/castle_floor/castle_1_floor__2.png",
			add_displays = {class.new{image="terrain/castle_wall/castle_1_wall__"..i..".png", z=4}},
			does_block_move = true,
		}			
	else
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_WALL_"..i,
			image="terrain/castle_wall/castle_1_wall__"..i..".png",
			does_block_move = true,
		}		
	end
end

-- 城堡体
for i = 1, 224 do
	if i == 198 or i == 197 or i == 183 or i == 184 or i == 169 or i == 155 or i == 141
		or i == 99 or i == 85 or i == 71 or i == 57
		or i == 2 or i == 58 or i == 60 
		or i == 61
		or i == 64 or i == 38
		or i == 68 or i == 69 or i == 83 or i == 97 or i == 111 
		or i == 70 or i == 84 or i == 98 or i == 112 or i == 154 or i == 168 
		or i == 182 or i == 196 or i == 167 or i == 181 or i == 194 or i == 195 or i == 196 or i == 208 
		or i == 209 or i == 210 or i == 207 or i == 206 or i == 205 or i == 204 or i == 199 or i == 200 
		or i == 201 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image="terrain/castle_floor/castle_1_floor__2.png",
			add_displays = {class.new{image="terrain/castle_castle/castle_1_castle__"..i..".png", z=4}},
			does_block_move = true,
		}			
	elseif i == 44 or i == 43 or i == 46 or i == 47 or i == 51 or i == 53 or i == 54 or i == 55 
		or i == 56 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image="terrain/castle_floor/castle_1_floor__2.png",
			add_displays = {
				class.new{image="terrain/castle_wall/castle_1_wall__39.png", z=4},
				class.new{image="terrain/castle_castle/castle_1_castle__"..i..".png", z=5}
			},
			does_block_move = true,
		}	
	elseif i == 30 or i == 2 or i == 1 or i == 33 or i == 34 or i == 36 or i == 37 or i == 39 or i == 40 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image="terrain/castle_wall/castle_1_wall__32.png",
			add_displays = {
				class.new{image="terrain/castle_castle/castle_1_castle__"..i..".png", z=4}
			},
			does_block_move = true,
		}	
	elseif i == 16 or i == 17 or i == 18 or i == 19 or i == 20 or i == 21 or i == 22 or i == 23 or i == 24
		or i == 25 or i == 26 or i == 32 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image="terrain/castle_wall/castle_1_wall__25.png",
			add_displays = {
				class.new{image="terrain/castle_castle/castle_1_castle__"..i..".png", z=4}
			},
			does_block_move = true,
		}
	elseif i == 3 or i == 4 or i == 5 or i == 6 or i == 7 or i == 8 or i == 9 or i == 10 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image="terrain/castle_wall/castle_1_wall__18.png",
			add_displays = {
				class.new{image="terrain/castle_castle/castle_1_castle__"..i..".png", z=4}
			},
			does_block_move = true,
		}	
	elseif i == 113 or i == 125 or i == 126 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image="terrain/castle_wall/castle_1_wall__114.png",
			add_displays = {
				class.new{image="terrain/castle_castle/castle_1_castle__"..i..".png", z=4}
			},
			does_block_move = true,
		}	
	elseif i == 127 or i == 139 or i == 140 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image="terrain/castle_floor/castle_1_floor__2.png",
			add_displays = {
				class.new{image="terrain/castle_wall/castle_1_wall__120.png", z=4},
				class.new{image="terrain/castle_castle/castle_1_castle__"..i..".png", z=5}
			},
			does_block_move = true,
		}												
	else
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_CASTLE_"..i,
			image = "terrain/castle_castle/castle_1_castle__"..i..".png",
			z = 3,
			does_block_move = true,
		}	
	end	
end

-- 城堡房子
for i = 1, 90 do
	if i == 15 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_ROOM_"..i,
			image = "terrain/castle_castle/castle_1_castle__97.png",
			add_displays = {class.new{image="terrain/castle_room/castle_1_room_"..i..".png", z=4}},
			does_block_move = true,
		}
	elseif i == 5 or i == 14 or i == 23 or i == 32 or i == 41 or i == 50 or i == 59 or i == 68 
		or i == 77 or i == 86 or i == 6 or i == 8 or i == 54 or i == 63 or i == 72 or i == 81
		or i == 90 or i == 65 or i == 19 or i == 10 or i == 1 or i == 2 or i == 3
		or i == 4 or i == 13 or i == 22 or i == 31 or i == 40 or i == 49 or i == 58 or i == 67
		or i == 66 or i == 18 or i == 45 or i == 36 or i == 27 or i == 9 or i == 64 or i == 55 
		or i == 46 or i == 37 or i == 28 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_ROOM_"..i,
			image = "terrain/castle_floor/castle_1_floor__2.png",
			add_displays = {class.new{image="terrain/castle_room/castle_1_room_"..i..".png", z=4}},
			does_block_move = true,
		}	
	elseif i == 87 or i == 88 or i == 89 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_ROOM_"..i,
			image = "terrain/castle_floor/castle_1_floor__1.png",
			add_displays = {class.new{image="terrain/castle_room/castle_1_room_"..i..".png", z=4}},
			does_block_move = true,
		}																
	else
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_ROOM_"..i,
			image = "terrain/castle_room/castle_1_room_"..i..".png",
			z = 3,
			does_block_move = true,
		}		
	end
end

-- 城堡门
for i = 1, 117 do
	if i == 5 or i == 13 or i == 14 or i == 15 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_floor/castle_1_floor__1.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4},
			},			
			does_block_move = false,
		}	
	elseif i == 21 or i == 22 or i == 23 or i == 24 or i == 25 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_floor/castle_1_floor__1.png",
			add_displays = {
				class.new{image = "terrain/castle_wall/castle_1_wall__4.png", z=4},
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=5},
			},					
			does_block_move = false,
		}	
	elseif i == 28 or i == 29 or i == 30 or i == 31 or i == 32 or i == 33 or i == 34 or i == 35 or i == 36 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_wall/castle_1_wall__11.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4},
			},					
			does_block_move = false,
		}
	elseif i == 37 or i == 38 or i == 39 or i == 40 or i == 41 or i == 42 or i == 43 or i == 44 or i == 45 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_wall/castle_1_wall__18.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4},
			},					
			does_block_move = false,
		}	
	elseif i == 46 or i == 55 or i == 64 or i == 73 or i == 82 or i == 54 or i == 63 or i == 72 
		or i == 81 or i == 90 or i == 47 or i == 53 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_wall/castle_1_wall__25.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4},
			},					
			does_block_move = false,
		}	
	elseif i == 91 or i == 99 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_wall/castle_1_wall__32.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4},
			},					
			does_block_move = false,
		}
	elseif i == 100 or i == 108 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_floor/castle_1_floor__1.png",
			add_displays = {
				class.new{image = "terrain/castle_wall/castle_1_wall__39.png", z=4},
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=5}
			},					
			does_block_move = false,
		}	
	elseif i == 109 or i == 110 or i == 111 or i == 115 or i == 116 or i == 117 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image="terrain/grass_worldmap/grass_main_01.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4}
			},					
			does_block_move = false,
		}	
	elseif i == 112 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_floor/castle_1_floor__3.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4}
			},					
			does_block_move = false,
		}
	elseif i == 113 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_floor/castle_1_floor__4.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4}
			},					
			does_block_move = false,
		}
	elseif i == 114 then
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_floor/castle_1_floor__5.png",
			add_displays = {
				class.new{image = "terrain/castle_door/castle_1_building__"..i..".png", z=4}
			},					
			does_block_move = false,
		}																						
	else
		newEntity{ 
			base = "ROOM", 
			define_as = "CASTLE_1_BUILDING_"..i,
			image = "terrain/castle_door/castle_1_building__"..i..".png",
			z = 3,
			does_block_move = false,
		}
	end
end


