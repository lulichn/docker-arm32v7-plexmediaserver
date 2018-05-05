FROM arm32v7/busybox as builder
ENV URL="https://downloads.plex.tv/plex-media-server/1.12.3.4973-215c28d86/PlexMediaServer-1.12.3.4973-215c28d86-arm7.spk"
RUN wget $URL -O /tmp/pms.spk \
	&& mkdir -p /usr/lib/plexmediaserver \
	&& tar -xOf /tmp/pms.spk package.tgz | tar -xzf - -C /usr/lib/plexmediaserver/


FROM arm32v7/ubuntu:xenial

MAINTAINER lulichn

COPY --from=builder /usr/lib/plexmediaserver/ /usr/lib/plexmediaserver/

ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/var/lib/plexmediaserver/Library/Application Support" \
	PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
	PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
	PLEX_MEDIA_SERVER_TMPDIR="/tmp"

RUN mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}"

CMD LD_LIBRARY_PATH=/usr/lib/plexmediaserver "/usr/lib/plexmediaserver/Plex Media Server"


