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
        if [ "${calls__auth[$idx]}" == "1" ] && [ -z ${auth_token+x} ]; then
            err "Request needs authentication and token hasn't been generated."
            exit
        fi

        out_n "Profiling '${calls__name[$idx]}'.."
        cmd="wrk -t${profiler_threads} -c${profiler_connections} -d${profiler_duration} -R${profiler_rate} -s${calls__script[$idx]} --u_latency ${base_url}${calls__path[$idx]}"
        eval ${cmd} > ${output_dir}/${calls__name[$idx]}
        remove_corrected_latency_data ${output_dir}/${calls__name[$idx]} ${output_dir}/${calls__name[$idx]}.log
        is_ok

        out_n "Validating results '${calls__name[$idx]}'.."
        validate_result ${output_dir}/${calls__name[$idx]}.log

        # Get rid of the original histogram data with corrected latency
        rm ${output_dir}/${calls__name[$idx]}

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

function remove_corrected_latency_data() {
    separator="-\{58\}"
    sed "/Running/,/${separator}/d" $1 > $2
}

function mkdir_results() {
    out_n "Setting up results directory.."
    timestamp=$(date +%Y%m%d_%H%M)
    output_dir=/tmp/results/${name}_${timestamp}
    mkdir -p ${output_dir}
    is_ok
    out ""
}

function validate_result() {
    logfile=$1

    # Check if the results are empty
    if [ -s "$logfile" ]; then
        err "Profiler output cannot be used for graphing. Reduce threads or increase the duration of the test."
    fi

    # Check if the NaN (not a number) output was produced
    if [[ $logfile =~ '/nan/i' ]]; then
        
    fi
}

function generate_histogram() {
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