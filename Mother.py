import subprocess
import commands
import main
import sys
import os
import multiprocessing as mp
import time
import subprocess
#This is the main script that will call upon other (cshell and python) scripts.
#Execute by: python Mother.py pdb.file Map.map


os.system("rm -r Grids/") #Gets rid of folder containing the grid.pdb files from a previous run.
#Function is defined which will call on a cshell script that will execute phenix.real_space_refine to compare various sub grid.pdb files.
#The argument to feed it will be the name of the sub pdb file created further down in this script.
def phenix(Archivo):
	retval = os.getcwd()
        os.system("./run_phenix.csh "+str(Archivo)+" "+str(sys.argv[1]))
       
#Everything below is self explanatory. The following lines asks the user for input values.
print "How many different vertices separations will you like to create? Integer only."
sizes=int(raw_input(""))
print " "
print "Please insert the different values of these spacing."
spacing=[0]*sizes
for A in range(0,sizes):
	spacing[A]=float(raw_input("Insert value number "+str(A+1)+" here-->"))
print " "
print "Please insert the fraction removal step as a fraction (e.g. 0.1) (up to two decimal places)."
frac_step=int(float(raw_input("Insert value here-->"))*1000.0) #The fraction is converted into an integer for a following range function to work.
print " "
print "Please insert the starting fraction removal (up to two decimal places)."
frac_init=int(float(raw_input("Insert value here-->"))*1000.0) #The fraction is converted into an integer for a following range function to work.
print " "
print "Please insert the ending fraction removal (up to two decimal places)."
frac_end=int(float(raw_input("Insert value here-->"))*1000.0) #The fraction is converted into an integer for a following range function to work.
print " "
print "How many cores would you like to use to accelarate phenix.get_cc_mtz_map map.mtz grid.pdb"
cores=int(raw_input("Insert number of cores here-->")) #These cores will be devoted to only process exectued once every loop thriugh X (below).
print " "
print "What is the inital deletion radius?"#Initial deletion radius
ini_radius=float(raw_input("Insert value here--->"))
print " "
print "Density will be removed from the map around the Grid.pdb atoms in steps of N angstroms from initial radius to half voxel spacing size."
radius_step=float(raw_input("Please input the N angstroms stepping size here--->"))#STepping size for deletion ratio.
print " "
raw_input("Hit enter to continue.")
print " "




#Just deleting files from a possible previous run of Mother.py
os.system("rm all_cc_mtz_pdb.log")
os.system("rm -r Grids/")
os.system("mkdir Grids/")
#The loop X will controll the creation of the main grid.pdb split it up and will call on the function stated above to process them individualy. 
for X in range(0,sizes):
	os.system("rm shaped_output.pdb")
	main.construct(sys.argv[1],spacing[X]) #This will call on another python script (main.py) that was imported at the begining of this script. 
	FILE = open("output.pdb",'r') # Reads the output.pdb file created from main.py
        lines = FILE.readlines() #Loads lines into a list.
        FILE.close() #Closes the open file.
        length = len(lines) #get the length.
        del lines #deletes the parameter.
        del FILE #deletes the parameter.
        longitud = int(float(length/cores)) #Gets the number of lines that each sub output.pdb file should cotain. 
        os.system("split -dl "+str(longitud)+" output.pdb output-") #Through cshell command will split output.pdb file in n=cores files
        lista = range(cores) #creates a list of ints from 0 to cores.
        lista_numerica = ["{:02d}".format(x) for x in lista] #creates list from 0 to cores in a double digit format e.g. 00 or 12 or 02
        lista_archivos = ["output-"+S for S in lista_numerica] #adds a prefix to the the list above.
        del lista #deletes parameter.
        del lista_numerica #deletes parameter.
	if __name__ == '__main__': #this is just used as trick. __name__ should equal __main__ here because the script were we ask for the value of __name__ is the principal script executed.
		p = mp.Pool(cores) #function to create reserverd memory.
        	p.map(phenix,lista_archivos) #maps one function with various diferent arguments. This will create parallelization of the code.
        del lista_archivos #deletes parameter.
	p.close() # closes the usage of multiple cores
	p.join() # waits on all cores to be done
	os.system("cat temp_output-*/cc_modified.log > cc_modified.log") #Calls on all cc_modified.log file from with each temp_out folder to be copied to a mother file.
        os.system("cat temp_output-*/all_cc_mtz_pdb.log > all_cc_mtz_pdb.log") #similar to above.
        os.system("rm -r temp_output-*/") # removes uncessary folders cotaining files.
        os.system("rm output-*") #removes all sub output.pdb files.
        os.system("awk '(NR>1) && ($5>=0)' cc_modified.log > strong.log") #extracts only the atoms from the main grid.pdb file to creates a grid shaped as the pdb file provided in the execution of this script.
        os.system("awk '{print $2}' strong.log > numbers.log") #extracts the number identifiator of the atom.
        os.system("awk '{print $3}' strong.log > letters.log") #extract the letter (chain) identificator of the atom. 
        os.system("python extract_low_threshhold.py") #call on another python script through the command line ().
        os.system("mv output.pdb entire_output.pdb") #changes the name of the main output.pdb file for it to be conserved I MADE A CHANGE HERE. 
        os.system("mv modeled.pdb shaped_output.pdb") #chnage name of modeled.pdb .
        os.system("cp shaped_output.pdb remain.pdb") #creates a copy with different name.
        print "DONE WITH CONSTRUCTION..."
        print " "
	#	Now the loop that controlls the removal of a fraction of the atoms in the shaped grid pdb starts
	for Y in range(frac_init,frac_end,frac_step):
		y=(float(Y)/1000) 
		main.separate(y,(float(frac_step)/1000)) #All these values need to be passed on into the function as fraction.
		n_radius=int(((spacing[X]/2)-ini_radius)/radius_step)#Calculates how many iterations are needed to reach hald spacing with the raius stepping from the inital radius.
		for Z in range(0,(n_radius+1)): #This loop will control the deletion radius for the phenix.remove_density found inside another function off from this script.
			rad = (ini_radius+(Z*radius_step)) 
			print "Radius: "+str(rad)
			print "Voxel spacing: "+str(spacing[X])
			print "Fraction: "+str(y)
			print " "
			os.system("./main_tcsh.csh "+str(rad)+" "+str(y)+" "+str(spacing[X])+" "+str(sys.argv[1])+" "+str(sys.argv[2])) #Calls on the cshell script responsible for the calculations of CC and Real Space refine.
			print " "
		os.chdir("Grids/")
		os.system("mkdir "+str(spacing[X])+"_"+str(y)) #creates new folder within Grids
		os.chdir("../")
		os.system("cp remain.pdb Grids/"+str(spacing[X])+"_"+str(y)+"/")#We save the fractionally different shpaed grid.pdb files.
		os.system("cp remove.pdb Grids/"+str(spacing[X])+"_"+str(y)+"/")
