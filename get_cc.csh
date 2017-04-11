#! /bin/csh -f
rksystem2
set scale='True'
set fix_xyz='True'
if ( $1 == 1 ) then
	mkdir 111
	cd 111/
	phenix.get_cc_mtz_pdb ../$2 ../$3 scale=$scale fix_xyz=$fix_xyz > phenix.get_cc_mtz_pdb_allVSremain.log
	set ALL = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($4*$4); n++ } END { if (n > 0) print sum / n; }'`
	set MC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($5*$5); n++ } END { if (n > 0) print sum / n; }'`
	set SC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($6*$6); n++ } END { if (n > 0) print sum / n; }'`
	mv cc.log phenix.get_cc_mtz_pdb_allVSremain_cc.log
	echo "ALL $ALL MC $MC SC $SC" >> phenix.get_cc_mtz_pdb_allVSremain_cc.log
	echo "$4 $ALL $MC $SC" > phenix.get_cc_mtz_pdb_allVSremain_cc_values.log
	cd ../
	mv 111/* .
	rm -r 111/
else if ( $1 == 2 ) then
	mkdir 222
	cd 222/
	phenix.get_cc_mtz_pdb ../$2 ../$3 scale=$scale fix_xyz=$fix_xyz > phenix.get_cc_mtz_pdb_remainVSall.log
	set ALL = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($4*$4); n++ } END { if (n > 0) print sum / n; }'`
  	set MC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($5*$5); n++ } END { if (n > 0) print sum / n; }'`
  	set SC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($6*$6); n++ } END { if (n > 0) print sum / n; }'`
  	mv cc.log phenix.get_cc_mtz_pdb_remainVSall_cc.log
  	echo "ALL $ALL MC $MC SC $SC" >> phenix.get_cc_mtz_pdb_remainVSall_cc.log
  	echo "$4 $ALL $MC $SC" > phenix.get_cc_mtz_pdb_remainVSall_cc_values.log
	cd ../
	mv 222/* .
	rm -r 222/
else if ( $1 == 3 ) then
	mkdir 333
	cd 333/
	phenix.get_cc_mtz_pdb ../$2 ../$3 scale=$scale fix_xyz=$fix_xyz > phenix.get_cc_mtz_pdb_remainVSremain.log
	set ALL = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($4*$4); n++ } END { if (n > 0) print sum / n; }'`
	set MC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($5*$5); n++ } END { if (n > 0) print sum / n; }'`
	set SC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($6*$6); n++ } END { if (n > 0) print sum / n; }'`
	mv cc.log phenix.get_cc_mtz_pdb_remainVSremain_cc.log
	echo "ALL $ALL MC $MC SC $SC" >> phenix.get_cc_mtz_pdb_remainVSremain_cc.log
	echo "$4 $ALL $MC $SC" > phenix.get_cc_mtz_pdb_remainVSremain_cc_values.log
	cd ../
	mv 333/* .
	rm -r 333/
else if ( $1 == 4 ) then
	mkdir 444
	cd 444/
	phenix.get_cc_mtz_pdb ../$2 ../$3 scale=$scale fix_xyz=$fix_xyz > phenix.get_cc_mtz_pdb_remainVSremoved.log
	set ALL = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($4*$4); n++ } END { if (n > 0) print sum / n; }'`
	set MC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($5*$5); n++ } END { if (n > 0) print sum / n; }'`
	set SC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($6*$6); n++ } END { if (n > 0) print sum / n; }'`
	mv cc.log phenix.get_cc_mtz_pdb_remainVSremoved_cc.log
	echo "ALL $ALL MC $MC SC $SC" >> phenix.get_cc_mtz_pdb_remainVSremoved_cc.log
	echo "$4 $ALL $MC $SC" > phenix.get_cc_mtz_pdb_remainVSremoved_cc_values.log
	cd ../
	mv 444/* .
	rm -r 444/
else if ( $1 == 5 ) then
	mkdir 555
	cd 555/
	phenix.get_cc_mtz_pdb ../$2 ../$3 scale=$scale fix_xyz=$fix_xyz > phenix.get_cc_mtz_pdb_remainVSremain.log
	set ALL = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($4*$4); n++ } END { if (n > 0) print sum / n; }'`
	set MC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($5*$5); n++ } END { if (n > 0) print sum / n; }'`
	set SC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($6*$6); n++ } END { if (n > 0) print sum / n; }'`
	mv cc.log phenix.get_cc_mtz_pdb_remainVSremain_cc.log
	echo "ALL $ALL MC $MC SC $SC" >> phenix.get_cc_mtz_pdb_remainVSremain_cc.log
	echo "$4 $ALL $MC $SC" > phenix.get_cc_mtz_pdb_remainVSremain_cc_values.log
	cd ../
	mv 555/* .
	rm -r 555/
else if ( $1 == 6 ) then
	mkdir 666
	cd 666/
	phenix.get_cc_mtz_pdb ../$2 ../$3 scale=$scale fix_xyz=$fix_xyz > phenix.get_cc_mtz_pdb_allVSremoved.log
	set ALL = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($4*$4); n++ } END { if (n > 0) print sum / n; }'`
	set MC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($5*$5); n++ } END { if (n > 0) print sum / n; }'`
	set SC = `grep -A 10000 "RESIDUE           CC       ALL     MAIN     SIDE" cc.log | grep -B 10000 "Summary of fit" | grep -v RESIDUE | awk '{ sum += sqrt($6*$6); n++ } END { if (n > 0) print sum / n; }'`
	mv cc.log phenix.get_cc_mtz_pdb_allVSremoved_cc.log
	echo "ALL $ALL MC $MC SC $SC" >> phenix.get_cc_mtz_pdb_allVSremoved_cc.log
	echo "$4 $ALL $MC $SC" > phenix.get_cc_mtz_pdb_allVSremoved_cc_values.log
	cd ../
	mv 666/* .
	rm -r 666/
else
	echo "No match for phenix.get_cc_mtz_pdb type."
endif







