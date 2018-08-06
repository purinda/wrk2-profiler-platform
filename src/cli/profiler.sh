[ $PROFILER_SH ] && return || PROFILER_SH=1

source "${app}/src/cli/logger.sh"
source "${app}/src/cli/yaml.sh"

function profile() {
    profiler_fn=$1

    # Parse the input yaml file
    parse_yaml $profiler_fn
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

    TOTAL=0
    TIMESTAMP=$(date +%Y%m%d_%H%M)
    FOLDER=/tmp/results/profiling_at_$TIMESTAMP
    mkdir -p $FOLDER

    # Run wrk
    while read switch auth request parameter name ;
    do
        if [ "$switch" == "1" ]; then
            if [ "$auth" == "1" ] && [ -z ${AUTHTOKEN+x} ]; then
                console "AuthToken is not set. Skip request needs authentication"
                continue
            fi

            note "Testing $request"
            CMD="wrk -t$THREADS -c$CONNECTIONS -d$DURATION -R$RATE -H 'AuthToken: $AUTHTOKEN' -s lua/$parameter --latency $URL_PREFIX$request"

            if [ "$SHOW_ON_TERMINAL" == "1" ]; then
                console "Command: $CMD"
                eval $CMD
            else
                eval $CMD > $FOLDER/$name
            fi
            ((TOTAL++))
        fi
    done < $profiler_fn

    note "$TOTAL request(s) tested in total"

    if [ "$SHOW_ON_TERMINAL" == "1" ]; then
        note "Skip drawing HdrHistogram as result is not saved."
    else
        note "Producing histogram.."
        input=""
        for result in $FOLDER/*
        do
            input="$input $result"
        done

        # Run gnuplot
        ${app}/src/cli/make_percentile_plot -o $FOLDER/histogram.svg $input
    fi

    console "Done"
}