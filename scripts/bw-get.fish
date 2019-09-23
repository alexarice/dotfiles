#!/usr/bin/env fish
mkdir -p /home/alex/.config/bitwarden

set i true

while $i
   set j (bw get password $argv[1] --session (cat /home/alex/.config/bitwarden/session) 2> /dev/null)

   if test $status -eq 1
      bw unlock --raw > /home/alex/.config/bitwarden/session
   else
      echo $j
      set i false
   end
end
