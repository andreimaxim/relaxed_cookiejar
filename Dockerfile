FROM ruby:2.4.2

# Bundler options
#
# The default value is taken from Travis's build options, so they should be
# good enough for most cases. For development, be sure to set a blank default
# in docker-compose.override.yml.
ARG BUNDLER_OPTS="--jobs=3 \
                  --retry=3 \
                  --deployment"

# The home directory of the gem.
#
# During development, make sure that the APP_DIR environment variable is
# identical to the variable in your docker-compose.override.yml file,
# otherwise things might not work as expected.
ENV APP_DIR="/opt/relaxed_cookiejar"

# Install required packages
# RUN apt-get update -y \
#       && apt-get install -y --no-install-recommends \
#         git-core \
#         build-essential \
#         libffi-dev \
#         libxml2-dev \
#         libssl-dev \
#         libcurl4-gnutls-dev \
#         apt-utils \
#       && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN groupadd -r travis \
    && useradd -m -r -g travis travis
RUN mkdir -p ${APP_DIR} \
    && chown -R travis:travis ${APP_DIR}

# Move the the application folder to perform all the following tasks.
WORKDIR ${APP_DIR}
# Use the non-root user to perform any commands from this point forward.
#
# NOTE: The COPY command requires the --chown flag set otherwise it will
#       copy things as root.
USER travis

# Copy the gem's gemspec file so `bundle install` can run when the
# container is initialized.
#
# The added benefit is that Docker will cache this file and will not trigger
# the bundle install unless the gemspec changed on the filesystem.
#
# NOTE: If the command fails because of the --chown flag, make sure you have a
#       recent stable version of Docker.
COPY --chown=travis:travis . ./


RUN bundle install ${BUNDLER_OPTS}

# Copy over the files, in case the Docker Compose file does not specify a
# mount point.
COPY --chown=travis:travis . ./

CMD ["bash"]