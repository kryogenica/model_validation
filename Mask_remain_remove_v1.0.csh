#! /bin/csh -f

set map = ../$1
set radius = $2

#########################################################################
## DO NOT MODIFY LINES BELOW THIS SECTION UNLESS  YOU KNOW WHAT YOU'RE DOING

#  get information about the map:
/opt/X-tal_suite/Uppsala/rave_linux/lx_mapman << eol > lx_mapman_info.log
re m1 $map ccp4
list
quit
eol

set cell = `grep "Cell dimensions" lx_mapman_info.log | awk '{print $4 " " $5 " " $6 " " $7 " " $8 " " $9}'`
set extent = `grep "Number of columns" lx_mapman_info.log | awk '{print $7}'`
set grid = `grep "Number of columns" lx_mapman_info.log | awk '{print $7}'`
set Origin = `grep "Origin      =" lx_mapman_info.log | awk '{print $3}'`

#  create a mask
/opt/X-tal_suite/Uppsala/rave_linux/lx_mama << eol > lx_mama.log    
new grid $grid $grid $grid 
new cell $cell 
new ori  $Origin $Origin $Origin
new extent $grid $grid $grid
new radius $radius
new pdb m1 ../remove.pdb
new grid $grid $grid $grid 
new extent $grid $grid $grid
new copy m2 m1
write m2 remove.mask 
not m2
write m2 remain.mask
list
quit
Y
eol

/opt/X-tal_suite/Uppsala/rave_linux/lx_mapman << eol > lx_mapman_mask.log
re m1 $map ccp4
re m2 remove.mask mask
oper m1 * m2
write m1 map_removed.ccp4 ccp4
write m2 remove.ccp4 ccp4
de m1
de m2
re m1 $map ccp4
re m2 remain.mask mask
oper m1 * m2
write m1 map_remain.ccp4 ccp4
quit
eol
