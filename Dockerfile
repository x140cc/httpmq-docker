FROM alpine
ADD . /
ENV ORG_PATH="github.com/x140cc/httpmq"
ENV REPO_PATH="${ORG_PATH}"
RUN apk --update add go git \
  && export GOPATH=/gopath \
  && go get ${ORG_PATH} \
  && mkdir -p $GOPATH/src/${ORG_PATH} \
  && cd $GOPATH/src/${ORG_PATH} \
  && CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags "-s" -o /httpmq ${REPO_PATH} \
  && apk del go git \
  && rm -rf $GOPATH /var/cache/apk/* \
EXPOSE 1218
CMD /httpmq -auth="208326" -ip="0.0.0.0"
~
