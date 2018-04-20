FROM ibmcom/ibmnode

# Bundle app source
COPY . /app

WORKDIR "/app"

ADD https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 /usr/local/bin/jq
RUN chmod a+x /usr/local/bin/jq

# Install app dependencies
RUN npm install; npm prune --production

# Install bower
RUN npm -g install bower
RUN bower --allow-root install --force

# Move bower folder
RUN mv bower_components/* public/resources

USER root
RUN apt-get update;apt-get install -y openjdk-8-jdk-headless wget openssh-server tar vim

#ssh
RUN echo “root:training” | chpasswd
RUN sed -i ‘s/prohibit-password/yes/’ /etc/ssh/sshd_config
RUN chown -R root:root /root/.ssh;chmod -R 700 /root/.ssh
RUN echo “StrictHostKeyChecking=no” >> /etc/ssh/ssh_config
RUN mkdir /var/run/sshd

ENV NODE_ENV production
ENV PORT 3000

EXPOSE 3000 22
CMD ["npm", "start"]
