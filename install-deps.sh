#!/bin/sh
#     _            __        ____          __               
#    (_)___  _____/ /_____ _/ / /     ____/ /__  ____  _____
#   / / __ \/ ___/ __/ __ `/ / /_____/ __  / _ \/ __ \/ ___/
#  / / / / (__  ) /_/ /_/ / / /_____/ /_/ /  __/ /_/ (__  ) 
# /_/_/ /_/____/\__/\__,_/_/_/      \__,_/\___/ .___/____/  
#                                            /_/            

cmd="trizen -S"
$cmd $(cat deps.lst)
