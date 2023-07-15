#!/usr/bin/env bash
#SBATCH -J pilon
#SBATCH --partition=himem
#SBATCH --mem=400G
#SBATCH --cpus-per-task=30

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

CurDir=$PWD
echo  "Running Pilon with the following inputs:"
echo "Pacbio assembly - $Assembly"
echo "Forward trimmed reads - $Read_F"
echo "Reverse trimmed reads - $Read_R"
echo "OutDir - $OutDir"
echo "Running Pilon the following number of times - $Iterations"

mkdir -p $CurDir/$OutDir

# ---------------
# Step 2
# Copy data
# ---------------
cp $1 $CurDir/assembly.fa
cp $2 $CurDir/$Read_F
cp $3 $CurDir/$Read_R

cd $OutDir

mkdir best_assembly
cp $CurDir/assembly.fa best_assembly/.

for i in $(seq 1 $Iterations); do
  echo "Running Iteration: $i"
  mkdir $CurDir/$OutDir/"correction_$i"
  cd $CurDir/$OutDir/correction_$i
  cp $CurDir/$OutDir/best_assembly/assembly.fa .

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
  bowtie2 -p 12 -x assembly.fa.indexed -1 $CurDir/$Read_F -2 $CurDir/$Read_R  -S assembly.fa_aligned.sam
  samtools view -@ $Threads -bS assembly.fa_aligned.sam -o assembly.fa_aligned.bam
  samtools sort -@ $Threads assembly.fa_aligned.bam -o assembly.fa_aligned_sorted.bam
  samtools index -@ $Threads assembly.fa_aligned_sorted.bam

  # ---------------
  # Step 3.b
  # Run Pilon
  # ---------------
  # Run pilon to polish
  java -Xmx400G -jar /mnt/shared/scratch/jnprice/apps/conda/pkgs/pilon-1.24-hdfd78af_0/share/pilon-1.24-0/pilon.jar --threads $Threads --genome assembly.fa --changes --frags assembly.fa_aligned_sorted.bam --outdir .

  cp pilon.fasta $CurDir/$OutDir/best_assembly/assembly.fa
  cp pilon.fasta $CurDir/$OutDir/pilon_$i.fasta
  cp pilon.changes $CurDir/$OutDir/pilon_$i.changes
  cd $CurDir/$OutDir
done

mv $CurDir/$OutDir/best_assembly/assembly.fa $CurDir/$OutDir/best_assembly/pilon.fasta

