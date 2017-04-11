import sys
fasta = open(sys.argv[1],'r')
from random import randrange
acids = ['A','D','E','F','G','H','I','K','L','M','N','Q','R','S','T','V','W','Y']

lines  = fasta.readlines()
for x in range(len(lines)):
    if (lines[x][0] != '>') and (lines[x][0] != ';'):
        for y in range(len(lines[x])-1):
                if lines[x][y] == sys.argv[2]:
                    pass
	        elif lines[x][y] == '.':
		    pass
                else:
                    lines[x]= lines[x][:y] + acids[randrange(0,len(acids)-1)] + lines[x][y+1:]

output = open('output.fasta.txt','w+')


for z in range(len(lines)):
    output.write(lines[z])

output.close()
fasta.close()
