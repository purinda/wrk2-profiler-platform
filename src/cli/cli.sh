[ $CLI_SH ] && return || CLI_SH=1

source "${app}/src/cli/logger.sh"


# CLI help screen
function help_scr() {
    title "${name}"
    console_n "Version "; note "${version}"; console
    console
    console "Usage:"
    console "  $0 [args] [command]"
    console
    console "Arguments:"
    console "   --log fn               Use a different logging location (default ~/log)"
    console "   --version              Display current version"
    console "   -y --force-yes         Answer yes to all confirmations"
    console "   -v --verbose           Increase logging output"
    console
    console "Commands:"
    console "   run fn                 Run the load/stress test profiling as per file 'fn'"
    console "   help                   Display this help screen"
    console
}

# Parse the command line
function cli_parse() {
    # No args is invalid, show help and exit
    if [[ $# -eq 0 ]]; then
        help_scr
        exit 1
    fi

    # CLI parser
    while [ -n "$1" ]; do
        case "$1" in
            run)
                source "${app}/src/cli/profiler.sh"
                profile "$2"
                shift 2
                ;;
            help|--help|'-?')
                help_scr
                check_for_updates
                shift
                ;;
            -v|--verbose)
                VERBOSE=1
                shift
                ;;
            -y|--force-yes)
                FORCE_YES=1
                shift
                ;;
            --version)
                console "${version}"
                shift
                ;;
            --venv)
                venv="$2"
                shift 2
                ;;
            --log)
                log="$2"
                shift 2
                ;;
            --)
                exit 0
                ;;
            *)
                console_n "Unknown command line option '"; note "$1"; console "'"
                exit 1
                ;;
        esac
    done
}