FROM mcr.microsoft.com/vscode/devcontainers/python:3.12

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    PATH="/opt/poetry/bin:${PATH}"

# Install Poetry and configure it
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && poetry config virtualenvs.create true \
    && poetry config virtualenvs.in-project true

# Install additional tools and system dependencies
RUN pip install bumpver \
    && apt-get update \
    && apt-get install -y protobuf-compiler \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy initialize Poetry script and set permissions
COPY --chown=vscode:vscode .devcontainer/init-poetry.sh /home/vscode/init-poetry.sh
RUN chmod +x /home/vscode/init-poetry.sh

# Set the default user to vscode
USER vscode

# Set the entrypoint to run our init script
ENTRYPOINT ["/home/vscode/init-poetry.sh"]

# Set the default command
CMD ["/bin/bash"]
