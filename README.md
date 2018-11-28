# SM-docker
HP/Micro Focus Service Manager on Docker containers

When you need a Micro Focus Service Manager development environment running on your laptop, you can run it on containers.
Here is HOWTO:
1. Install Docker and Docker Compose
2. Download files from this repo
3. Download missing files and replace placeholder files:
  - Download Oracle JRE v8 and place it instead of placeholder file Dockerfiles/sm/jre/jre-8u181-linux-i586.rpm
  - Download Oracle Client installation packages and place them instead of Dockerfiles/sm/oracle/oracle-instantclient12.2-basic-12.2.0.1.0-1.i386.rpm, oracle-instantclient12.2-devel-12.2.0.1.0-1.i386.rpm, and oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.i386.rpm
  - Download Service Manager installer for Linux and place it instead of Dockerfiles/sm/SM/setupLinuxX64.bin
  - Download Service Manager server patch (if needed) and place it instead of Dockerfiles/sm/SM/patch/HPSM_00962.tar
  - Replace Service Manager license file Dockerfiles/sm/SM/LicFile.txt
  - Download and extract SRC jar into Dockerfiles/src/src
  - Download and extract Service Manager Web Tier jar into Dockerfiles/web/webtier
 4. Execute "docker-compose build" to build images
 5. Execute "docker-compose up -d" to bring up containers. If you need only some components, you can do e.g. "docker-compose up -d sm web", this will bring SM Server and Web Tier, but not SRC.
 6. You can control if SM Server patch is applied by setting APPLY_SM_PATCH: "true" or "false" in docker-compose.yml file. Rebuild sm image.
  
