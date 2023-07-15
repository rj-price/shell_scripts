#Script to create circos plots. 
#1.) First create txt files for genomes and concatenate
#2.) Create synteny links between genomes using satsuma synteny 
#3.) Create circos config file used for building ideogram.  


#1.) Create a .txt file with contig lengths of the genomes to be aligned. 
#.txt file for genome 1 
 
Genome1=/projects/fusarium_venenatum_miseq/genomes/WT/WT_contigs_unmasked.fa
OutDir=/home/connellj/Circos 
mkdir -p $OutDir
ProgDir=/home/connellj/git_repos/emr_repos/Fv_C-variants/Circos
$ProgDir/python_create_circos_file.py --genome $Genome1 --contig_prefix "A3_5_" > $OutDir/Fv_Illumina_genome.txt

#.txt file for genome 2 

Genome2=/projects/oldhome/connellj/local_MINion_Fv_genome/WT_albacore_v2_contigs_unmasked.fa
OutDir=/home/connellj/Circos 
ProgDir=/home/connellj/git_repos/emr_repos/Fv_C-variants/Circos
$ProgDir/python_create_circos_file.py --genome $Genome2 --contig_prefix "A3_5_MIN_" > $OutDir/Fv_MINion_genome.txt

#concatenate files

File=/home/connellj/Circos
cat $File/Fv_Illumina_genome.txt > $File/Fv_Fv_genome.txt
tac $File/Fv_MINion_genome.txt >> $File/Fv_Fv_genome.txt

 #Contigs smaller than 10Kb can be removed if not required. 

  cat $File/Fv_Fv_genome.txt \
  | grep -v -e "A3_5_contig_87" \
  | grep -v -e "A3_5_contig_88" \
  | grep -v -e "A3_5_contig_89" \
  | grep -v -e "A3_5_contig_90" \
  | grep -v -e "A3_5_contig_91" \
  | grep -v -e "A3_5_contig_92" \
  | grep -v -e "A3_5_contig_93" \
  | grep -v -e "A3_5_contig_94" \
  | grep -v -e "A3_5_contig_95" \
  | grep -v -e "A3_5_contig_96" \
  | grep -v -e "A3_5_contig_97" \
  | grep -v -e "A3_5_contig_98" \
  | grep -v -e "A3_5_contig_99" \
  | grep -v -e "A3_5_contig_100" \
  | grep -v -e "A3_5_contig_101" \
  | grep -v -e "A3_5_contig_102" \
  | grep -v -e "A3_5_contig_103" \
  | grep -v -e "A3_5_contig_104" \
  | grep -v -e "A3_5_contig_105" \
  | grep -v -e "A3_5_MINcontig_5" \
  > $OutDir/Fv_Fv_genome_edited.txt


#2.) Create synteny links between genomes. 


Genome1=/projects/fusarium_venenatum_miseq/genomes/WT/WT_contigs_unmasked.fa
Genome2=/projects/oldhome/connellj/local_MINion_Fv_genome/WT_albacore_v2_contigs_unmasked.fa
OutDir=/home/connellj/Circos/satsuma_alignment/test_copy 
mkdir -p $OutDir
ProgDir=/home/connellj/git_repos/emr_repos/Fv_C-variants/Circos
sbatch $ProgDir/satsuma_synteny.sh $Genome1 $Genome2 $OutDir 



#3.) Edit contig prefix to match step 1, this is required as contig prefix must remain uniform.
#This script assumes your contigs are called "contig_". Change pre1 and pre2 to new contig prefix idetifier


Synteny_file=/home/connellj/Circos/satsuma_alignment/test_copy/satsuma_summary.chained.out            #Synteny file location and file name here  
OutDir=/home/connellj/Circos/satsuma_alignment/test_copy/satsuma_summary_editedforcircos.chained.out  #Outfile location and file name here 
pre1=A3_5_contig_  #change to your full contig name (eg if part 1 is a35_ now its a35_contig_)
pre2=A3_5_MIN_contig_  #change to your full contig name 
ProgDir=/home/connellj/git_repos/emr_repos/Fv_C-variants/Circos
$ProgDir/Python_edit_contig_names.py --synteny $Synteny_file --contig_prefix_1 $pre1 --contig_prefix_2 $pre2 --outfile $OutDir


#3.) Run circos
# Circos relies on a configuration file which has other branching files involved in the ideogram configuration, and must be setup for each run.
# The 2D plot must link to satsuma_summary_chained_out file from previous step 


Conf=/home/connellj/git_repos/emr_repos/Fv_C-variants/Circos/circos_configuration.sh
OutDir=/home/connellj/Circos/ideogram
mkdir -p $OutDir
ProgDir=/home/connellj/git_repos/emr_repos/Fv_C-variants/Circos
sbatch $ProgDir/circos.sh $Conf $OutDir


# change the colours of the synteny link file with 


syntenty_link_file=/home/connellj/Circos/satsuma_alignment/satsuma_summary_editedforcircos.chained.out
OutDir=/home/connellj/Circos/satsuma_alignment/satsuma_summary_editedforcircos.chained.out_colour
awk '{print $0, "\tcolor=red"}' $syntenty_link_file > $OutDir


Synteny_file=/home/connellj/Circos/satsuma_alignment/satsuma_summary_editedforcircos.chained.out_colour           
OutDir=/home/connellj/Circos/satsuma_alignment/satsuma_summary_editedforcircos.chained.out_colours  
contig_name=A3_5_contig_1  
existing_colour=red
new_colour=blue
ProgDir=/home/connellj/git_repos/emr_repos/Fv_C-variants/Circos
$ProgDir/python_change_synteny_colour.py --synteny $Synteny_file --contig_name $contig_name --existing_colour $existing_colour --new_colour $new_colour --outfile $OutDir
