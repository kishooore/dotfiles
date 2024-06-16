function noti
    if test $status -eq 0
        say finished
    else
        say error
    end
end

function remove_buckets
    if test -z "$argv[1]"
        echo "Usage: remove_buckets <deployment name>"
        return
    end

    if test -z "$AWS_PROFILE"
        echo "AWS_PROFILE not set; using default profile"
    else
        echo "Using AWS_PROFILE $AWS_PROFILE"
    end

    echo "Using prefix $argv[1]"
    for bucket in (aws s3api list-buckets --query "Buckets[].Name" | grep "\"$argv[1]-cloudera\|$argv[1]-sigma-dev\"" | awk -F\" '{print $2}')
        aws s3 rb s3://$bucket --force
    end
end

function remove_tables
    if test -z "$argv[1]"
        echo "Usage: remove_tables <deployment name>"
        return
    end

    if test -z "$AWS_PROFILE"
        echo "AWS_PROFILE not set; using default profile"
    else
        echo "Using AWS_PROFILE $AWS_PROFILE"
    end

    echo "Using prefix $argv[1]"
    set OLDIFS $IFS
    set -x IFS ,

    set output (aws dynamodb list-tables)
    while true
        set token (echo $output | grep NextToken | awk -F\" '{print $4}')
        for line in $output
            set table (echo $line | grep "App$argv[1]-Sigma" | awk -F\" '{print $2}')
            if test -n "$table"
                echo "Deleting table $table..."
                aws dynamodb delete-table --table-name $table
            end
        end
        if test -n "$token"
            set output (aws dynamodb list-tables --starting-token $token)
        else
            break
        end
    end

    set -x IFS $OLDIFS
end

function load_nvm
    set -x NVM_DIR $HOME/.nvm
    # NVM Configuration
    test -s "/opt/homebrew/opt/nvm/nvm.sh"; and source "/opt/homebrew/opt/nvm/nvm.sh"
    test -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"; and source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
end

function load_pyenv
    # Pyenv Configuration
    pyenv global 3.8.16
    pyenv init - | source
    pyenv virtualenv-init - | source
    set -x PATH $PYENV_ROOT/bin $PATH
    set -x PATH (pyenv root)/shims $PATH
end

function load_sdkman
    # SDKMAN Configuration
    test -s "$HOME/.sdkman/bin/sdkman-init.sh"; and source "$HOME/.sdkman/bin/sdkman-init.sh"
end

