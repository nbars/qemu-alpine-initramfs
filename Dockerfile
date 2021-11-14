ARG BRANCH

FROM alpine:$BRANCH

COPY init login packages.list /
RUN apk add bkeymaps vim bash $(cat /packages.list | xargs)
RUN rm /packages.list