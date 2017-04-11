#! /bin/csh -f
  mkdir REMOVED
  cd REMOVED/
  rksystem2
  phenix.real_space_refine ../../{$1}.pdb ../{$2}  nproc=5 > 2_phenix.refine.realspace_all.log
  mv {$1}_real_space_refined.pdb 2_{$1}_real_space_refined.pdb
  cp 2_phenix.refine.realspace_all.log ../
  cp 2_{$1}_real_space_refined.pdb ../
  cd ../
