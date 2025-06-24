#!/bin/bash
# vim: ts=3 expandtab shiftwidth=3:

jq '
def remove_dup(arr):
  reduce .[] as $item ([]; if any(.[]; .name == $item.name) then . else . + [$item] end);


walk(if type == "object" and has("parameters") then .parameters |= remove_dup(.parameters) else . end)' "$1"

