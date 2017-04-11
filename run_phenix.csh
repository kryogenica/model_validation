#! /bin/csh -f
rm -r temp_$1 
mkdir temp_$1 
cd temp_$1
rksystem2
/opt/X-tal_suite/phenix-1.11.1-2575/build/bin/phenix.get_cc_mtz_pdb ../$2.mtz pdb_in=../$1 scale=True fix_xyz=True > all_cc_mtz_pdb.log
awk '/MEAN DENSITY/ {p=1;next}p' cc.log > temp1
sed -i '1d' temp1
tac temp1 > temp2
awk '/Summary of fit of model to map/ {p=1;next}p' temp2 > temp1
sed -i '1,4d' temp1
tac temp1 > cc_modified.log
rm temp1 temp2
cd ../







