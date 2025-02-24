# DockerDevEnv
## Docker Development Environment

### LAMP Stack
- Apache
- MySQL
- PHP

All code is in the `src` directory. To configure the PHP version, edit the `Dockerfile` and change the `FROM` line. if you want add extensions, add them to the `Dockerfile` as well. To change the PHP configuration, edit the `php.ini` file.

To configure the MySQL version, edit the `docker-compose.yml` file and change the `image` line.

To run the environment, run `docker-compose up --build -d`. To stop the environment, run `docker-compose down`.

To connect the enviroment to VS Code, install the `Remote - Containers` extension and run `Remote-Containers: Attach to Running Container...` from the command palette.

### OpenWebUI
Under development
