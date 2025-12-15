# Dockerfile for beets-flask-full
# Based on pspitzner/beets-flask

FROM pspitzner/beets-flask:stable

# Maintainer information
LABEL maintainer="beets-flask-full"
LABEL description="Custom image of beets-flask with additional features"

# Switch to root to install additional packages
USER root

# Add any additional system packages here
# RUN apk add --no-cache <additional-packages>

# Add any custom Python packages here
# RUN pip install --no-cache-dir <additional-python-packages>

# Copy any custom configuration files or scripts
# COPY ./custom-scripts/ /repo/custom-scripts/

# Ensure proper permissions
RUN chown -R beetle:beetle /repo

# Switch back to beetle user
USER beetle

# The base image already has an ENTRYPOINT, no need to override
