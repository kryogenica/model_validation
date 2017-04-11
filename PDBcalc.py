def PDB(name):

    mol = open(name,'r')
    from math import floor,ceil
    lines = mol.readlines()
    mol.close()
    xs = []
    ys = []
    zs = []
    N = 0
    for x in range(0,len(lines)):
        line = lines[x]
        if line[0:4] == 'ATOM':
            xs.append(float(line[31:38]))
            ys.append(float(line[39:46]))
            zs.append(float(line[47:54]))
            N = N + 1
    
    print "The number of atoms in the PDB file are: "
    print N
    #print str(max(xs))+" "+str(min(xs))+" "+str(max(ys))+" "+str(min(ys))+" "+str(max(zs))+" "+str(min(zs))
    return  [int(ceil(max(xs))),int(floor(min(xs))),int(ceil(max(ys))),int(floor(min(ys))),int(ceil(max(zs))),int(floor(min(zs)))]
