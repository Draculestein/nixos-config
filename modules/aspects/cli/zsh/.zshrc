# nh completions

autoload -U is-at-least

_nh() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_nh_commands" \
"*::: :->nh" \
&& ret=0
    case $state in
    (nh)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:nh-command-$line[1]:"
        case $line[1] in
            (os)
_arguments "${_arguments_options[@]}" \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_nh__os_commands" \
"*::: :->os" \
&& ret=0

    case $state in
    (os)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:nh-os-command-$line[1]:"
        case $line[1] in
            (switch)
_arguments "${_arguments_options[@]}" \
'-D+[Closure diff provider]:DIFF_PROVIDER: ' \
'--diff-provider=[Closure diff provider]:DIFF_PROVIDER: ' \
'-H+[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'--hostname=[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'-s+[Name of the specialisation]:SPECIALISATION: ' \
'--specialisation=[Name of the specialisation]:SPECIALISATION: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confirmation]' \
'--ask[Ask for confirmation]' \
'-u[Update flake inputs before building specified configuration]' \
'--update[Update flake inputs before building specified configuration]' \
'--no-nom[Don'\''t use nix-output-monitor for the build process]' \
'-S[Don'\''t use specialisations]' \
'--no-specialisation[Don'\''t use specialisations]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':flakeref -- Flake reference to build:_files -/' \
'*::extra_args -- Extra arguments passed to nix build:' \
&& ret=0
;;
(boot)
_arguments "${_arguments_options[@]}" \
'-D+[Closure diff provider]:DIFF_PROVIDER: ' \
'--diff-provider=[Closure diff provider]:DIFF_PROVIDER: ' \
'-H+[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'--hostname=[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'-s+[Name of the specialisation]:SPECIALISATION: ' \
'--specialisation=[Name of the specialisation]:SPECIALISATION: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confirmation]' \
'--ask[Ask for confirmation]' \
'-u[Update flake inputs before building specified configuration]' \
'--update[Update flake inputs before building specified configuration]' \
'--no-nom[Don'\''t use nix-output-monitor for the build process]' \
'-S[Don'\''t use specialisations]' \
'--no-specialisation[Don'\''t use specialisations]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':flakeref -- Flake reference to build:_files -/' \
'*::extra_args -- Extra arguments passed to nix build:' \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" \
'-D+[Closure diff provider]:DIFF_PROVIDER: ' \
'--diff-provider=[Closure diff provider]:DIFF_PROVIDER: ' \
'-H+[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'--hostname=[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'-s+[Name of the specialisation]:SPECIALISATION: ' \
'--specialisation=[Name of the specialisation]:SPECIALISATION: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confirmation]' \
'--ask[Ask for confirmation]' \
'-u[Update flake inputs before building specified configuration]' \
'--update[Update flake inputs before building specified configuration]' \
'--no-nom[Don'\''t use nix-output-monitor for the build process]' \
'-S[Don'\''t use specialisations]' \
'--no-specialisation[Don'\''t use specialisations]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':flakeref -- Flake reference to build:_files -/' \
'*::extra_args -- Extra arguments passed to nix build:' \
&& ret=0
;;
(build)
_arguments "${_arguments_options[@]}" \
'-D+[Closure diff provider]:DIFF_PROVIDER: ' \
'--diff-provider=[Closure diff provider]:DIFF_PROVIDER: ' \
'-H+[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'--hostname=[Output to choose from the flakeref. Hostname is used by default]:HOSTNAME: ' \
'-s+[Name of the specialisation]:SPECIALISATION: ' \
'--specialisation=[Name of the specialisation]:SPECIALISATION: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confirmation]' \
'--ask[Ask for confirmation]' \
'-u[Update flake inputs before building specified configuration]' \
'--update[Update flake inputs before building specified configuration]' \
'--no-nom[Don'\''t use nix-output-monitor for the build process]' \
'-S[Don'\''t use specialisations]' \
'--no-specialisation[Don'\''t use specialisations]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':flakeref -- Flake reference to build:_files -/' \
'*::extra_args -- Extra arguments passed to nix build:' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(home)
_arguments "${_arguments_options[@]}" \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_nh__home_commands" \
"*::: :->home" \
&& ret=0

    case $state in
    (home)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:nh-home-command-$line[1]:"
        case $line[1] in
            (switch)
