local utils = require "mp.utils"
function main(destFolder)
    local fileToMove = string.gsub(mp.get_property("path"), "/home/lucas/", "\\")
    local args = {'mv', fileToMove, destFolder}
	utils.subprocess({args = args, playback_only = false})
	mp.commandv('playlist-remove','current')
end
mp.register_script_message("move-file", main)
