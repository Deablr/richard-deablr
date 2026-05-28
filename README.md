# Richard Deablr Minecraft Server

A small creative Minecraft server running Paper 26.1.2, deployed via Dokploy.

## What's Inside

- **Docker Compose** configuration for `itzg/minecraft-server`
- **Paper 26.1.2** with Minecraft year-based versioning (26.x)
- **WorldEdit** pre-installed
- **Flat world**, no mobs, no nether — optimized for creative building
- **Whitelist + OPs** pre-configured

## Requirements

- Hostinger VPS with Docker & Docker Compose installed
- [Dokploy](https://dokploy.com) installed on the server
- `world.zip` (kept out of Git, uploaded separately)

## Initial Server Setup

Before deploying, SSH into your Hostinger server and create the persistent data directory:

```bash
sudo mkdir -p /opt/richard-deablr/data
sudo chown -R $USER:$USER /opt/richard-deablr
```

## Deploying with Dokploy

1. In Dokploy, create a new **Compose** project
2. Connect this Git repository
3. Dokploy will automatically run `docker compose up -d`
4. The server data persists in `/opt/richard-deablr/data` across redeploys

## Uploading the World

> **Important:** Upload your world **before** the first start, or be prepared to replace auto-generated worlds after.

### Before First Start (Recommended)

```bash
# On your Hostinger server
cd /opt/richard-deablr/data
unzip /path/to/world.zip
# Ensure the folder is named exactly 'world'
```

### After First Start

If the server already generated fresh worlds:

```bash
# Stop the container first
docker compose -f /path/to/your/compose.yml down

# Remove auto-generated worlds
rm -rf /opt/richard-deablr/data/world
rm -rf /opt/richard-deablr/data/world_nether
rm -rf /opt/richard-deablr/data/world_the_end

# Extract your world
cd /opt/richard-deablr/data
unzip /path/to/world.zip

# Restart
docker compose -f /path/to/your/compose.yml up -d
```

## Configuration

Key settings in `compose.yml`:

| Setting | Value | Notes |
|---------|-------|-------|
| `VERSION` | `26.1.2` | Minecraft year-based version |
| `TYPE` | `PAPER` | Auto-downloads latest Paper build |
| `MEMORY` | `2048M` | Adjust based on your Hostinger plan |
| `LEVEL_TYPE` | `flat` | Flat world for creative |
| `ALLOW_NETHER` | `false` | Nether disabled |
| `SPAWN_*` | `false` | No animals, monsters, or NPCs |
| `ENABLE_WHITELIST` | `true` | Whitelist enforced |

### Updating Ops/Whitelist

Edit the `OPS` and `WHITELIST` environment variables in `compose.yml` (UUID format). Redeploy via Dokploy to apply changes.

### Updating Plugins

Add plugin direct-download URLs to the `PLUGINS` environment variable (pipe-separated with `|-`).

## Ports

- `25565` — Minecraft server (default)

## File Structure

```
.
├── compose.yml           # Docker Compose configuration
├── server-icon.png       # Server icon (mounted into container)
├── README.md             # This file
└── world.zip             # World data (not in Git, uploaded manually)
```

## Troubleshooting

### Server won't start
- Check that `/opt/richard-deablr/data` exists and is writable
- Verify Docker and Docker Compose are installed
- Check logs: `docker logs <container_name>`

### World didn't load correctly
- Ensure the unzipped folder is named exactly `world`
- Check that `world/level.dat` exists inside the data directory

### Port already in use
- Change the host port mapping in `compose.yml` if 25565 is taken

## Notes

- The `data/` directory is **gitignored** and lives outside the repo on the server
- `world.zip` is **gitignored** — never commit it
- Server icon is committed and mounted read-only into the container
