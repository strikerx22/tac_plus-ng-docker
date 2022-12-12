# Build Image - Downloads all dependencies, source code, then compiles
FROM alpine as build

# Download everything for build environment
RUN apk update \
&& apk add build-base bzip2 perl perl-digest-md5 perl-ldap perl-io-socket-ssl bash git clang gcc flex bison pcre-dev \
&& apk add zlib curl make perl-regexp-tr pcre pcre2 pcre-dev

# Change Shell to Bash now that it's installed
SHELL ["/bin/bash", "-c"]

# Download Source Code - Current Master Branch
RUN git clone https://github.com/MarcJHuber/event-driven-servers.git

# Roll back to known-compilable source code
RUN cd /event-driven-servers \
&& git checkout 8b130c7 \
# Compile and Install
&& ./configure --prefix=/tpng tac_plus-ng \
&& make \
&& make install

#####################################################################################
# Build Application container without the extra packages
FROM alpine

# Update Base packages and Install other required ones
RUN apk update \
&& apk add perl perl-digest-md5 perl-ldap perl-io-socket-ssl bash pcre pcre2
SHELL ["/bin/bash", "-c"]

# Copy binaries from Build Container into App Container
COPY --from=build /tpng /tpng

# Copy Docker Entrypoint into new container
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Expose default TACACS Port 49
EXPOSE 49

# Define Docker Entrypoint for Error Checking, etc. 
ENTRYPOINT ["/docker-entrypoint.sh"]
