#!/usr/bin/env bats

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/

# TODO:
# @test "Running a script that uses XPath capture when libxmljs is not installed produces a warning" {
#     if [[ ! -z `find . -name "artillery-xml-capture" -type d` ]]; then
#       find . -name "artillery-xml-capture" -type d | xargs rm -r
#     fi
#     ./bin/run run --config ./test/scripts/hello_config.json ./test/scripts/hello_with_xpath.json  | grep 'artillery-xml-capture'
#     grep_status=$?
#     npm install artillery-xml-capture || true
#     [ $grep_status -eq 0 ]
# }

# TODO: Rewrite without quick
# @test "Clean up when killed" {
#   MULTICORE=1 ARTILLERY_WORKERS=4 ./bin/run quick -d 120 -r 1 http://localhost:3003/ &
#   artillery_pid=$!
#   sleep 5
#   kill $artillery_pid
#   sleep 4
#   [[ -z $(pgrep -lfa node | grep worker.js) ]]
# }

# Ref: https://github.com/shoreditch-ops/artillery/issues/215
@test "GH #215 regression" {
  ./bin/run run test/scripts/gh_215_add_token.json
  [[ true ]]
}

@test "Exits with non zero when an unknown command is used" {
    run ./bin/run makemeasandwich --with cheese
    [[ $status -ne 0 ]]
}

@test "Exits with non-zero when an unknown option is used" {
    run ./bin/run run --sandwich ploughmans
    [[ $status -ne 0 ]]
}

@test "Exits with 0 when a known flag used with no command" {
    run ./bin/run -V
    [[ $status -eq 0 ]]
}
