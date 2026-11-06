![LumenWEB Banner](assets/LumenWEB_Banner.png)

Welcome to the LumenWEB public repository. Help us make our egg better by contributing to it.

### Introduction

**LumenWEB** is a [Pterodactyl](https://pterodactyl.io) egg that allows you to host websites easily!

You can find it at [BuiltByBit](https://builtbybit.com/resources/59393), [SourceXChange](https://www.sourcexchange.net/products/lumenvm) and here, in this GitHub repository.

#### Supported Softwares
- **PHP** (7.4, 8.0, 8.1, 8.2, 8.3, 8.4) with Nginx & Composer
- **Java** (JDK 21, JDK 25) with JAR runner & custom launch support
- **Python** (HTTP server)
- **Node.js** (Astro, Next.js, React, vercel/serve, pnpm, yarn, bun)
- **Custom** (Interactive shell & custom commands)

### Installation

LumenWEB installs the same way as any other Pterodactyl egg, you download the [.json file](https://github.com/LumenDevelopment/LumenWEB/blob/dev/LumenWEB.json) and import it to your panel.

This section is WIP >..<

### Building

To edit LumenWEB for your personal use/hosting use, you can follow this simple guide:

1. Clone the repository
    ```bash
    git clone https://github.com/LumenDevelopment/LumenWEB
    cd LumenWEB
    ```
   
2. Edit the required files
    ```text
    LumenWEB
    ├── assets/ # Static files like branding
    │   └── LumenWEB_Banner.png
    ├── scripts/
    │   └── build.sh.example
    ├── src/
    │   ├── Dockerfile
    │   └── entrypoint.sh # Main entrypoint file
    │   ├── default/ # Default configurations
    │   │   ├── nginx.conf
    │   │   ├── php-fpm.conf
    │   │   └── php.ini
    │   ├── lib/
    │   │   ├── cloudflared.sh # Cloudflare tunnel logic
    │   │   ├── helper.sh # Useful functions
    │   │   ├── lang.sh # Colors, messages, etc...
    │   │   └── launch/ # Start scripts for different softwares
    │   │       ├── astro.sh
    │   │       ├── custom.sh
    │   │       ├── java.sh
    │   │       ├── nextjs.sh
    │   │       ├── php.sh
    │   │       ├── python.sh
    │   │       ├── react.sh
    │   │       └── serve.sh
    ├── .gitignore
    ├── .runasptero.example # Definitions for RunAsPtero (see below, part 4.)
    ├── .shellcheckrc
    ├── LICENSE.md
    ├── LumenWEB.json # The Pterodactyl egg definition
    └── README.md
    ```

3. Build the image

    To build the docker image, edit `scripts/build.sh.example` and adapt the command there. Then run the renamed script: `bash scripts/build.sh`

4. Test it in Pterodactyl
> [!TIP]
> I have made a small tool for testing docker images as they would work in Pterodactyl, without Pterodactyl!
> [RunAsPtero](https://github.com/david1117dev/RunAsPtero)


> [!IMPORTANT]
> If LumenWEB helped you, consider contributing to the repo :)















That's it for now, a better README.md soon™ >.<
