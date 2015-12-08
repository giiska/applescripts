tell application "Evernote"
  set myNote to (find note (system attribute "SAVE_CHROME_TAB_TO_EVERNOTE_ID")) -- returns a list of notes
  get (title) of myNote
  --tell myNote to append text ""
end tell