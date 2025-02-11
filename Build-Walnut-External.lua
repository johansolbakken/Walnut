-- WalnutExternal.lua

VULKAN_SDK = os.getenv("VULKAN_SDK")

IncludeDir = {}
IncludeDir["VulkanSDK"] = "%{VULKAN_SDK}/include"
IncludeDir["glm"] = "../vendor/glm"
IncludeDir["spdlog"] = "../vendor/spdlog/include"

LibraryDir = {}
LibraryDir["VulkanSDK"] = "%{VULKAN_SDK}/lib"

Library = {}

filter "system:windows"
    -- On Windows, link the static or import lib, typically "vulkan-1.lib"
    Library["Vulkan"] = "%{LibraryDir.VulkanSDK}/vulkan-1.lib"

filter "system:macosx"
    -- On macOS, link against the Vulkan loader. Typically you want .dylib:
    -- (You can also just set this to "vulkan" and rely on standard library 
    -- search paths, but using the explicit .dylib is safest if it lives in VULKAN_SDK/lib).
    Library["Vulkan"] = "%{LibraryDir.VulkanSDK}/vulkan.1"

filter {}

group "Dependencies"
   include "vendor/imgui"
   include "vendor/glfw"
   include "vendor/yaml-cpp"
group ""

group "Core"
    include "Walnut/Build-Walnut.lua"

    -- Optional modules
    if os.isfile("Walnut-Modules/Walnut-Networking/Build-Walnut-Networking.lua") then
        include "Walnut-Modules/Walnut-Networking/Build-Walnut-Networking.lua"
    end
group ""
