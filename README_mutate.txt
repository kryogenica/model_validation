Procedure needs assp and Scwrl4 programs

0. Remove the protons from the PDB:
        phenix.reduce A.pdb -trim > A_noH.pdb
1. Get the amino acid sequence while respecting missing residues:
	assp -i A_noH.pdb -fasta -o Anew.seq
	Remove the top line (seq identifier from file)
2. Mutate residues while keeping Proline (P) unmodified (any amino acid is possible)
	python random_mutate.py Anew.seq P			output is: output.fasta.txt
3. Rename the output:
	mv output.fasta.txt Anew_mut.seq
5. use Scwrl4 to make the mutations (Scwrl4 doesn't like protons)
	Scwrl4 -i A_noH.pdb -s A_mut.seq -o A_mut.pdb
6. Remove the protons from the PDB
	phenix.reduce A_mut.pdb -trim > A_mut_noH.pdb
