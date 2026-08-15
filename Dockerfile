FROM ghcr.io/appleboy/drone-telegram:1.4.0@sha256:c026c8f95b925c4771fb44fee1ead2235b5b8f84abc47d09465f599c16808557

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /github/workspace

ENTRYPOINT ["/entrypoint.sh"]
