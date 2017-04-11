def Divide(name,frac,remain_file,frac_step):
    import random
    import os
    import sys
    
    original = open(name,'r')
    lines = original.readlines()
    original.close()
    numlines = len(lines)
    print "Number of Voxels:"
    print numlines
    takeout = int(round(frac_step * numlines))
    print "Number of Voxels to remove:"
    print int(round(frac * numlines))
    del original #Clear Variable
    del lines #Clear Variable
    original = open(remain_file,'r')
    lines = original.readlines()
    original.close()
    remove = open('remove.pdb', 'ab')
    for x in range(takeout):
	index = random.randrange(0,len(lines))
        line = lines[index]
        remove.write(line)
        del lines[index]

    remove.close()
    remain = open('remain_temp.pdb','w+')
    print "Number of remaining Voxels:"
    print len(lines)
    for x in (lines):
        remain.write(x)
    remain.close()
    os.system("rm remain.pdb")
    os.system("mv remain_temp.pdb remain.pdb")
