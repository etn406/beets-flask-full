# beets-flask-full

Custom Docker image of beets-flask with additional features

## About

This project provides a custom Docker image based on [pspitzner/beets-flask](https://github.com/pSpitzner/beets-flask), an opinionated web interface for the music organizer [beets](https://beets.io/). The image can be extended with additional features and customizations as needed.

## Features

All features from the base beets-flask image:
- Autogenerate previews before importing
- Auto-Import good matches
- Import via GUI
- Undo imports
- Web-Terminal
- Monitor multiple inboxes
- Library view and search

Plus additional customizations (add your custom features here).

## Quick Start

### Prerequisites

- Docker and Docker Compose installed on your system
- Basic understanding of Docker and beets

### Using Docker Compose (Recommended)

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd beets-flask-full
   ```

2. Create required directories:
   ```bash
   mkdir -p config music/inbox music/imported
   ```

3. Adjust the `docker-compose.yaml` file:
   - Set your timezone in the `TZ` environment variable
   - Set `USER_ID` and `GROUP_ID` to match your host system (run `id` to find yours)
   - Adjust volume paths to match your music library structure

4. Build and start the container:
   ```bash
   docker-compose up -d
   ```

5. Access the web interface at: http://localhost:5001

### Using Docker CLI

Build the image:
```bash
docker build -t beets-flask-full:latest .
```

Run the container:
```bash
docker run -d -p 5001:5001 \
    -e TZ=Europe/Berlin \
    -e USER_ID=1000 \
    -e GROUP_ID=1000 \
    -v $(pwd)/config:/config \
    -v $(pwd)/music/inbox:/music/inbox \
    -v $(pwd)/music/imported:/music/imported \
    --name beets-flask-full \
    beets-flask-full:latest
```

## Configuration

### Directory Structure

After starting the container, the following structure will be created:

```
├── music/
│   ├── inbox/          # Place music files here for import
│   └── imported/       # Organized music will be stored here
└── config/
    ├── beets/
    │   ├── config.yaml        # Beets configuration
    │   └── library.db         # Beets library database
    └── beets-flask/
        ├── config.yaml        # Beets-flask configuration
        └── beets-flask-sqlite.db  # Beets-flask database
```

### Beets Configuration

The beets configuration file is located at `./config/beets/config.yaml`. You can customize it according to the [beets documentation](https://beets.readthedocs.io/).

### Beets-Flask Configuration

The beets-flask configuration file is located at `./config/beets-flask/config.yaml`. Refer to the [beets-flask documentation](https://beets-flask.readthedocs.io/) for available options.

## Customization

To add additional features or packages to this image:

1. Edit the `Dockerfile`:
   - Uncomment and modify the system packages section to add Alpine packages
   - Uncomment and modify the Python packages section to add Python dependencies
   - Add custom scripts or configuration files as needed

2. Rebuild the image:
   ```bash
   docker-compose build
   ```

3. Restart the container:
   ```bash
   docker-compose up -d
   ```

## Updating

To update to the latest base image:

```bash
docker-compose pull
docker-compose up -d
```

To rebuild with the latest base image:

```bash
docker-compose build --pull
docker-compose up -d
```

## Troubleshooting

### Permission Issues

If you encounter permission issues, ensure that:
- `USER_ID` and `GROUP_ID` in `docker-compose.yaml` match your host user
- The `config` and `music` directories have appropriate permissions

### Port Already in Use

If port 5001 is already in use, change it in `docker-compose.yaml`:
```yaml
ports:
  - "5002:5001"  # Map to a different host port
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project inherits the MIT License from [pspitzner/beets-flask](https://github.com/pSpitzner/beets-flask).

## Acknowledgments

- [beets](https://beets.io/) - The music organizer
- [pspitzner/beets-flask](https://github.com/pSpitzner/beets-flask) - The base Docker image and web interface

## Resources

- [Beets Documentation](https://beets.readthedocs.io/)
- [Beets-Flask Documentation](https://beets-flask.readthedocs.io/)
- [Docker Documentation](https://docs.docker.com/)
