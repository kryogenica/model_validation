#! /bin/csh -f

#script will run through multipt radii for generating CC-free
# Enter the PDB name without the pdb extension
set PDB = $4:r
set yyy=`expr $2`
set sss=`expr $3`
# Enter the radi

rksystem2

set rad_min=`expr $1`

set rad_max = `echo "$rad_min" | awk '{print ($1 + 1.0)}'`


set rad_inc=2.00

# Set the image reconstruction file
set reconstruction = resultado.mtz 


# DO NOT CHANGE BELOW HERE
# while loop does not handle floats. Therefore all must be changed 
# to integers and back to floats
set rad_i = `echo $rad_min | awk '{print $1*100}'`
set rad_f = `echo $rad_max | awk '{print $1*100}'`
set rad_step = `echo $rad_inc | awk '{print $1*100}'`
set i = 1


while ($rad_i <= $rad_f)
  #make density for CCfree
  set rad = `echo $rad_i | awk '{printf "%3.2f", $1/100}'`
  mkdir calculation-$rad-$sss-$yyy
  cd calculation-$rad-$sss-$yyy/

  # generate densities for CC and CCfree
  echo "Generating the density_remain.mtz and density_remove.mtz for radius $rad"
  .././Mask_remain_remove_v1.0.csh $5 $rad > Masking.log
  phenix.map_to_structure_factors map_remain.ccp4 output_file_name=density_remain.mtz d_min=1.0  > phenix.map_to_structure_factors_remain.log &
  phenix.map_to_structure_factors map_removed.ccp4 output_file_name=density_remove.mtz d_min=1.0  > phenix.map_to_structure_factors_removed.log &

  wait

  # refine pdb against "all" data
  echo "refine pdb against all data"
  # refine pdb against "remain" data
  echo "refine pdb against remain data"
  # refine pdb against "remove" data
  echo "refine pdb against remove data"
  .././run_real_space_refinement_full.csh $PDB $reconstruction &
  .././run_real_space_refinement_remain.csh $PDB density_remain.mtz &
  .././run_real_space_refinement_removed.csh $PDB density_remove.mtz &

  wait

  # calculate CC of pdb refined against "all" data vs "remain" data
  echo "calculate CC of pdb refined against all data vs remain data"
  # calculate CC of pdb refined against "remain" data vs "all" data
  echo "calculate CC of pdb refined against remain data vs all data"
  # calculate CC of pdb refined against "remain" data vs "remain" data
  echo "calculate CC of pdb refined against remain data vs remain data"
  # calculate CC of pdb refined against "remain" data vs "remove" data
  echo "calculate CC of pdb refined against remain data vs remove data"
  # calculate CC of pdb refined against "remove" data vs "remove" data
  echo "calculate CC of pdb refined against remove data vs remove data"
  # calculate CC of pdb refined against "all" data vs "remove" data
  echo "calculate CC of pdb refined against all data vs remove data"
  .././get_cc.csh 1 density_remain.mtz 0_{$PDB}_real_space_refined.pdb $rad_i &
  .././get_cc.csh 2 ../{$reconstruction} 1_{$PDB}_real_space_refined.pdb $rad_i &
  .././get_cc.csh 3 density_remain.mtz 1_{$PDB}_real_space_refined.pdb $rad_i &
  .././get_cc.csh 4 density_remove.mtz 1_{$PDB}_real_space_refined.pdb $rad_i &
  .././get_cc.csh 5 density_remove.mtz 2_{$PDB}_real_space_refined.pdb $rad_i &
  .././get_cc.csh 6 density_remove.mtz 0_{$PDB}_real_space_refined.pdb $rad_i &

  wait

  # go back to the root directory and move to the next increment
  cd ../
  echo " " 
  echo " " 
  set rad_i = `echo $rad_i $rad_step | awk '{print $1 + $2}'`
end
