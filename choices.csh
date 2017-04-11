#! /bin/csh -f
if ( $1 == 1 ) then
	mkdir hello
	cd hello/
	pwd
	cd ../
else if ( $1 == 2) then
	mkdir bye
	cd bye/
	pwd
	cd ../
endif 

