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
	self.list = t.list or {}

	-- 网格的宽
	self.w = assert(t.width, "no list width")

	-- 网格的高
	self.h = assert(t.height, "no list height")

	-- 点击单个格子的相应函数
	self.fct = t.fct

	-- 鼠标停留在单个格子上的选中相应函数
	self.on_select = t.on_select	

	-- 开始拖拽相应函数
	self.on_drag = t.on_drag	

	-- 拖拽结束相应函数
	self.on_drag_end = t.on_drag_end

	-- 单个格子的大小
	self.item_frame_size = t.item_frame_size or 48

	-- 物品图标与边框的间隔
	self.item_icon_margin = 1

	-- 格子列间距、行间距
	self.column_spacing, self.row_spacing = 1, 1	

	-- 滚动条
	self.scrollbar = t.scrollbar
	self.scroll_inertia = 0
	
	-- 选中物品时的边框
	self.item_selected_bg = self:getUITexture("ui/equipdoll/itemframe-sel48.png")		

	-- 未选中时的边框
	self.item_bg = self:getUITexture("ui/equipdoll/itemframe48.png")	

	-- 基类初始化
	Base.init(self, t)
end

function _M:generate()
	-- 生成滚动条
	if self.scrollbar then 
		self.scrollbar = Slider.new{
			size = self.h, 
			max = 1
		} 
	end	

	-- 计算默认列
	-- if self.scrollbar then
	-- 	self.column = math.floor((self.w -  self.scrollbar.w) 
	-- 		/ (self.item_frame_size + self.column_spacing))
	-- else
		self.column = math.floor(self.w 
			/ (self.item_frame_size + self.column_spacing))
	-- end

	-- 计算默认行
	self.row = math.floor(self.h 
		/ (self.item_frame_size + self.row_spacing))

	-- 计算显示物品图标的大小
	self.item_icon_size = self.item_frame_size - self.item_icon_margin * 2

	-- 生成网格数据
	self:generateGrid()

	-- 设置鼠标键盘事件
	self:setupInput()

	self:onSelect()
end

function _M:setupInput()
	self.mouse:reset()
	self.key:reset()

	self.mousezones = {}

	local on_mouse = function(button, x, y, xrel, yrel, bx, by, event)
		if button == "wheelup" and event == "button" then 
			if self.scrollbar then 
				self.scroll_inertia = math.min(self.scroll_inertia, 0) - 5 
			end
		elseif button == "wheeldown" and event == "button" then 
			if self.scrollbar then 
				self.scroll_inertia = math.max(self.scroll_inertia, 0) + 5 
			end
		end

		local done = false
		for i = 1, #self.mousezones do
			local mousezone = self.mousezones[i]
			if x >= mousezone.x1 
				and x <= mousezone.x2 
				and y >= mousezone.y1 
				and y <= mousezone.y2 then
				--鼠标停在格子上
				if not self.last_mousezone 
					or mousezone.item ~= self.last_mousezone.item then
					self:onSelect(mousezone.item)
				end

				--左右键点击
				if event == "button" 
					and (button == "left" or button == "right") then
					self:onUse(mousezone.item, button, event)
				end

				--拖拽
				if event == "motion" and button == "left" and self.on_drag then 
					self.on_drag(mousezone.item) 
				end
				if button == "drag-end" and self.on_drag_end then 
					self.on_drag_end(mousezone.item) 
				end		

				self.last_mousezone = mousezone
				self.sel_i = mousezone.i
				self.sel_j = mousezone.j
				done = true
				break
			end
		end
		if not done then game.tooltip_x = nil self.last_mousezone = nil end		
	end

	self.mouse:registerZone(0, 0, self.w, self.h, on_mouse)
	
	self.key:addBinds{
	}

	self.key:addCommands{
	}
end

function _M:onUse(item, button, event)
	if not item then 
		return 
	end
	self:sound("button")

	if self.fct then
		self.fct(item, button, event)
	end
end

function _M:onSelect(item)
	if not item then 
		return 
	end

	if self.on_select then
		self.on_select(item)
	end
end

function _M:generateGrid()
	-- 计算实际物品占的行数
	local row = math.ceil(#self.list / self.column)
	if row > self.row then
		self.row = row
	end

	self.sel_i = 1
	self.sel_j = 1
	self.max_h = self.row * self.item_frame_size 
						+ (self.row - 1) * self.row_spacing

	-- 计算滚动条的实际高
	if self.scrollbar then
		self.scrollbar.max = self.max_h - self.h
		self.scrollbar.pos = 0
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
	offset_x = offset_x or 0

	self.last_display_bx = x
	self.last_display_by = y
	self.last_display_x = screen_x
	self.last_display_y = screen_y

	-- 计算滚动条位置
	if self.scrollbar then
		self.scrollbar.pos = util.minBound(self.scrollbar.pos 
			+ self.scroll_inertia, 0, self.scrollbar.max)
		if self.scroll_inertia > 0 then 
			self.scroll_inertia = math.max(self.scroll_inertia - 1, 0)
		elseif self.scroll_inertia < 0 then 
			self.scroll_inertia = math.min(self.scroll_inertia + 1, 0)
		end
		if self.scrollbar.pos == 0 or self.scrollbar.pos == self.scrollbar.max then 
			self.scroll_inertia = 0 
		end
	end	

	local mousezones = {}
	self.mousezones = mousezones	
	local dx, dy = 0, -self.scrollbar.pos

	core.display.glScissor(true, screen_x, screen_y, self.w, self.h)

	if self.last_mousezone then
		if self.focused then
			self.item_selected_bg.t:toScreenPrecise(x + self.last_mousezone.x1, 
				y + self.last_mousezone.y1, self.item_frame_size, 
				self.item_frame_size, 0, 
				self.item_selected_bg.w / self.item_selected_bg.tw, 0, 
				self.item_selected_bg.h / self.item_selected_bg.th)					
		end
	end	

	-- 绘制网格
	for i = 1, #self.grid do
		local row = self.grid[i]
		for j = 1, self.column do
			-- 绘制背景及边框
			self.item_bg.t:toScreenPrecise(dx + x, dy + y, self.item_frame_size, 
				self.item_frame_size, 0, self.item_bg.w / self.item_bg.tw, 0, 
				self.item_bg.h / self.item_bg.th)

			-- 绘制物品icon
			if row[j] ~= nil then
				row[j].object:toScreen(nil, dx + x + self.item_icon_margin, 
					dy + y + self.item_icon_margin, self.item_icon_size, 
					self.item_icon_size)

				row[j].last_display_x = screen_x
				row[j].last_display_y = screen_y + self.max_h

				mousezones[#mousezones + 1] = {
					i = i, j = j, item = row[j], x1 = dx, y1 = dy, 
					x2 = dx + self.item_frame_size, 
					y2 = dy + self.item_frame_size
				}
			end

			dx = dx + self.item_frame_size + self.column_spacing
		end

		dy = dy + self.item_frame_size + self.row_spacing
		dx = 0

		if dy >= self.h then 
			break 
		end
	end	

	core.display.glScissor(false)

	-- 绘制滚动条
	if self.focused and self.scrollbar and self.max_h > self.h then
		self.scrollbar:display(x + self.w - self.scrollbar.w, y)
	end	
end