_arguments "${_arguments_options[@]}" \
'-D+[Closure diff provider]:DIFF_PROVIDER: ' \
'--diff-provider=[Closure diff provider]:DIFF_PROVIDER: ' \
'-c+[Name of the flake homeConfigurations attribute, like username@hostname]:CONFIGURATION: ' \
'--configuration=[Name of the flake homeConfigurations attribute, like username@hostname]:CONFIGURATION: ' \
'-b+[Move existing files by backing up with the extension]:BACKUP_EXTENSION: ' \
'--backup-extension=[Move existing files by backing up with the extension]:BACKUP_EXTENSION: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confirmation]' \
'--ask[Ask for confirmation]' \
'-u[Update flake inputs before building specified configuration]' \
'--update[Update flake inputs before building specified configuration]' \
'--no-nom[Don'\''t use nix-output-monitor for the build process]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':flakeref -- Flake reference to build:_files -/' \
'*::extra_args -- Extra arguments passed to nix build:' \
&& ret=0
;;
(build)
_arguments "${_arguments_options[@]}" \
'-D+[Closure diff provider]:DIFF_PROVIDER: ' \
'--diff-provider=[Closure diff provider]:DIFF_PROVIDER: ' \
'-c+[Name of the flake homeConfigurations attribute, like username@hostname]:CONFIGURATION: ' \
'--configuration=[Name of the flake homeConfigurations attribute, like username@hostname]:CONFIGURATION: ' \
'-b+[Move existing files by backing up with the extension]:BACKUP_EXTENSION: ' \
'--backup-extension=[Move existing files by backing up with the extension]:BACKUP_EXTENSION: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confirmation]' \
'--ask[Ask for confirmation]' \
'-u[Update flake inputs before building specified configuration]' \
'--update[Update flake inputs before building specified configuration]' \
'--no-nom[Don'\''t use nix-output-monitor for the build process]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':flakeref -- Flake reference to build:_files -/' \
'*::extra_args -- Extra arguments passed to nix build:' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(search)
_arguments "${_arguments_options[@]}" \
'-l+[Number of search results to display]:LIMIT: ' \
'--limit=[Number of search results to display]:LIMIT: ' \
'-c+[Name of the channel to query (e.g nixos-23.11, nixos-unstable)]:CHANNEL: ' \
'--channel=[Name of the channel to query (e.g nixos-23.11, nixos-unstable)]:CHANNEL: ' \
'-f+[Flake to read what nixpkgs channels to search for]:FLAKE:_files -/' \
'--flake=[Flake to read what nixpkgs channels to search for]:FLAKE:_files -/' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
':query -- Name of the package to search:' \
&& ret=0
;;
(clean)
_arguments "${_arguments_options[@]}" \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_nh__clean_commands" \
"*::: :->clean" \
&& ret=0

    case $state in
    (clean)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:nh-clean-command-$line[1]:"
        case $line[1] in
            (all)
_arguments "${_arguments_options[@]}" \
'-k+[At least keep this number of generations]:KEEP: ' \
'--keep=[At least keep this number of generations]:KEEP: ' \
'-K+[At least keep gcroots and generations in this time range since now]:KEEP_SINCE: ' \
'--keep-since=[At least keep gcroots and generations in this time range since now]:KEEP_SINCE: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confimation]' \
'--ask[Ask for confimation]' \
'--nogc[Don'\''t run nix store --gc]' \
'--nogcroots[Don'\''t clean gcroots]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(user)
_arguments "${_arguments_options[@]}" \
'-k+[At least keep this number of generations]:KEEP: ' \
'--keep=[At least keep this number of generations]:KEEP: ' \
'-K+[At least keep gcroots and generations in this time range since now]:KEEP_SINCE: ' \
'--keep-since=[At least keep gcroots and generations in this time range since now]:KEEP_SINCE: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confimation]' \
'--ask[Ask for confimation]' \
'--nogc[Don'\''t run nix store --gc]' \
'--nogcroots[Don'\''t clean gcroots]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(profile)
_arguments "${_arguments_options[@]}" \
'-k+[At least keep this number of generations]:KEEP: ' \
'--keep=[At least keep this number of generations]:KEEP: ' \
'-K+[At least keep gcroots and generations in this time range since now]:KEEP_SINCE: ' \
'--keep-since=[At least keep gcroots and generations in this time range since now]:KEEP_SINCE: ' \
'-n[Only print actions, without performing them]' \
'--dry[Only print actions, without performing them]' \
'-a[Ask for confimation]' \
'--ask[Ask for confimation]' \
'--nogc[Don'\''t run nix store --gc]' \
'--nogcroots[Don'\''t clean gcroots]' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
':profile:_files' \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-s+[Name of the shell]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[Name of the shell]:SHELL:(bash elvish fish powershell zsh)' \
'-v[Show debug logs]' \
'--verbose[Show debug logs]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
        esac
    ;;
esac
}

