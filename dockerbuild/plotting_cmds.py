#!/usr/bin/env python3

import os

gtk_install_dir = "/opt/src/gmsvtoolkit/gmsvtoolkit"
test_dir="/opt/src/gmsvtoolkit/gmsvtoolkit/tests/ref_data"
out_dir = "/home/gtkuser/target"

cmd = "%s/metrics/rotdxx.py --station-list %s/metrics/nr_v19_06_2_3_stations.stl --output-dir %s/sample_output --input-dir %s/metrics"%(gtk_install_dir,test_dir,out_dir,test_dir)
print("Running: ", cmd)
os.system(cmd)

cmd = "%s/plots/plot_rotdxx.py --station-list %s/metrics/nr_v19_06_2_3_stations.stl --output-dir %s/sample_output --labels \"NR\",\"100000\" --comp-label \"NR_100000\" %s/obs %s/sample_output"%(gtk_install_dir,test_dir,out_dir,test_dir,out_dir)
print("Running: ", cmd)
os.system(cmd)

exit(0)

cmd = "%s/stats/psa_gof.py --src %s/sample/nr-gp-0000.src --station-list %s/sample/n_v19_06_2_3_stations.stl --comp-label \"NR-10000000\" --max-cutoff 120 --output-dir %s/sample_output --sims-dir %s/sample_output --obs-dir %s/sample_obs"%(gtk_install_dir,gtk_install_dir,gtk_install_dir,out_dir,gtk_install_dir)
print("Running: ", cmd)
os.system(cmd)

cmd="%s/plots/plot_gof.py --output-dir %s/sample_output --comp-label \"NR-10000000\" --max-cutoff 120 --title \"GoF Comparison between N and simulation 10000000\" --input-dir %s/sample_output"%(gtk_install_dir,out_dir,out_dir)
print("Running: ", cmd)
os.system(cmd)

cmd="%s/plots/plot_dist_gof.py --output-dir %s/sample_output --comp-label \"NR-10000000\" --title \"GoF Comparison between N and simulation 10000000\" --input-dir %s/sample_output"%(gtk_install_dir,out_dir,out_dir)
print("Running: ", cmd)
os.system(cmd)

cmd="%s/plots/plot_map_gof.py --output-dir %s/sample_output --comp-label \"NR-10000000\" --title \"GoF Comparison between NR and simulation 10000000\" --input-dir %s/sample_output --station-list %s/sample/nr_v19_06_2_3_stations.stl --src-file `pwd'/sample/nr-gp-0000.src"%(gtk_install_dir,out_dir,out_dir,gtk_install_dir)
print("Running: ", cmd)
os.system(cmd)



exit(0)
