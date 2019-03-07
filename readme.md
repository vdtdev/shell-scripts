# Useful Shell Scripts

_Collection of development-related shell scripts_

## Overview

This repo contains various shell scripts I've written that could potentially be useful to someone else. Potentially. They are either regular bash shell scripts, or ruby scripts with `#!/usr/bin/env ruby` headers.

## Scripts

### sh-promote.sh

- Takes in two parameters; the first is the name of a shell script (e.g. script.sh), the second is the name of the executable script file to be created
- Basically copies source .sh file and makes copy executable with chmod, but has usage info for fun
- Use it on itself to make a version you can stick in your user bin folder so it can be used anywhere

### rvm-cfg.rb

- Ruby script that creates/replaces RVM `.ruby-version` and `.ruby-gemset` files
- Can take version and gemset name as two separate parameters, both together separated with `@` (`1.2.3@tools`), or just a version number
- Including `--overwrite` switch will (_duh_) cause existing config files to be overwritten; if used when not specifying a gemset name, existing `.ruby-gemset` file will be deleted, if present
- Promote it to an executable with `sh-promote` and stick in your user bin folder; will correctly place generated files in working directory when command is executed

## License

Released under MIT license.

(c) 2019, Wade H (vdtdev.prod@gmail.com)