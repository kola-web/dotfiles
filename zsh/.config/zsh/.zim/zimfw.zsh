# AUTOMATICALLY GENERATED FILE. EDIT ONLY THE SOURCE FILES AND THEN COMPILE.
# DO NOT DIRECTLY EDIT THIS FILE!

# MIT License
#
# Copyright (c) 2015-2016 Matt Hamilton and contributors
# Copyright (c) 2016-2022 Eric Nielsen, Matt Hamilton and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

autoload -Uz is-at-least && if ! is-at-least 5.2; then
  print -u2 -PR "%F{red}${0}: Error starting Zim. You're using Zsh version %B${ZSH_VERSION}%b and versions < %B5.2%b are not supported. Upgrade your Zsh.%f"
  return 1
fi
autoload -Uz zargs

# Define Zim location
if (( ! ${+ZIM_HOME} )) typeset -g ZIM_HOME=${0:A:h}

_zimfw_print() {
  if (( _zprintlevel > 0 )) print "${@}"
}

_zimfw_mv() {
  local -a cklines
  if cklines=(${(f)"$(command cksum ${1} ${2} 2>/dev/null)"}) && \
      [[ ${${(z)cklines[1]}[1,2]} == ${${(z)cklines[2]}[1,2]} ]]; then
    _zimfw_print -PR "%F{green})%f %B${2}:%b Already up to date"
  else
    if [[ -e ${2} ]]; then
      command mv -f ${2}{,.old} || return 1
    fi
    command mv -f ${1} ${2} && _zimfw_print -PR "%F{green})%f %B${2}:%b Updated.${_zrestartmsg}"
  fi
}

