# Use a Red Hat Universal Base Image (UBI) as the starting point
# UBI 9 is based on RHEL 9 and is freely redistributable
FROM registry.access.redhat.com/ubi9/ubi:latest

# Good practice: Label your image
LABEL maintainer="Your Name <your.email@example.com>" \
      version="1.0" \
      description="My custom RHEL application image."

# Install necessary software, e.g., httpd
# The --disableplugin=subscription-manager flag is needed for UBI images
RUN dnf install -y httpd --disableplugin=subscription-manager && \
    dnf clean all

# Copy your application source code or pre-built binaries
COPY ./app-source/ /var/www/html/

# Expose the port the application will run on
EXPOSE 8080

# It's a security best practice for OpenShift to run as a non-root user.
# The UBI images have a default non-root user (user 1001).
USER 1001

# Command to run when the container starts
CMD ["httpd", "-D", "FOREGROUND"]
