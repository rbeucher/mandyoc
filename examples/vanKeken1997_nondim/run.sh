touch FD.in
nohup /Users/victorsacek/Documents/petsc/arch-label-debug/bin/mpirun -n 4 ./mandyoc -denok 1.0e-15 -particles_per_ele 1000 -theta_FSSA 0.5 -sub_division_time_step 1.0 -visc_harmonic_mean 0 -particles_perturb_factor 0 -visc_const_per_element 1 -direct_solver 0  <FD.in >FD.out &
