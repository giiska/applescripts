tell application "System Events"

  set activeApp to name of application processes whose frontmost is true
  --Don't execute when active window is not Evernote
  if (activeApp as string) is not equal to "Evernote" then
      error number -128
  end if

  repeat 5 times
    --delay 0.1
    keystroke "+" using command down
  end repeat
  keystroke "b" using command down
end tell