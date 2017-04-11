#! /bin/csh -f
  mkdir FULL
  cd FULL/
  rksystem2
  phenix.real_space_refine ../../{$1}.pdb ../../{$2}  nproc=5 > 0_phenix.refine.realspace_all.log
  mv {$1}_real_space_refined.pdb 0_{$1}_real_space_refined.pdb
  cp 0_phenix.refine.realspace_all.log ../
  cp 0_{$1}_real_space_refined.pdb ../
  cd ../
