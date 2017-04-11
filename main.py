def construct(filename,step):
	# (pdb Angstrom_StepSize)
	import sys
	import PDBcalc
	import GRID
	import os
	import time
	dist = []
	dist = PDBcalc.PDB(filename)#gets the x,y,z location of the most outter atoms in the pdb provided (filename)
	print " "
	print "This are the +x,-x,+y,-y,+z,-z coordinates of the most outward atoms in the PDB provided:"
	print dist
	print " "
	GRID.genpdb(dist,step)#this function generates the grid.pdb
	print " "
	print "Generating PDB shaped voxels....."
	time.sleep(5)
	os.system("rm numbers.log")
	os.system("rm letters.log")
	os.system("rm strong.log")
	os.system("rm cc.log")
	os.system("rm cc_modified.log")

def separate(fraction,fraction_step): #these two agruments need to be fractions
	import Divide
	import sys
	Divide.Divide('shaped_output.pdb',float(fraction),'remain.pdb',float(fraction_step)) #this fucntion will separate in two the main grid.pdb file into the remain and remove.
