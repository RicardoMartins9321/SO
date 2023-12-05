# Check if the file name is provided
if [ $# -eq 0 ]; then
  echo "Please provide the file name as an argument."
  exit 1
fi

# Check if the file exists and is readable
filename="$1"
if [ ! -f "$filename" ] || [ ! -r "$filename" ]; then
  echo "File '$filename' does not exist or is not readable."
  exit 1
fi

function selecao() {
    arr=( $(cat $1) )
    retval=1

    while (( $retval == 1 )); do
        retval=0

        for i in ${!arr[@]}; do
            current_index=$i
            next_index=$(($i+1))
            current_value=${arr[current_index]}
            next_value=${arr[next_index]}

            if [[ $next_value -ne "" ]]; then
                if [[ $current_value -gt $next_value ]]; then
                    arr[current_index]=$next_value
                    arr[next_index]=$current_value
                    retval=1
                fi
            fi
        done
    done

    echo "Initial array: " $(cat $1)
    echo "Sorted array:	"${arr[@]}
}

selecao $1
