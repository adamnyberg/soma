#!/usr/local/bin/expect

spawn "~/soma/puzzles/server"

send "P\r"
expect "Ange en ny port:"
send "3333\r"

send "F"
expect "Ange nytt filnamns prefix:"
send "soma_\r"

send "I"
send "S"
send "T"

interact
