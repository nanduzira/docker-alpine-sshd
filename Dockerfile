FROM alpine:latest

LABEL maintainer="Anand Krishna Sunil"

# add openssh and clean
RUN apk add --update openssh \
    && rm  -rf /tmp/* /var/cache/apk/* \
    && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && echo "root:root" | chpasswd

# add entrypoint script
ADD docker-entrypoint.sh /

#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

EXPOSE 22
ENTRYPOINT [ "/docker-entrypoint.sh" ]
