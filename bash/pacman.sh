pacs() {
    local CL='\\e['
    local RS='\\e[0;0m'

    echo -e "$(pacman -Ss "$@" | sed "
        /^core/     s,.*,${CL}1;31m&${RS},
        /^extra/    s,.*,${CL}0;32m&${RS},
        /^community/    s,.*,${CL}1;35m&${RS},
        /^[^[:space:]]/ s,.*,${CL}0;36m&${RS},
    ")"
]]'}

