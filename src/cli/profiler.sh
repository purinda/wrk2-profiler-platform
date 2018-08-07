[ $PROFILER_SH ] && return || PROFILER_SH=1

source "${app}/src/cli/logger.sh"
source "${app}/src/cli/yaml.sh"

function profile() {
    profiler_fn=$1

    # Parse the input yaml file
    create_variables $profiler_fn

    note "Running profile '$profiler_fn'"

    if [ "${debug}" == "1" ]; then
        console "Threads:     $profiler_threads"
        console "Connections: $profiler_connections"
        console "Duration:    $profiler_duration"
        console "Rate:        $profiler_rate"
        console ""
    fi

    total=0
    timestamp=$(date +%Y%m%d_%H%M)
    output_dir=/tmp/results/${name}${timestamp}
    mkdir -p ${output_dir}

    # Run wrk for each URL in the profile
    for idx in $( seq 0 ${calls__active[@]} )
    do
        if [ "${calls__active[$idx]}" == "0" ]; then
            continue
        fi

        # If authentication is required
        if [ "$auth" == "1" ] && [ -z ${AUTHTOKEN+x} ]; then
            console "AuthToken is not set. Skip request needs authentication"
            continue
        fi

        note "Testing '${calls__name[$idx]}'"
        cmd="wrk -t${profiler_threads} -c${profiler_connections} 
            -d${profiler_duration} -R${profiler_rate} -s ${calls__script[$idx]} 
            --latency ${base_url}${calls__path[$idx]}"

        if [ "${debug}" == "1" ]; then
            console "URL: ${base_url}${calls__path[$idx]}"
            console "Shell Cmd: ${cmd}"
        fi

        eval ${cmd} > ${output_dir}/${calls__name[$idx]}.log
        console ""
        ((total++))
    done

    note "${total} request(s) tested in total"

    # Histogram
    if [ "${histogram}" == "0" ]; then
        note "Skip drawing HdrHistogram as result is not saved."
    else
        note "Producing histogram.."
        input=""
        for result in ${output_dir}/*
        do
            input="${input} ${result}"
        done

        # Run gnuplot
        ${app}/src/cli/make_percentile_plot -o ${output_dir}/histogram.svg $input
    fi

    console "Done"
}