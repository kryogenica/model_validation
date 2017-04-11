
def genpdb(dist,step):
    output = open('output.pdb', 'w+')
    def spaces(n):
        for x in range(n):
            output.write(' '),

    alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    alphabet2 = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    alphabet3 = ['0','1','2','3','4','5','6','7','8','9']
    index = 1
    alphin1 = 0
    secind = 0
    for x in range(int(dist[1]*10),(int(dist[0]*10)),int(float(step)*10.0)):
        for y in range(int(dist[3]*10),(int(dist[2]*10)),int(float(step)*10.0)):
            for z in range(int(dist[5]*10),(int(dist[4]*10)),int(float(step)*10.0)):
                output.write('ATOM')
                spaces(7-len(str(index)))
                output.write(str(index))
                spaces(2)
                output.write('C')
		output.write('   HOH ')
					
		if ((alphin1//26)==0):
			output.write(alphabet[alphin1])
		else:
			output.write(alphabet2[alphin1-((alphin1//26)*26)])

		spaces(4-len(str(secind)))
                output.write(str(secind))
                spaces(5)
		output.write((str(float(x)/10.0) + '0000000')[0:7])
                spaces(1)
                output.write((str(float(y)/10.0) + '0000000')[0:7])
                spaces(1)
                output.write((str(float(z)/10.0) + '0000000')[0:7])
                spaces(2)
                output.write('1.00')
                spaces(1)
                output.write('20.00')
                spaces(11)
                output.write('C')
                output.write('\n')
                index += 1
                secind += 1
                if secind == 10000:
                    secind = 0
                    alphin1 += 1

    output.write('END')
    output.close()
    print "ChainID: "+(alphabet[alphin1//26])+(alphabet[alphin1-((alphin1//26)*26)])+" Atom number: "+str(alphin1)
