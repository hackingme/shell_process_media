set -euo pipefail
trap "echo Fail unexpectedly on line \$LINENO! > &2" ERR

for t in mp4 MP4; do
  for f in *.$t; do 
    if test -f "$f"; then
      echo "$f"
      ffmpeg -i "$f" -vcodec libx264 -crf 40 ~/temp/$f -y
    fi
  done
done

