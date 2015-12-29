tell application "Evernote"
  set myNote to (find notes "0000000 this is a read later") -- returns a list of notes
  set myNote to item 1 of myNote -- return one note
  get (notebook) of myNote
  --tell myNote to append text ""
end tell