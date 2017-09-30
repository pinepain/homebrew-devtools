pinepain/devtools [![Build Status](https://travis-ci.org/pinepain/homebrew-devtools.svg?branch=master)](https://travis-ci.org/pinepain/homebrew-devtools)
====================

This is a [homebrew](http://brew.sh/) [tap](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/brew-tap.md)
with various formulae I use for development.

See [pinepain/ppa-packaging](https://github.com/pinepain/ppa-packaging) repository for Ubuntu PPA packaging.

### PLEASE READ:

Maintaining this project takes significant amount of time and efforts.
If you like my work and want to show your appreciation, please consider supporting me at https://www.patreon.com/pinepain.


### Requirements:

The [Homebrew PHP](https://github.com/Homebrew/homebrew-php) tap - `brew tap homebrew/php`.

If you don't have it installed, see [homebrew/php tap requirements](https://github.com/Homebrew/homebrew-php#requirements)
in advance.

## Installation.

Just `brew tap pinepain/devtools` and then `brew install <formula>`.

If the formula conflicts with one from another tap, you can `brew install `pinepain/devtools/<formula>`.

You can also install via URL: `brew install https://raw.github.com/pinepain/homebrew-devtools/master/Formula/<formula>.rb`


## Provided tools:

### [git-subsplit](https://github.com/dflydev/git-subsplit)
 
`git subsplit` automate and simplify the process of managing one-way read-only git subtree splits.

Available formulae:
 - `git-subsplit`

### [V8 JavaScript engine](https://developers.google.com/v8) 

V8 is a Google's high performance, open source, JavaScript engine. 

Available formulae:
 - `v8@5.7`

This formula family is based on [v8](https://github.com/Homebrew/homebrew-core/blob/master/Formula/v8.rb) formula from
[homebrew-core](https://github.com/Homebrew/homebrew-core), but diverge from it to fit [php-v8](https://github.com/pinepain/php-v8)
needs and stay on a bleeding edge. This is keg-only, co-installable formula, so you can install it alongside system `v8`
or any other `v8@*` formulae.

All `v8@*` formula build vanilla V8 JavaScript Engine as component with icu support (via external file for now)
without debug flag set.

### [php-v8](https://github.com/pinepain/php-v8)  

[php-v8](https://github.com/pinepain/php-v8) is PHP extension for V8 JavaScript engine
 
Available formulae:
 - `php70-v8`
 - `php71-v8`

## License

Formulae under [pinepain/devtools](https://github.com/pinepain/homebrew-devtools) licensed under the [MIT license](http://opensource.org/licenses/MIT).
