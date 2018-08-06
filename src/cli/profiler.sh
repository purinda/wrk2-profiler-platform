[ $PROFILER_SH ] && return || PROFILER_SH=1

source "${app}/src/cli/logger.sh"
source "${app}/src/cli/yaml.sh"

function profile() {
    profiler_fn=$1

    # Parse the input yaml file
    create_variables $profiler_fn

    note "Reading '$profiler_fn' for configuration."
    console "Threads:     $profiler_threads"
    console "Connections: $profiler_connections"
    console "Duration:    $profiler_duration"
    console "Rate:        $profiler_rate"

    # note "Generating auth token.."
    # curl -d@auth/reqAccountValidate1.xml http://sample-app/ > auth/authtoken_response
    # AUTHTOKEN=$(grep '<token' auth/authtoken_response | cut -f2 -d">"|cut -f1 -d"<")
    # console "AuthToken: $AUTHTOKEN"

    total=0
    timestamp=$(date +%Y%m%d_%H%M)
    output_dir=/tmp/results/${name}${timestamp}
    mkdir -p ${output_dir}

    # Run wrk for each item(URL) in the profile
    for item in "${calls__active[@]}"
    do
        if [ "${calls__active[$item]}" == "0" ]; then
            continue
        fi

        # If authentication is required
        if [ "$auth" == "1" ] && [ -z ${AUTHTOKEN+x} ]; then
            console "AuthToken is not set. Skip request needs authentication"
            continue
        fi

        note "Testing ${calls__path[$item]}"
        cmd="wrk -t${profiler_threads} -c${profiler_connections} -d${profiler_duration} -R${profiler_rate} -H 'AuthToken: ${AUTHTOKEN}' -s $lua_callback --latency ${base_url}${request}"

        if [ "$debug" == "1" ]; then
            note "Shell cmd: \n\t \$ ${cmd}"
            eval ${cmd}
        else
            eval ${cmd} > ${output_dir}/${name}
        fi
        ((total++))
    done

    note "$total request(s) tested in total"

    if [ "${debug}" == "1" ]; then
        note "Skip drawing HdrHistogram as result is not saved."
    else
        note "Producing histogram.."
        input=""
        for result in ${output_dir}/*
        do
            input="$input $result"
        done

        # Run gnuplot
        ${app}/src/cli/make_percentile_plot -o ${output_dir}/histogram.svg $input
    fi

    console "Done"
}