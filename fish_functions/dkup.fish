function dkup
	dcp ps | awk '{print $1, $3}' | grep "Up" $argv
end
