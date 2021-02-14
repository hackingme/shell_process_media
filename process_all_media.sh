set -euo pipefail
trap "echo Fail unexpectedly on line \$LINENO! > &2" ERR

for t in JPG jpg mp4 MP4 MOV; do
  for f in *.$t; do 
    if test -f "$f"; then
      date1=$(mdls -raw -name kMDItemContentCreationDate "$f")
      date2=$(mdls -raw -name kMDItemFSContentChangeDate "$f")
      date=$([[ "$date1" < "$date2" ]] && echo "$date1" || echo "$date2")
      folder=$(date -f'%F %T %z' -j "$date" +%Y-%m-%d)
      mkdir -p $folder
      echo "$f" $folder
      mv "$f" $folder
    fi
  done
done

