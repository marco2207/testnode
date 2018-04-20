FROM ibmcom/ibmnode

WORKDIR "/app"

# Install app dependencies
COPY package.json /app/
RUN cd /app; npm install; npm prune --production

# Bundle app source
COPY . /app

ADD https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 /usr/local/bin/jq
RUN chmod a+x /usr/local/bin/jq

ENV NODE_ENV production
ENV PORT 3000

EXPOSE 3000
CMD ["npm", "start"]
