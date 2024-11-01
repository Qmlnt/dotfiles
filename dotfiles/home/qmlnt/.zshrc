
#----------------------------------
#     From zsh-newuser-install
#----------------------------------

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=50000
setopt autocd beep notify
unsetopt nomatch
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' format '> Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %l (%p): Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%e errors found'
zstyle ':completion:*' select-prompt '%SScrolling %l at %p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/qmlnt/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


#----------------------------------
#          Some tweaks
#----------------------------------

# fix terminal
autoload -Uz add-zsh-hook
function reset_broken_terminal () {
	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}
add-zsh-hook -Uz precmd reset_broken_terminal

# rehash after pacman operations
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd

# clear the upper buffer
function clear-screen-and-scrollback() {
    echoti civis >"$TTY"
    printf '%b' '\e[H\e[2J' >"$TTY"
    zle .reset-prompt
    zle -R
    printf '%b' '\e[3J' >"$TTY"
    echoti cnorm >"$TTY"
}
zle -N clear-screen-and-scrollback
bindkey '^_' clear-screen-and-scrollback # ctrl+/

# exit even if there is text typed
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh


#----------------------------------
#            Keybinds
#----------------------------------

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Show past commands which match current line up to the cursor
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

bindkey '^P' up-line-or-beginning-search
bindkey '^E' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo are valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


#----------------------------------
#        Interactive things
#----------------------------------

export LS_COLORS='di=1;36'
export MANPAGER='nvim +Man!'

path+=('/home/qmlnt/.local/bin' '/home/qmlnt/.cabal/bin' '/home/qmlnt/.ghcup/bin' '/home/qmlnt/.cargo/bin')

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

alias H='Hyprland'
alias audio='yt-dlp -x --embed-thumbnail --embed-chapters -o "~/Music/%(title)s.%(ext)s"'
alias playlist='yt-dlp -x --embed-thumbnail --embed-chapters -o "%(title)s.%(ext)s"'
alias ffmpg='ffmpeg -hide_banner'
alias ffprb='ffprobe -hide_banner'
alias mpvh='mpv --hwdec=auto'
alias mpvs='mpv --hwdec=auto --sub-file-paths=sub --sub-fonts-dir=sub/fonts'
alias kickstart='NVIM_APPNAME=nvim-kickstart nvim "$@"'
alias nvimdiff='nvim -d' # "$@"'
alias chat='OLLAMA_NOHISTORY=y ollama run --nowordwrap'

alias sudo='doas'
alias cp='cp -iv'
alias rm='rm -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir="mkdir -v"
alias rmdir='rmdir -v'
alias chmod="chmod -c"
alias chown="chown -c"
alias grep='grep --color=auto'
alias egrep='grep --color=auto -E'

alias ls="ls --color=auto --hyperlink=auto --group-directories-first -F"
alias ll="ls --color=auto --hyperlink=auto --group-directories-first -Flh"
alias la="ls --color=auto --hyperlink=auto --group-directories-first -Flah"

# alias rcp='rsync -v --progress'
# alias rmv='rsync -v --progress --remove-source-files'
alias notify="/home/qmlnt/Programming/bash/notifier.sh &!"
#alias backup="sudo -k ~/Programming/Python/qncm/qncm.py -if ~/Programming/Python/qncm/list --to /home/qmlnt/Backups/main_backup"


#----------------------------------
#               Look
#----------------------------------

PROMPT="%F{87}%n%f%F{69}@%f%F{135}%M%f %F{39}%T%f %F{214}%1d%f %F{111}%?%f%F{51}$%f "
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
