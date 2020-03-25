# HEIOT
HEIOT is an IoT platform to manage IoT devices and their delivered data.
The user can overlook all devices in lists grouped by the actual condition distinguishing between the need of the platform's manager to take further actions. The user is enabled to create tags and masterdata by her-/himself in order to group the devices semantically.
Moreover, there is a detailed view of each device where all data is displayed and visualized by interactive charts and tables.
The platform also includes an analytical service to detect anomalies in the device's data.

HEIOT was a project ("ISE project") implemented by a group of students from the University of Heidelberg.


## Setting up HEIOT

### Deploying the platform

To deploy HEIOT please follow instructions from <https://github.com/HEIOT/ise_2019_deployment>

### Starting the platform locally

1. [Set up docker based development environment] (https://github.com/HEIOT/ise_2019_dev_infra)
2. Start application

    ```bash
    npm run docker-up
    ```
3. In your browser go to http://ise.local/


## Docker based infrastructure

### Setting up the docker based development environment

1. Create a new base directory for the ISE project and clone the three ISE repositories into this directory

    Linux/macOS:

    ```bash
    mkdir ise
    cd ise
    git clone https://cures.ifi.uni-heidelberg.de/bitbucket/scm/ise2019/ise_2019_frontend.git
    git clone https://cures.ifi.uni-heidelberg.de/bitbucket/scm/ise2019/ise_2019_backend.git
    git clone https://cures.ifi.uni-heidelberg.de/bitbucket/scm/ise2019/ise_2019_dev_infra.git
    ```

2. Make the 'dev.sh'script executable.

    ```bash
    cd ise_2019_dev_infra
    chmod +x dev.sh
    ```

    This script allows npm to execute complex docker-compose commands for you

3. Register the following domains in the host file of your machine.

    - 127.0.0.1 ise.local

    This allows you to access the services locally by entering a domain name instead of localhost or 127.0.0.1

4. Install docker and docker-compose
   <https://docs.docker.com/compose/install/>

5. Set up the necessary docker networks to prevent errors:

    ```bash
    docker network create monitoring_db_network
    docker network create isebackend_default
    docker network create isemonitoring_default
    docker network create isefrontend_default
    docker network create iseproxy_default
    ```

6. Start the development system by changing into you backend or frontend directory and executing:

   ```bash
   # only necessary to repeat after a pull from master or if you have made changes in ise_2019_dev_infra
   npm run docker-build

   npm run docker-up
   ```

   All necessary services to operate the ISE application in development mode are now getting rebuild and started.
   Front- and backend services mount the code repositories directly and are running in a hot reload mode. All changes are reflected in the running application directly.

   You get dropped into the bash shell of the running project you are working on (either the backend or frontend container depending on the repository you've executed the command).

7. You can run the test like normal if you are still in the bash shell of the container.

   Should you have exited the shell there are two options:

   ```bash
   npm run docker-test
   ```

   This command makes sure that all services are up, the test db exists and executes the tests in the docker container.

   ```bash
   npm run docker-attach
   ```

   Reattaches you to the docker container shell and lets you execute all the npm scripts directly.


8. Access the different parts of the application.

   The API is reachable under <http://ise.local/api>

   The frontend is served unter <http://ise.local>

   A pgAdmin instance is hosted under <http://ise.local/pgadmin>
   Default credentials are test@test.de and the password is "test"

### Windows Additional Instructions

1. Windows Powershell or cmd does not work.

   You need the bash to run the dev environment.

   The bash is commonly installed with git

2. The host file can be found at C:\Windows\System32\drivers\etc

3. The setup-db script in the backend repo can cause problems, because of dos line endings

   This will be visible in the docker backend logs if the script causes errors.

   To fix that run the following:

   ```bash
   mv setup-db.sh setup-db2.sh
   cat setup-db2.sh | sed '/\015/d' > setup-db.sh
   rm setup-db2.sh
   ```

   This will change the dos line endings to unix ones

### Helpfull Commands


Display all running containers, their resource usage and name:

```bash
docker stats
```

Display logs of a running container:

```bash
docker logs {container-name}
```

Restart a single container:

```bash
docker kill {container-name}
npm run docker-up
```

Rebuild containers:

```bash
npm run docker-build
```


