#!/usr/bin/env bash
#SBATCH -J pilon
#SBATCH --partition=long
#SBATCH --mem=60G
#SBATCH --cpus-per-task=16

# Align raw reads to a pacbio assembly and then use this alignmeant to correct
# indels and substitutions in the assembly.

Mem="47G"
#Mem="70G"
# Mem="372G"
Threads=28

# ---------------
# Step 1
# Collect inputs
# ---------------

Assembly=$(basename $1)
Read_F=$(basename $2)
Read_R=$(basename $3)
OutDir=$4
Iterations=$5
if [ $6 ]; then
  Ploidy=$6
else
  Ploidy="haploid"
fi

CurDir=$PWD
echo  "Running Pilon with the following inputs:"
echo "Pacbio assembly - $Assembly"
echo "Forward trimmed reads - $Read_F"
echo "Reverse trimmed reads - $Read_R"
echo "OutDir - $OutDir"
echo "Running Pilon the following number of times - $Iterations"
echo "Ploidy set to: $Ploidy"

mkdir -p $CurDir/$OutDir

# ---------------
# Step 2
# Copy data
# ---------------
cp $1 $CurDir/
cp $2 $CurDir/
cp $3 $CurDir/

WorkDir=$TMPDIR/${SLURM_JOB_USER}_${SLURM_JOBID}
mkdir -p $WorkDir
cd $WorkDir
cp $CurDir/$Assembly assembly.fa
cp $CurDir/$Read_F $Read_F
cp $CurDir/$Read_R $Read_R

mkdir best_assembly
cp assembly.fa best_assembly/.

for i in $(seq 1 $Iterations); do
  echo "Running Iteration: $i"
  mkdir $WorkDir/"correction_$i"
  cd $WorkDir/correction_$i
  cp $WorkDir/best_assembly/assembly.fa .

  # ---------------
  # Step 3.a
  # Align seq reads
  # ---------------
  # Prepare the assembly for alignment
  # Align reads against the assembly
  # Convert the SAM file to BAM in preparation for sorting.
  # Sort the BAM file, in preparation for SNP calling:
  # Index the bam file

  bowtie2-build assembly.fa assembly.fa.indexed
  bowtie2 -p 12 -x assembly.fa.indexed -1 $WorkDir/$Read_F -2 $WorkDir/$Read_R  -S assembly.fa_aligned.sam
  samtools view -@ $Threads -bS assembly.fa_aligned.sam -o assembly.fa_aligned.bam
  samtools sort -@ $Threads assembly.fa_aligned.bam -o assembly.fa_aligned_sorted.bam
  samtools index -@ $Threads assembly.fa_aligned_sorted.bam

  # ---------------
  # Step 3.b
  # Run Pilon
  # ---------------
  # Run pilon to polish
  if [ $Ploidy == "haploid" ]; then
    java -Xmx400G -jar /mnt/shared/scratch/jnprice/apps/conda/pkgs/pilon-1.24-hdfd78af_0/share/pilon-1.24-0/pilon.jar --threads $Threads --genome assembly.fa --changes --frags assembly.fa_aligned_sorted.bam --outdir .
  elif [ $Ploidy == "diploid" ]; then
    pilon --threads $Threads --genome assembly.fa --changes --diploid --frags assembly.fa_aligned_sorted.bam --outdir .
  else
    echo "ploidy not recognised"
  fi
  cp pilon.fasta $WorkDir/best_assembly/assembly.fa
  # cp pilon.changes $WorkDir/best_assembly/pilon_$i.changes
  cp pilon.fasta $CurDir/$OutDir/pilon_$i.fasta
  cp pilon.changes $CurDir/$OutDir/pilon_$i.changes
  cd $WorkDir
done

mv $WorkDir/best_assembly/assembly.fa $WorkDir/best_assembly/pilon.fasta

# mkdir -p $CurDir/$OutDir
# cp $WorkDir/best_assembly/* $CurDir/$OutDir/.
rm -r $WorkDir
