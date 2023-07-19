FROM ayberkt/agda-new:v2.1

COPY entrypoint.sh /entrypoint.sh
COPY get_pandoc.sh /get_pandoc.sh

RUN ["chmod", "+x", "/get_pandoc.sh"]
RUN ["./get_pandoc.sh"]

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
