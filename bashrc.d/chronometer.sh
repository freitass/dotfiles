# Usage: countdown 60
function countdown() {
  date1=$((`date +%s` + $1)); 
  while [ "$date1" -ne `date +%s` ]; do 
    echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

# Usage: stopwatch
function stopwatch() {
  date1=`date +%s`; 
  running=true
  trap 'running=false' SIGINT SIGTERM
  while $running; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    sleep 0.1
  done
  trap - # untrap
  echo "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)"; 
}
