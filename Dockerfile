FROM ayberkt/agda:v14

COPY entrypoint.sh /entrypoint.sh
COPY setup.sh      /setup.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]