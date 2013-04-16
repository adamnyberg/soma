#!/usr/local/bin/expect

spawn "~/soma/puzzles/server"

send "P\r"
expect "Ange en ny port:"
send "4433\r"

send "F"
expect "Ange nytt filnamns prefix:"
send "comp_\r"

send "S\r"
send "T\r"
send "I"

interact
