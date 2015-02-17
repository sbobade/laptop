#!/bin/sh

SECILC=/home/kcinimod/bin/secilc
VERSION=29

test -d policy || /bin/mkdir -m 0700 policy

EXCLUDE="tests"

gen_listing () {
    local MODULES=$(/bin/find . -type f \( -iname "*.cil" \) | /bin/cut -d/ -f2-)

    for i in ${EXCLUDE} ;
        do
            MODULES=$(printf "%s\n" "${MODULES}" | /bin/grep -v $i)
        done

    printf "%s\n" "${MODULES}" | /bin/sort > LISTING
}

${SECILC} -v \
    $(test -f LISTING || gen_listing && /bin/cat LISTING) \
    $* \
    -o policy/policy.${VERSION} -f contexts/files/file_contexts

#EOF
