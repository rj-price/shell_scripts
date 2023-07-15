#!/usr/bin/env bash
#SBATCH -J pilon
#SBATCH --partition=long
#SBATCH --mem=60G
#SBATCH --cpus-per-task=16

# Align raw reads to a pacbio assembly and then use this alignmeant to correct
# indels and substitutions in the assembly.

#Mem="768G"
Threads=28

# ---------------
# Step 1
# Collect inputs
# ---------------

Assembly=$(basename $1)
Read_F1=$(basename $2)
Read_R1=$(basename $3)
Read_F2=$(basename $4)
Read_R2=$(basename $5)
OutDir=${6}
Iterations=${7}
if [ ${8} ]; then
  Ploidy=${8}
else
  Ploidy="haploid"
fi

CurDir=$PWD
echo "Running Pilon with the following inputs:"
echo "Pacbio assembly - $Assembly"
echo "Forward trimmed reads - $Read_F1 $Read_F2"
echo "Reverse trimmed reads - $Read_R1 $Read_R2"
echo "OutDir - $OutDir"
echo "Ploidy set to: $Ploidy"

mkdir -p $CurDir/$OutDir

# ---------------
# Step 2
# Copy data
# ---------------
cp $1 $CurDir/
cp $2 $CurDir/
cp $3 $CurDir/
cp $4 $CurDir/
cp $5 $CurDir/

WorkDir=$TMPDIR/${SLURM_JOB_USER}_${SLURM_JOBID}
mkdir -p $WorkDir
cd $WorkDir
cp $CurDir/$Assembly assembly.fa
cp $CurDir/$Read_F1 $Read_F1
cp $CurDir/$Read_R1 $Read_R1
cp $CurDir/$Read_F2 $Read_F2
cp $CurDir/$Read_R2 $Read_R2

mkdir best_assembly
cp assembly.fa best_assembly/.

for i in $(seq 1 $Iterations); do
  echo "Running Iteration: $i"
  mkdir $WorkDir/"correction_$i"
  cd $WorkDir/correction_$i
  cp $WorkDir/best_assembly/assembly.fa .
  # ---------------
  # Step 3
  # Align seq reads
  # ---------------
  # Prepare the assembly for alignment
  # Align reads against the assembly
  # Convert the SAM file to BAM in preparation for sorting.
  # Sort the BAM file, in preparation for SNP calling:
  # Index the bam file

  bowtie2-build assembly.fa assembly.fa.indexed
  bowtie2 -p 24 -x assembly.fa.indexed -1 $WorkDir/$Read_F1,$WorkDir/$Read_F2 -2 $WorkDir/$Read_R1,$WorkDir/$Read_R2 -S assembly.fa_aligned.sam
  samtools view -@ $Threads -bS assembly.fa_aligned.sam -o assembly.fa_aligned.bam
  samtools sort -@ $Threads assembly.fa_aligned.bam -o assembly.fa_aligned_sorted.bam
  samtools index -@ $Threads assembly.fa_aligned_sorted.bam

  # ---------------
  # Step 4
  # Run Pilon
  # ---------------
  # Run pilon to polish

  if [ $Ploidy == "haploid" ]; then
    java -Xmx200G -jar /mnt/shared/scratch/jnprice/apps/conda/pkgs/pilon-1.24-hdfd78af_0/share/pilon-1.24-0/pilon.jar --threads $Threads --genome assembly.fa --changes --frags assembly.fa_aligned_sorted.bam --outdir .
  elif [ $Ploidy == "diploid" ]; then
    JavaDir=/projects/oldhome/armita/prog/pilon
    java -Xmx512G -jar /home/pricej/miniconda3/pkgs/pilon-1.23-2/share/pilon-1.23-2/pilon-1.23.jar --threads $Threads --genome assembly.fa --changes --diploid --frags assembly.fa_aligned_sorted.bam --outdir .
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
