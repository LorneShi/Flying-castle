-- TE4 - T-Engine 4
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

require "engine.class"
local Base = require "engine.ui.Base"
local Focusable = require "engine.ui.Focusable"
local Slider = require "engine.ui.Slider"

module(..., package.seeall, class.inherit(Base, Focusable))

function _M:init(t)
	-- 物品数据
	self.list = t.list

	-- 列
	self.column = t.column or 10

	-- 行
	self.row = t.row or 10

	-- 格子宽、高
	self.item_frame_size = 48

	-- 物品图标与边框的间隔
	self.item_icon_margin = 1

	-- 格子列间距、行间距
	self.column_spacing, self.row_spacing = 1, 1

	-- 基类初始化
	Base.init(self, t)
end

function _M:generate()
	-- 显示物品的宽、高
	self.item_icon_size = self.item_frame_size - self.item_icon_margin

	-- 未选中时物品的背景及边框
	self.item_bg = self:getUITexture("ui/equipdoll/itemframe48.png")

	-- 生成网格数据
	self:generateGrid()
end

function _M:generateGrid()
	-- 计算实际物品占的行数
	local row = math.ceil(#self.list / self.column)
	if row > self.row then
		self.row = row
	end

	-- 生成网格数据
	self.grid = {}
	local grid = self.grid
	for i = 1, self.row do
		local row = {}
		for j = 1, self.column do
			row[#row + 1] = self.list[(i - 1) * self.column + j]
		end
		grid[#grid + 1] = row
	end	
end

function _M:setList(list)
	self.list = list
	self:generateGrid()
end

function _M:display(x, y, nb_keyframes, screen_x, screen_y, offset_x, offset_y, local_x, local_y)
	-- 绘制格子
	local dx, dy = 0, 0
	for i = 1, #self.grid do
		local row = self.grid[i]
		for j = 1, self.column do
			-- 绘制背景及边框
			self.item_bg.t:toScreenPrecise(dx + x, dy + y, 
				self.item_icon_size, self.item_icon_size, 0, 
				self.item_bg.w / self.item_bg.tw, 0, 
				self.item_bg.h / self.item_bg.th)

			-- 绘制物品icon
			if row[j] ~= nil then
				row[j]:toScreen(nil, dx + x, dy + y, self.item_icon_size, self.item_icon_size)
			end

			dx = dx + self.item_frame_size + self.column_spacing
		end

		dy = dy + self.item_frame_size + self.row_spacing
		dx = 0
	end
end