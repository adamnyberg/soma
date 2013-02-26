#!/bin/bash
§
ssh $1@astmatix.ida.liu.se:~/soma 'git pull --all; git reset --hard origin/master; make; solve'
