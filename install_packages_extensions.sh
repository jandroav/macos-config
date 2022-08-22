#!/bin/bash

xargs brew install --force-bottle < brew_packages.txt

cat vscode_extensions.txt | while read extension || [[ -n $extension ]];
do
  code --install-extension $extension --force
done
