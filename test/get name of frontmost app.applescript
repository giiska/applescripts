tell application "System Events"
     set activeApp to name of application processes whose frontmost is true
     display dialog activeApp
end tell