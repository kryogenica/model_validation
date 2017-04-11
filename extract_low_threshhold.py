import numpy as np
import sys
import os
import time

os.system("rm modeled.pdb")

Num = open("numbers.log",'r')
numbers = Num.readlines()
Num.close()


Let = open("letters.log",'r')
letters = Let.readlines()
Let.close()



original = open("output.pdb",'r')
lines = original.readlines()
original.close()

print "Number of Atoms in the grid:"
print str(len(lines))
print "Number of Atoms inside map's density to be extracted:"
print str(len(numbers))
print "Atoms extracted from | Total atoms in grid"





Y=len(numbers)
X=len(lines)
z=0
modeled = open('modeled.pdb', 'w+')
for x in range(X-1):
	line = lines[x]
	
	for y in range (Y-1):
		number=numbers[y]
		letter=letters[y]	
		if ((int(line[22:26]) == int(number[0:4])) and (line[21] == letter[0])): 
            		modeled.write(line)
			z=z+1
			sys.stdout.write("\r"+str(z)+" | "+str(len(lines)))
			del numbers[y]
			del letters[y]
			y=Y-1			
	Y=len(numbers)
modeled.close()
sys.stdout.write("\r"+str(z)+" | "+str(len(lines)))
print"\nDone selecting voxels within model PDB"
