FROM alpine:3.2
MAINTAINER Ash Wilson <smashwilson@gmail.com>

RUN apk add --update nodejs git && rm -rf /var/cache/apk/*

RUN npm install -g coffee-script
RUN adduser -D -s /bin/sh pushbot
RUN mkdir -p /usr/src/app /usr/src/app/botdata /home/pushbot/.ssh/

WORKDIR /usr/src/app
ADD package.json /usr/src/app/package.json
RUN npm install .
ADD . /usr/src/app
RUN chown -R pushbot:pushbot /usr/src/app

USER pushbot
ENTRYPOINT ["/usr/src/app/bin/pushbot-slack"]
