[ $PROFILER_SH ] && return || PROFILER_SH=1

source "${app}/src/cli/logger.sh"
source "${app}/src/cli/yaml.sh"

function profile() {
    total=0
    profiler_fn=$1

    # Parse the input yaml file
    create_variables $profiler_fn
    out "Running profile '$profiler_fn'"

    if [ "${debug}" == "1" ]; then
        out "Threads:     $profiler_threads"
        out "Connections: $profiler_connections"
        out "Duration:    $profiler_duration"
        out "Rate:        $profiler_rate"
        out ""
    fi

    mkdir_results

    # Run wrk for each URL in the profile
    for idx in $( seq 0 $(( ${#calls__active[@]}-1 )) )
    do
        if [ "${calls__active[$idx]}" == "0" ]; then
            continue
        fi

        # If authentication is required
        if [ "$auth" == "1" ] && [ -z ${auth_token+x} ]; then
            err "AuthToken is not set. Skip request needs authentication"
            continue
        fi

        out_n "Testing '${calls__name[$idx]}'.."
        cmd="wrk -t${profiler_threads} -c${profiler_connections} -d${profiler_duration} -R${profiler_rate} -s${calls__script[$idx]} --latency ${base_url}${calls__path[$idx]}"
        eval ${cmd} > ${output_dir}/${calls__name[$idx]}.log
        is_ok

        if [ "${debug}" == "1" ]; then
            out "URL: ${base_url}${calls__path[$idx]}"
            out "Cmd: ${cmd}"
        fi

        out ""
        ((total++))
    done

    out "${total} request(s) tested in total"
    generate_histogram

    out "Results in ${output_dir}"
    out "Done"
}

function mkdir_results() {
    out_n "Setting up results directory.."
    timestamp=$(date +%Y%m%d_%H%M)
    output_dir=/tmp/results/${name}_${timestamp}
    mkdir -p ${output_dir}
    is_ok
    out ""
}

function generate_histogram() {
    # Histogram
    if [ "${histogram}" == "0" ]; then
        note "Skip drawing HdrHistogram as result is not saved."
    else
        out_n "Producing histogram.."
        input=""
        for result in ${output_dir}/*
        do
            input="${input} ${result}"
        done

        # Run gnuplot
        ${app}/src/cli/make_percentile_plot -o ${output_dir}/histogram.svg $input &> /dev/null
        is_ok
    fi
}