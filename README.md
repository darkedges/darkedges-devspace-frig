# darkedges-devspace-frig

This is a simple POC for using [DevSpace](https://devspace.sh) to develop a Kubernetes instance of [ForgeRock Identity Gateway](https://www.forgerock.com/platform/identity-gateway).

It uses

- [Helm](https://helm.sh/) - [helm chart](helm)
- [Docker](https://www.docker.com/) - [Dockerfile](docker/Dockerfile)

## Prerequisites

1. checkout this repository

   ```bash
   git clone https://github.com:darkedges/darkedges-devspace-frig
   ```

1. Install

   - [Helm](https://helm.sh/docs/intro/install/)
   - [Docker](https://docs.docker.com/get-docker/)
   - [DevSpace](https://devspace.sh/cli/docs/getting-started/installation)

2. Download [IG-7.1.1.zip](https://backstage.forgerock.com/downloads/get/familyId:ig/productId:ig/minorVersion:7.1/version:7.1.1/releaseType:full/distribution:zip) to `docker/IG-7.1.1.zip`

## Develop

### Local file change

1. Init DevSpace

   ```bash
   cd darkedges-devspace-frig
   devspace use namespace test
   ```

2. Start Developing

   ```bash
   devspace dev
   ```

3. Open [http://localhost:8080/hello](http://localhost:8080/hello) and it should return `Hello World!`

4. edit [docker\config\config\routes\hello.json](docker\config\config\routes\hello.json) and change line 13 ro `Hello World!!` and saves

5. wait for the following to show up in the console

    ```bash
    [frig] [pool-2-thread-1] INFO  o.f.o.handler.router.RouterHandler @system - Unloaded the route with id 'hello'
    [frig] [pool-2-thread-1] INFO  o.f.o.handler.router.RouterHandler @system - Loaded the route with id 'hello' registered with the name 'hello'
    ```

   and reload [http://localhost:8080/hello](http://localhost:8080/hello) which should return `Hello World!!`

### Remote file change

1. Start Developing

   ```bash
   devspace dev
   ```

2. in a second console enter

   ```bash
   cd darkedges-devspace-frig
   devspace enter
   ```

3. Edit `/opt/frig/instance/data/config/routes/hello.json` and change line 13 back to `Hello World!`

4. wait for the following to show up in the console

   ```bash
   [0:sync] Downstream - Download file './config/routes/hello.json', uncompressed: ~0.39 KB
   [0:sync] Downstream - Successfully processed 1 change(s)
   [frig] [pool-2-thread-1] INFO  o.f.o.handler.router.RouterHandler @system - Unloaded the route with id 'hello'
   [frig] [pool-2-thread-1] INFO  o.f.o.handler.router.RouterHandler @system - Loaded the route with id 'hello' registered with the name 'hello'
   ```

   and reload [http://localhost:8080/hello](http://localhost:8080/hello) which should return `Hello World!`

5. view [docker\config\config\routes\hello.json](docker\config\config\routes\hello.json) and check line 13 is `Hello World!`