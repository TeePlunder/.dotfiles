function killport
  if test (count $argv) -ne 1
    echo "Usage: killport <port_number>"
    return 1
  end

  set port $argv[1]

  if not string match -r '^[0-9]+$' $port
    echo "Error: Port number must be a number."
    return 1
  end

  set pids (lsof -i :$port | grep LISTEN | awk '{print $2}')

  if test -z "$pids"
    echo "No process found listening on port $port."
    return 1
  end

  for pid in $pids
    kill $pid
    if test $status -eq 0
      echo "Killed process $pid (port $port)."
    else
      echo "Failed to kill process $pid (port $port)."
    end
  end

end
