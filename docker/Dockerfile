FROM victorhsouzavieira/base_container_with_ruby:v1

ENV APPLICATION_NAME=stock-management-api

RUN adduser mananger --disabled-password --gecos "" && \
    sh -c "echo 'mananger ALL=NOPASSWD: ALL' >> /etc/sudoers"

USER mananger

RUN echo 'export PS1="\[\\033[38m\]\u\[\\033[32m\] \w\[\\033[31m\]\`git branch 2>/dev/null | grep \"^\*\" | sed -r \"s/\*\ (.*)/ \(\\1\)/\"\`\[\\033[37m\]$\[\\033[00m\] "' >> /home/mananger/.bashrc

WORKDIR /var/www/html/$APPLICATION_NAME
