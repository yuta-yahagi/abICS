#!/bin/sh
#SBATCH -p F144cpu #パーティションを指定
#SBATCH -N 144
#SBATCH -n 9216
#SBATCH -J spinel
#SBATCH -c 2
#SBATCH --time=3:00:00

# The VASP calculations are now submitted through AiiDA.  Configure the code and
# potential family by exporting ``AIIDA_VASP_CODE`` and
# ``AIIDA_VASP_POTENTIAL_FAMILY`` (and optionally ``AIIDA_VASP_POTENTIAL_MAP``)
# before running this script, or pass explicit command line options to
# ``aiida_run``.

# Run reference DFT calc.
#module purge
#module load intel_compiler/2019.5.281
#module load openmpi/4.0.4-intel-2019.5.281

for i in {1..3} # 2 runs set in baseinput
do
    srun -n 15  abics_mlref input.toml >> abics_mlref.out
    sh parallel_run.sh
done

srun -n 15 abics_mlref input.toml >> abics_mlref.out

#train
module purge
module load intel_compiler/2020.2.254  
module load intel_mpi/2020.2.254
abics_train input.toml >> abics_train.out
