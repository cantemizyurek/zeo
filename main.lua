local function print_table(t)
	table.foreach(t, function(k, v)
		print(k, v)
	end)
end

local function find(t, callback)
	local found = nil
	table.foreach(t, function(k, v)
		if callback(v) then
			found = v
		end
	end)
	return found
end

local function filter(t, callback)
	local filtered = {}
	table.foreach(t, function(k, v)
		if callback(v) then
			table.insert(filtered, v)
		end
	end)
	return filtered
end

local function get_distance(c_frame1, c_frame2)
	return (c_frame1.Position - c_frame2.Position).magnitude
end

local function teleport_player(c_frame)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = c_frame
end

local function get_players()
	local players = {}
	table.foreach(game.Players:GetPlayers(), function(k, v)
		if v ~= game.Players.LocalPlayer then
			table.insert(players, v)
		end
	end)
	return players
end

local function get_player_by_name(player_name)
	local players = get_players()
	return find(players, function(v)
		return v.Name == player_name
	end)
end

local function get_player_by_display_name(player_display_name)
	local players = get_players()
	return find(players, function(v)
		return v.DisplayName == player_display_name
	end)
end

local function get_nearest_object_to(c_frame, objects)
	local nearest_object = nil
	local nearest_distance = math.huge

	table.foreach(objects, function(k, v)
		local distance = get_distance(c_frame, v.PrimaryPart.CFrame)
		if distance < nearest_distance then
			nearest_object = v
			nearest_distance = distance
		end
	end)

	return nearest_object
end

local function get_nearest_player_to(c_frame)
	return get_nearest_object_to(c_frame, get_players())
end

local function get_nearest_player()
	return get_nearest_player_to(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
end

local function get_objects_in_radius(c_frame, objects, radius)
	local objects_in_radius = {}
	table.foreach(objects, function(k, v)
		if get_distance(c_frame, v.PrimaryPart.CFrame) <= radius then
			table.insert(objects_in_radius, v)
		end
	end)
	return objects_in_radius
end

local function get_players_in_radius(radius)
	return get_objects_in_radius(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, get_players(), radius)
end

return {
	print_table = print_table,
	find = find,
	filter = filter,
	get_distance = get_distance,
	teleport_player = teleport_player,
	get_players = get_players,
	get_player_by_name = get_player_by_name,
	get_player_by_display_name = get_player_by_display_name,
	get_nearest_object_to = get_nearest_object_to,
	get_nearest_player_to = get_nearest_player_to,
	get_nearest_player = get_nearest_player,
	get_objects_in_radius = get_objects_in_radius,
	get_players_in_radius = get_players_in_radius,
}
