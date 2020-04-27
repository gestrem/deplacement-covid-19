FROM registry.access.redhat.com/ubi8/nodejs-10
WORKDIR /opt/app-root/src
ENV NPM_CONFIG_PREFIX=/opt/app-root/src/.npm-global
ENV PATH=$PATH:/opt/app-root/src.npm-global/bin
COPY package*.json ./


# If running Docker >= 1.13.0 use docker run's --init arg to reap zombie processes, otherwise
# uncomment the following lines to have `dumb-init` as PID 1
# ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
# RUN chmod +x /usr/local/bin/dumb-init
# ENTRYPOINT ["dumb-init", "--"]

# Uncomment to skip the chromium download when installing puppeteer. If you do,
# you'll need to launch puppeteer with:
#     browser.launch({executablePath: 'google-chrome-unstable'})

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Install puppeteer so it's available in the container.
#RUN chown 1001:1001 /opt/src
RUN  npm i puppeteer
RUN  npm i
# Run everything after as non-privileged user.
COPY . .
RUN ls 
EXPOSE 1234
USER root
CMD ["npm","start"]