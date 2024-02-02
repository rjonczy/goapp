FROM scratch
COPY goapp /goapp
ENTRYPOINT ["/goapp"]