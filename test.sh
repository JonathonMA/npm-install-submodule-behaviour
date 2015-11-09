#!/bin/sh

announce() {
  if command -v cowsay >/dev/null; then
    echo "$*" | cowsay
  else
    echo ">> $*"
  fi
}

count_react() {
  count=`find node_modules/ -name react | wc -l`
  announce "React Count: $count"
}

rm -rf node_modules/

echo -n "node version: "
node --version
echo -n "npm version: "
npm --version

announce "First: do a plain npm install"
npm install
count_react

announce "Second: install submodule by name"
npm install submodule1
count_react

announce "Finish up with: another plain npm install"
npm install
count_react