(( $+functions[_nh_commands] )) ||
_nh_commands() {
    local commands; commands=(
'os:NixOS functionality' \
'home:Home-manager functionality' \
'search:Searches packages by querying search.nixos.org' \
'clean:Enhanced nix cleanup' \
'completions:Generate shell completion files into stdout' \
    )
    _describe -t commands 'nh commands' commands "$@"
}
(( $+functions[_nh__clean__all_commands] )) ||
_nh__clean__all_commands() {
    local commands; commands=()
    _describe -t commands 'nh clean all commands' commands "$@"
}
(( $+functions[_nh__os__boot_commands] )) ||
_nh__os__boot_commands() {
    local commands; commands=()
    _describe -t commands 'nh os boot commands' commands "$@"
}
(( $+functions[_nh__home__build_commands] )) ||
_nh__home__build_commands() {
    local commands; commands=()
    _describe -t commands 'nh home build commands' commands "$@"
}
(( $+functions[_nh__os__build_commands] )) ||
_nh__os__build_commands() {
    local commands; commands=()
    _describe -t commands 'nh os build commands' commands "$@"
}
(( $+functions[_nh__clean_commands] )) ||
_nh__clean_commands() {
    local commands; commands=(
'all:Cleans root profiles and calls a store gc' \
'user:Cleans the current user'\''s profiles and calls a store gc' \
'profile:Cleans a specific profile' \
    )
    _describe -t commands 'nh clean commands' commands "$@"
}
(( $+functions[_nh__completions_commands] )) ||
_nh__completions_commands() {
    local commands; commands=()
    _describe -t commands 'nh completions commands' commands "$@"
}
(( $+functions[_nh__home_commands] )) ||
_nh__home_commands() {
    local commands; commands=(
'switch:Build and activate a home-manager configuration' \
'build:Build a home-manager configuration' \
'info:Show an overview of the installation' \
    )
    _describe -t commands 'nh home commands' commands "$@"
}
(( $+functions[_nh__home__info_commands] )) ||
_nh__home__info_commands() {
    local commands; commands=()
    _describe -t commands 'nh home info commands' commands "$@"
}
(( $+functions[_nh__os__info_commands] )) ||
_nh__os__info_commands() {
    local commands; commands=()
    _describe -t commands 'nh os info commands' commands "$@"
}
(( $+functions[_nh__os_commands] )) ||
_nh__os_commands() {
    local commands; commands=(
'switch:Build and activate the new configuration, and make it the boot default' \
'boot:Build the new configuration and make it the boot default' \
'test:Build and activate the new configuration' \
'build:Build the new configuration' \
'info:Show an overview of the system'\''s info' \
    )
    _describe -t commands 'nh os commands' commands "$@"
}
(( $+functions[_nh__clean__profile_commands] )) ||
_nh__clean__profile_commands() {
    local commands; commands=()
    _describe -t commands 'nh clean profile commands' commands "$@"
}
(( $+functions[_nh__search_commands] )) ||
_nh__search_commands() {
    local commands; commands=()
    _describe -t commands 'nh search commands' commands "$@"
}
(( $+functions[_nh__home__switch_commands] )) ||
_nh__home__switch_commands() {
    local commands; commands=()
    _describe -t commands 'nh home switch commands' commands "$@"
}
(( $+functions[_nh__os__switch_commands] )) ||
_nh__os__switch_commands() {
    local commands; commands=()
    _describe -t commands 'nh os switch commands' commands "$@"
}
(( $+functions[_nh__os__test_commands] )) ||
_nh__os__test_commands() {
    local commands; commands=()
    _describe -t commands 'nh os test commands' commands "$@"
}
(( $+functions[_nh__clean__user_commands] )) ||
_nh__clean__user_commands() {
    local commands; commands=()
    _describe -t commands 'nh clean user commands' commands "$@"
}

if [ "$funcstack[1]" = "_nh" ]; then
    _nh "$@"
else
    compdef _nh nh
fi

#compdef restic
compdef _restic restic

# zsh completion for restic                               -*- shell-script -*-

__restic_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_restic()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16
    local shellCompDirectiveKeepOrder=32

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace keepOrder
    local -a completions

    __restic_debug "\n========= starting completion logic =========="
    __restic_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __restic_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __restic_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., restic -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __restic_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __restic_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __restic_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __restic_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __restic_debug "No directive found.  Setting do default"
        directive=0
    fi

    __restic_debug "directive: ${directive}"
    __restic_debug "completions: ${out}"
    __restic_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __restic_debug "Completion received error. Ignoring completions."
        return
    fi

    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}
    local startIndex=$((${#activeHelpMarker}+1))
    local hasActiveHelp=0
    while IFS='\n' read -r comp; do
        # Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
        if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
            __restic_debug "ActiveHelp found: $comp"
            comp="${comp[$startIndex,-1]}"
            if [ -n "$comp" ]; then
                compadd -x "${comp}"
                __restic_debug "ActiveHelp will need delimiter"
                hasActiveHelp=1
            fi

            continue
        fi

        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab="$(printf '\t')"
            comp=${comp//$tab/:}

            __restic_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    # Add a delimiter after the activeHelp statements, but only if:
    # - there are completions following the activeHelp statements, or
    # - file completion will be performed (so there will be choices after the activeHelp)
    if [ $hasActiveHelp -eq 1 ]; then
        if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
            __restic_debug "Adding activeHelp delimiter"
            compadd -x "--"
            hasActiveHelp=0
        fi
    fi

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __restic_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveKeepOrder)) -ne 0 ]; then
        __restic_debug "Activating keep order."
        keepOrder="-V"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __restic_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __restic_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __restic_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __restic_debug "Calling _describe"
        if eval _describe $keepOrder "completions" completions $flagPrefix $noSpace; then
            __restic_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __restic_debug "_describe did not find completions."
            __restic_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __restic_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __restic_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_restic" ]; then
    _restic
fi
