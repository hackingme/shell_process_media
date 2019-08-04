set -euo pipefail
trap "echo Fail unexpectedly on line \$LINENO! > &2" ERR

for t in JPG jpg mp4 MP4 MOV; do
  for f in *.$t; do 
    if test -f "$f"; then
      folder=$(date -f'%F %T %z' -j "$(mdls -raw -name kMDItemContentCreationDate $f)" +%Y-%m-%d)
      mkdir -p $folder
      echo $f $folder
      mv $f $folder
    fi
  done
done

