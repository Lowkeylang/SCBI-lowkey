UpdatesLog = {
    "\n\nVersion : 1\n- Default version",
}

if ScriptVersion == #UpdatesLog then
else
    ChangeLog = "✅ New version Avilable ✅\n"
    ChangeLog = ChangeLog.."Current Version : "..ScriptVersion.."\n"
    ChangeLog = ChangeLog.."Latest Version : "..#UpdatesLog

    LoopChangeLog = #UpdatesLog

    while ScriptVersion  <  LoopChangeLog do
        ChangeLog = ChangeLog..UpdatesLog[LoopChangeLog]
        LoopChangeLog = LoopChangeLog - 1
    end
	gg.alert(ChangeLog, "Get Link")
    gg.setVisible(false)
  --  gg.copyText("https://t.me/Hackers_House_YT")

end
