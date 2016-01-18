-- source: http://wonderffee.github.io/blog/2015/06/04/improve-evernote-editing-capabilities-in-mac/


set appName to "Evernote"

-- if application appName is running then
tell application id (id of application appName)
  activate
  tell application "System Events"
      keystroke "c" using command down
  end tell
  set selectedText to the clipboard as «class utf8»
  -- the clipboard as "HTML"
  set the clipboard to "<span style=\"color:red;\">" & selectedText & "</span>"
  set theHEX to do shell script "LC_ALL=en_US.UTF-8 pbpaste | hexdump -ve '1/1 \"%.2x\"'"
  if theHEX is "" then
      beep
  else
      run script "set the clipboard to «data HTML" & theHEX & "»"
      tell application "System Events"
          keystroke "v" using {command down}
      end tell
  end if
end tell
-- end if
