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
RUN mv bower_components/ public/resources

ENV NODE_ENV production
ENV PORT 3000

EXPOSE 3000
CMD ["npm", "start"]
