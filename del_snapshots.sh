#/bin/bash
clear
root="/c/temp/" # where are the files and directories
svol="/.snapshots/" # where are the subvols
n=30 #anzahl zu erhaltener snapshots

#subdirectories array
sd=("data_public" "data_versicherung" "data_share" "data_ra" "data_it")

for ((j=0; j<$((${#sd[@]})); j++))
do
	snapshotpath=$root${sd[j]}$svol
	sn=($(ls $snapshotpath))
	
	echo "touch $snapshotpath@GMT_`date +%Y.%m.%d-%H.%M.%S`"
	touch $snapshotpath@GMT_`date +%Y.%m.%d-%H.%M.%S`
	
	if [ ${#sn[@]} -gt $n  ]
		then
		for ((i=0; i<$((${#sn[@]}-$n)); i++))
		do
			echo "btrfs subvol delete" $snapshotpath${sn[i]}
			rm -fr $snapshotpath${sn[i]}
		done
	fi
done