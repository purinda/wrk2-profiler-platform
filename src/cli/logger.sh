[ $LOGGER_SH ] && return || LOGGER_SH=1

TXT_BIN="printf -- "


# Ensures the log file exists and is writable
# Will attempt to create it if it does not exist
function validate_log() {
    if [[ ! -w "${log}" ]]; then
        mkdir -p "$(dirname "${log}")" 2> /dev/null
        touch "${log}" 2> /dev/null
        if [[ ! -w "${log}" ]]; then
            ${TXT_BIN} "\e[91mUnable to create or write to log file, exiting\e[0m\n"
            exit 2
        fi
    fi
}

### CONSOLE ONLY OUTPUT ###

# Console-only output
function console() {
    ${TXT_BIN} "$1\n"
}

# Console-only output; no newline
function console_n() {
    ${TXT_BIN} "$1"
}

# Displays text highlighted; new-line
function note() {
    ${TXT_BIN} "\e[94m$1\e[0m\n"
}

# Displays text highlighted; no new-line
function note_n() {
    ${TXT_BIN} "\e[94m$1\e[0m"
}

# Displays a highlighted title text; includes a new-line
function title() {
    ${TXT_BIN} "\e[93m$1\e[0m\n"
}


### COMBINED CONSOLE & LOG OUTPUTS ###

# Plain output, includes logging
function out() {
    validate_log
    ${TXT_BIN} "$1\n" 2>&1 | tee -a "${log}"
}

# Plain output; no newline
function out_n() {
    validate_log
    ${TXT_BIN} "$1" 2>&1 | tee -a "${log}"
}


# Displays text in red; no new-line
function err() {
    validate_log
    ${TXT_BIN} "\e[91m$1\e[0m" 2>&1 | tee -a "${log}"
}

# Check status of previous command and return a success/error note
function is_ok() {
    validate_log
    if [[ $? -eq 0 ]]; then
        ${TXT_BIN} " \e[92mOK\e[0m\n" 2>&1 | tee -a "${log}"
    else
        ${TXT_BIN} " \e[91mERROR\e[0m\n" 2>&1 | tee -a "${log}"
    fi
}


### LOG SPECIFIC OUTPUT ###

# Only output to console if verbose logging enabled
function log() {
    validate_log
    if [[ "${VERBOSE}" -eq 1 ]]; then
        ${TXT_BIN} "\e[37m$1\e[0m\n" 2>&1 | tee -a "${log}"
    else
        ${TXT_BIN} "\e[37m$1\e[0m\n" 2>&1 >> "${log}"
    fi
}

# Only output if verbose logging enabled; no new-line
function log_n() {
    validate_log
    if [[ "${VERBOSE}" -eq 1 ]]; then
        ${TXT_BIN} "\e[37m$1\e[0m" 2>&1 | tee -a "${log}"
    else
        ${TXT_BIN} "\e[37m$1\e[0m" 2>&1 >> "${log}"
    fi
}