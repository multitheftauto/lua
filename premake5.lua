local EXLUCED_FILES = { "src/lua.c", "src/luac.c" }

project "Lua_Server"
	language "C++"
	targetname "lua5.1"

	vpaths { 
		["Headers"] = "**.h",
		["Sources"] = "**.c",
		["*"] = "premake5.lua"
	}
	excludes(EXLUCED_FILES)
	
	files {
		"premake5.lua",
		"src/**.c",
		"src/**.h",
	}
	excludes(EXLUCED_FILES)

	defines { "LUA_BUILD_AS_DLL" }

	filter "system:windows"
		kind "SharedLib"
		targetdir(buildpath("server/mods/deathmatch"))

	filter "system:not windows"
		kind "StaticLib"

	filter {"system:windows", "platforms:x64"}
		targetdir(buildpath("server/x64"))


if os.target() == "windows" then
	project "Lua_Client"
		language "C++"
		kind "SharedLib"
		targetname "lua5.1c"
		targetdir(buildpath("mods/deathmatch"))

		vpaths { 
			["Headers"] = "**.h",
			["Sources"] = "**.c",
			["*"] = "premake5.lua"
		}
		excludes(EXLUCED_FILES)
	
		files {
			"premake5.lua",
			"src/**.c",
			"src/**.h",
		}
		excludes(EXLUCED_FILES)
	
		defines {
			"LUA_USE_APICHECK",
			"LUA_BUILD_AS_DLL"
		}

        filter "platforms:x64"
            flags { "ExcludeFromBuild" } 
end
