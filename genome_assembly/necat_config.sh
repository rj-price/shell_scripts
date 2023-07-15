
# reads file = $1

export PATH=$PATH:/mnt/shared/scratch/jnprice/apps/NECAT/Linux-amd64/bin

fileshort=$(basename $1 | sed s/".fastq.gz"//g)
mkdir $fileshort
cd $fileshort
realpath $1 > read_list.txt
necat.pl config "$fileshort"_config.txt

