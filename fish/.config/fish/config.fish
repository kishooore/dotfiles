# Set environment variables
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /usr/local/bin $PATH
set -x MOW_AUTH_TOOL none
set -x SDKMAN_DIR $HOME/.sdkman
set -x JAVA_HOME $HOME/.sdkman/candidates/java/current
set -x pyenv_root $HOME/.pyenv
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x TARGETROOT ""
set -x MVN_NO_DOCKER 1
set -x PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
set -x PS_INFRA_NM kishore
set -x PS_DEPLOY_NM kishore
set -x DEV_KEY_PATH $HOME/dev/access.key
set -x DEV_ADMIN_KEY_PATH $HOME/dev/admin.key
set -x THUNDERHEAD_YARN_DEV_CERT $HOME/cacerts/localhost.altus.cloudera.com/cert.pem
set -x THUNDERHEAD_YARN_DEV_KEY $HOME/cacerts/localhost.altus.cloudera.com/key.pem
set -x TFENV_ARCH amd64
set -x PYENV_VIRTUALENV_DISABLE_PROMPT 1

# Aliases
alias vim="nvim"
alias vi="nvim"

# Functions
source $HOME/.config/fish/functions.fish

# Misc
eval (starship init fish | source)
eval (zoxide init fish | source)
fish_vi_key_bindings

# accept auto suggestion
bind \ce accept-autosuggestion
