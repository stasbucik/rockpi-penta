# Use the slimmest official Debian image
FROM debian:stable-slim

# Define build-time arguments for UID and GID
ARG USER_ID=1000
ARG GROUP_ID=1000

# Install dpkg-dev (contains dpkg-deb) and clean up to keep it minimal
RUN apt-get update && apt-get install -y \
    dpkg-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a group and user matching the host's IDs
# We use 'builder' as a generic name
RUN groupadd -g ${GROUP_ID} builder && \
    useradd -l -u ${USER_ID} -g builder -m builder

# Set the working directory
WORKDIR /workspace

# Switch to the non-root user
USER builder

# Default command
CMD ["dpkg-deb", "--build", "source_dir"]
