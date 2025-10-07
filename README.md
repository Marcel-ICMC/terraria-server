# terraria-server
Simple docker compose with a terraria server and other utilities like:
- Duckdns auto updating on public ip changes
- Routing terraria server output to `logs/` folder
- Discord notification when an user logs in/out of the server

## Set up
1. Go to https://github.com/hexlo/terraria-server-docker/tree/main and check out their guide, as I'm relying on it's docker image. You'll need a world already at `Worlds/`
2. If you don't have a static ip, [duckdns](https://www.duckdns.org/) might be a good solution. I don't have it, so it makes sense here.
3. In case you want notification of log in/out in discord you'll want to [create a webhook in your channel](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks).

### Environment Variables
```
- WORLD_FILENAME: World file name that's in Worlds/, just the file name like The_Wastelands_of_Babies.wld
- WORLD_PASSWORD: Any string will do, it's what will be used for your players to log in
- DUCK_DNS_SUBDOMAIN: Set in https://www.duckdns.org/
- DUCK_DNS_TOKEN: Grab it in https://www.duckdns.org/
- WEBHOOK_URL: Discord webhook so that the elixir service can send messages to
```
