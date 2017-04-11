#! /bin/csh -f
  mkdir REMAIN
  cd REMAIN/
  rksystem2
  phenix.real_space_refine ../../{$1}.pdb ../{$2}  nproc=5 > 1_phenix.refine.realspace_all.log
  mv {$1}_real_space_refined.pdb 1_{$1}_real_space_refined.pdb
  cp 1_phenix.refine.realspace_all.log ../
  cp 1_{$1}_real_space_refined.pdb ../
  cd ../