_zimfw_build_init() {
  local -r ztarget=${ZIM_HOME}/init.zsh
  # Force update of init.zsh if it's older than .zimrc
  if [[ ${ztarget} -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    command mv -f ${ztarget}{,.old} || return 1
  fi
  _zimfw_mv =(
    print -R "zimfw() { source ${ZIM_HOME}/zimfw.zsh \"\${@}\" }"
    print -R "zmodule() { source ${ZIM_HOME}/zimfw.zsh \"\${@}\" }"
    # Remove all prefixes from _zfpaths, _zfunctions and _zcmds
    local -r zpre=$'*\0'
    print -R 'typeset -g _zim_fpath=('${${_zfpaths#${~zpre}}:A}')'
    if (( ${#_zfpaths} )) print 'fpath=(${_zim_fpath} ${fpath})'
    if (( ${#_zfunctions} )) print -R 'autoload -Uz -- '${_zfunctions#${~zpre}}
    print -R ${(F)_zcmds#${~zpre}}
  ) ${ztarget}
}

_zimfw_build_login_init() {
  local -r ztarget=${ZIM_HOME}/login_init.zsh
  # Force update of login_init.zsh if it's older than .zimrc
  if [[ ${ztarget} -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    command mv -f ${ztarget}{,.old} || return 1
  fi
  _zimfw_mv =(
    print -nR "# Do nothing. This file is deprecated.
"
  ) ${ztarget}
}

_zimfw_build() {
  _zimfw_build_init && _zimfw_build_login_init && _zimfw_print -P 'Done with build.'
}

zmodule() {
  local -r zusage="Usage: %B${0}%b <url> [%B-n%b|%B--name%b <module_name>] [options]

Add %Bzmodule%b calls to your %B${ZDOTDIR:-${HOME}}/.zimrc%b file to define the modules to be initialized.
The modules are initialized in the same order they are defined.

  <url>                      Module absolute path or repository URL. The following URL formats
                             are equivalent: %Bfoo%b, %Bzimfw/foo%b, %Bhttps://github.com/zimfw/foo.git%b.
  %B-n%b|%B--name%b <module_name>    Set a custom module name. Default: the last component in <url>.
                             Use slashes inside the name to organize the module into subdirec-
                             tories.

Repository options:
  %B-b%b|%B--branch%b <branch_name>  Use specified branch when installing and updating the module.
                             Overrides the tag option. Default: the repository default branch.
  %B-t%b|%B--tag%b <tag_name>        Use specified tag when installing and updating the module. Over-
                             rides the branch option.
  %B-u%b|%B--use%b <%Bgit%b|%Bdegit%b>       Install and update the module using the defined tool. Default is
                             either defined by %Bzstyle ':zim:zmodule' use '%b<%Bgit%b|%Bdegit%b>%B'%b, or %Bgit%b
                             if none is provided.
                             %Bgit%b requires git itself. Local changes are preserved on updates.
                             %Bdegit%b requires curl or wget, and currently only works with GitHub
                             URLs. Modules install faster and take less disk space. Local
                             changes are lost on updates. Git submodules are not supported.
  %B--no-submodules%b            Don't install or update git submodules.
  %B-z%b|%B--frozen%b                Don't install or update the module.
  %B--on-pull%b <command>        Execute command after installing or updating the module. The com-
                             mand is executed in the module root directory.
Initialization options:
  %B-f%b|%B--fpath%b <path>          Add specified path to fpath. The path is relative to the module
                             root directory. Default: %Bfunctions%b, if the subdirectory exists.
  %B-a%b|%B--autoload%b <func_name>  Autoload specified function. Default: all valid names inside the
                             %Bfunctions%b subdirectory, if any.
  %B-s%b|%B--source%b <file_path>    Source specified file. The file path is relative to the module
                             root directory. Default: %Binit.zsh%b, if the %Bfunctions%b subdirectory
                             also exists, or the largest of the files with name matching
                             %B{init.zsh,module_name.{zsh,plugin.zsh,zsh-theme,sh}}%b, if any.
  %B-c%b|%B--cmd%b <command>         Execute specified command. Occurrences of the %B{}%b placeholder in
                             the command are substituted by the module root directory path.
                             I.e., %B-s 'foo.zsh'%b and %B-c 'source {}/foo.zsh'%b are equivalent.
  %B-d%b|%B--disabled%b              Don't initialize or uninstall the module.

  Setting any initialization option above will disable all the default values from the other
  initialization options, so only your provided values are used. I.e. these values are either
  all automatic, or all manual."
  if [[ ${${funcfiletrace[1]%:*}:t} != .zimrc ]]; then
    print -u2 -PlR "%F{red}${0}: Must be called from %B${ZDOTDIR:-${HOME}}/.zimrc%b%f" '' ${zusage}
    return 2
  fi
  if (( ! # )); then
    print -u2 -PlR "%F{red}x ${funcfiletrace[1]}: Missing zmodule url%f" '' ${zusage}
    _zfailed=1
    return 2
  fi
  local zurl=${1} zname=${1:t} zarg
  local -a zfpaths zfunctions zcmds
  if [[ ${zurl} =~ ^[^:/]+: ]]; then
    zname=${zname%.git}
  elif [[ ${zurl} != /* ]]; then
    # Count number of slashes
    case ${#zurl//[^\/]/} in
      0) zurl=https://github.com/zimfw/${zurl}.git ;;
      1) zurl=https://github.com/${zurl}.git ;;
    esac
  fi
  shift
  while [[ ${1} == (-n|--name) ]]; do
    if (( # < 2 )); then
      print -u2 -PlR "%F{red}x ${funcfiletrace[1]}:%B${zname}:%b Missing argument for zmodule option %B${1}%b%f" '' ${zusage}
      _zfailed=1
      return 2
    fi
    shift
    zname=${${1%%/##}##/##}
    shift
  done
  if [[ ${zurl} == /* ]]; then
    _zdirs[${zname}]=${zurl%%/##}
    zurl=
  else
    _zdirs[${zname}]=${ZIM_HOME}/modules/${zname}
  fi
  _zurls[${zname}]=${zurl}
  # Set default values
  if (( ! ${+_ztools[${zname}]} )); then
    zstyle -s ':zim:zmodule' use "_ztools[${zname}]" || _ztools[${zname}]=git
  fi
  if (( ! ${+_ztypes[${zname}]} )) _ztypes[${zname}]=branch
  if (( ! ${+_zsubmodules[${zname}]} )) _zsubmodules[${zname}]=1
  # Set values from options
  while (( # > 0 )); do
    case ${1} in
      -b|--branch|-t|--tag|-u|--use|--on-pull|-f|--fpath|-a|--autoload|-s|--source|-c|--cmd)
        if (( # < 2 )); then
          print -u2 -PlR "%F{red}x ${funcfiletrace[1]}:%B${zname}:%b Missing argument for zmodule option %B${1}%b%f" '' ${zusage}
          _zfailed=1
          return 2
        fi
        ;;
    esac
    case ${1} in
      -b|--branch|-t|--tag|-u|--use|--no-submodules)
        if [[ -z ${zurl} ]] _zimfw_print -u2 -PR "%F{yellow}! ${funcfiletrace[1]}:%B${zname}:%b The zmodule option %B${1}%b has no effect for external modules%f"
        ;;
    esac
    case ${1} in
      -b|--branch)
        shift
        _ztypes[${zname}]=branch
        _zrevs[${zname}]=${1}
        ;;
      -t|--tag)
        shift
        _ztypes[${zname}]=tag
        _zrevs[${zname}]=${1}
        ;;
      -u|--use)
        shift
        _ztools[${zname}]=${1}
        ;;
      --no-submodules) _zsubmodules[${zname}]=0 ;;
      -z|--frozen) _zfrozens[${zname}]=1 ;;
      --on-pull)
        shift
        _zonpulls[${zname}]="${_zonpulls[${zname}]+${_zonpulls[${zname}]}; }${1}"
        ;;
      -f|--fpath)
        shift
        zarg=${1}
        if [[ ${zarg} != /* ]] zarg=${_zdirs[${zname}]}/${zarg}
        zfpaths+=(${zarg})
        ;;
      -a|--autoload)
        shift
        zfunctions+=(${1})
        ;;
      -s|--source)
        shift
        zarg=${1}
        if [[ ${zarg} != /* ]] zarg=${_zdirs[${zname}]}/${zarg}
        zcmds+=("source ${zarg:A}")
        ;;
      -c|--cmd)
        shift
        zcmds+=(${1//{}/${_zdirs[${zname}]:A}})
        ;;
      -d|--disabled) _zdisableds[${zname}]=1 ;;
      *)
        print -u2 -PlR "%F{red}x ${funcfiletrace[1]}:%B${zname}:%b Unknown zmodule option %B${1}%b%f" '' ${zusage}
        _zfailed=1
        return 2
        ;;
    esac
    shift
  done
  if (( _zflags & 1 )); then
    _znames+=(${zname})
  fi
  if (( _zflags & 2 )); then
    if (( _zdisableds[${zname}] )); then
      _zdisabled_dirs+=(${_zdirs[${zname}]})
    else
      if [[ ! -e ${_zdirs[${zname}]} ]]; then
        print -u2 -PR "%F{red}x ${funcfiletrace[1]}:%B${zname}: ${_zdirs[${zname}]}%b not found%f"
        _zfailed=1
        return 1
      fi
      if (( ! ${#zfpaths} && ! ${#zfunctions} && ! ${#zcmds} )); then
        zfpaths=(${_zdirs[${zname}]}/functions(NF))
        # _* functions are autoloaded by compinit
        # prompt_*_setup functions are autoloaded by promptinit
        zfunctions=(${^zfpaths}/^(*~|*.zwc(|.old)|_*|prompt_*_setup)(N-.:t))
        local -ra prezto_scripts=(${_zdirs[${zname}]}/init.zsh(N))
        if (( ${#zfpaths} && ${#prezto_scripts} )); then
          # this follows the prezto module format, no need to check for other scripts
          zcmds=('source '${^prezto_scripts:A})
        else
          # get script with largest size (descending `O`rder by `L`ength, and return only `[1]` first)
          local -ra zscripts=(${_zdirs[${zname}]}/(init.zsh|${zname:t}.(zsh|plugin.zsh|zsh-theme|sh))(NOL[1]))
          zcmds=('source '${^zscripts:A})
        fi
      fi
      if (( ! ${#zfpaths} && ! ${#zfunctions} && ! ${#zcmds} )); then
        _zimfw_print -u2 -PlR "%F{yellow}! ${funcfiletrace[1]}:%B${zname}:%b Nothing found to be initialized. Customize the module name or initialization with %Bzmodule%b options.%f" '' ${zusage}
      fi
      # Prefix is added to all _zfpaths, _zfunctions and _zcmds to distinguish the originating names
      local -r zpre=${zname}$'\0'
      _zfpaths+=(${zpre}${^zfpaths})
      _zfunctions+=(${zpre}${^zfunctions})
      _zcmds+=(${zpre}${^zcmds})
    fi
  fi
}

_zimfw_source_zimrc() {
  local -r ztarget=${ZDOTDIR:-${HOME}}/.zimrc _zflags=${1}
  local -i _zfailed=0
  if ! source ${ztarget} || (( _zfailed )); then
    print -u2 -PR "%F{red}Failed to source %B${ztarget}%b%f"
    return 1
  fi
  if (( _zflags & 1 && ${#_znames} == 0 )); then
    print -u2 -PR "%F{red}No modules defined in %B${ztarget}%b%f"
    return 1
  fi
}

_zimfw_list_unuseds() {
  local -i i=1
  local -a zinstalled=(${ZIM_HOME}/modules/*(N/))
  local -ar zdirs=(${(v)_zdirs})
  # Search into subdirectories
  while (( i <= 