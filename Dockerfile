# Richard Deablr Minecraft Server
# This Dockerfile bakes in all configuration from compose.yml
# Use compose.yml for deployment (recommended); this Dockerfile is for platforms that require it.

FROM itzg/minecraft-server:latest

# Copy server icon into the image
COPY server-icon.png /server-icon.png

# Minecraft server configuration (mirrors compose.yml)
ENV EULA=TRUE
ENV TYPE=PAPER
ENV VERSION=26.1.2
ENV MEMORY=2048M
ENV MOTD="A server for Richard"
ENV ICON=/server-icon.png
ENV FORCE_GAMEMODE=true
ENV ENABLE_COMMAND_BLOCK=true
ENV ALLOW_NETHER=false
ENV SPAWN_ANIMALS=false
ENV SPAWN_MONSTERS=false
ENV SPAWN_NPCS=false
ENV LEVEL_TYPE=flat
ENV GENERATE_STRUCTURES=false
ENV SPAWN_PROTECTION=0
ENV OPS=3fa30a96-7f21-40fc-8f93-43bc73ce8db2\nc1c43a34-eea1-44a6-8676-7f08b942939a
ENV ENABLE_WHITELIST=true
ENV WHITELIST=3fa30a96-7f21-40fc-8f93-43bc73ce8db2\nc1c43a34-eea1-44a6-8676-7f08b942939a
ENV PLUGINS=https://hangarcdn.papermc.io/plugins/EngineHub/WorldEdit/versions/7.4.2/PAPER/worldedit-bukkit-7.4.2.jar
ENV HIDE_ONLINE_PLAYERS=true
ENV ENFORCE_SECURE_PROFILE=false
ENV SERVER_NAME="Richard Deablr Server"

# Expose the Minecraft server port
EXPOSE 25565

# Declare /data as a volume for world persistence
VOLUME ["/data"]

# The base image already defines the correct ENTRYPOINT
# No CMD override needed — itzg/minecraft-server handles startup
