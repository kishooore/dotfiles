FROM ubuntu:latest

# Locales
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8

# Timezone
ENV TZ=Asia/Calcutta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Common packages
RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      git  \
      iputils-ping \
      jq \
      libncurses5-dev \
      libevent-dev \
      net-tools \
      netcat-openbsd \
      rubygems \
      ruby-dev \
      silversearcher-ag \
      socat \
      software-properties-common \
      tmux \
	  dos2unix \
      tzdata \
      wget \
	  python3 \
	  python3-pip \
      zsh


# Change default shell
RUN chsh -s /usr/bin/zsh

# Install java11
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    rm -rf /var/cache/oracle-jdk11-installer;

# Install NodeJs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential


# Install neovim 0.5
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN ./squashfs-root/AppRun --version
RUN ln -s /squashfs-root/AppRun /usr/bin/nvim

# install vim-plug
RUN sh -c 'curl -fLo /root/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# tmux plugin manager
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install gradle
RUN wget https://services.gradle.org/distributions/gradle-6.8.2-bin.zip -P /tmp
RUN unzip -d /opt/gradle /tmp/gradle-*.zip
ENV GRADLE_HOME="/opt/gradle/gradle-6.8.2"
ENV PATH="${GRADLE_HOME}/bin:${PATH}"


# Install lombok
RUN mkdir /usr/local/share/lombok \
	&& wget https://projectlombok.org/downloads/lombok.jar -O /usr/local/share/lombok/lombok.jar


# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --key-bindings --completion --update-rc


# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# download jdtls
RUN mkdir -p ~/.config/nvim/lsp/java/jdtls && \
	wget https://ftp.fau.de/eclipse/jdtls/snapshots/jdt-language-server-latest.tar.gz && \
	tar -xf jdt-language-server-latest.tar.gz -C ~/.config/nvim/lsp/java/jdtls && \
	rm jdt-language-server-latest.tar.gz
	
# install java-debug
RUN mkdir -p ~/.config/nvim/lsp/java && \
	cd ~/.config/nvim/lsp/java && \
	git clone https://github.com/microsoft/java-debug.git && \
	cd java-debug && \
	./mvnw clean install && \
	cd ~
	
# install vs-code-test
RUN mkdir -p ~/.config/nvim/lsp/java && \
	cd ~/.config/nvim/lsp/java && \
	git clone https://github.com/microsoft/vscode-java-test.git && \
	cd vscode-java-test && \
	git clean -xdff && \
	npm install && \
	npm run build-plugin && \
	cd ~

# Install angular-cli, angular-language-server
RUN npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d @angular/cli

ENV PATH="~/dotfiles:$PATH"

RUN cd ~ && git clone https://github.com/KishoreGarpati/dotfiles.git 
