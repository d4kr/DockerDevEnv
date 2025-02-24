# DockerDevEnv
## Docker Development Environment

### LAMP Stack
- PHP/Apache (on port 8080)
- MySQL (on port 3306)
- phpMyAdmin (on port 8081)

All code is in the `src` directory. To configure the PHP version, edit the `Dockerfile` and change the `FROM` line. if you want add extensions, add them to the `Dockerfile` as well. To change the PHP configuration, edit the `php.ini` file.

To configure the MySQL version, edit the `docker-compose.yml` file and change the `image` line.

To run the environment, run `docker-compose up --build -d`. To stop the environment, run `docker-compose down`.

To connect the enviroment to VS Code, install the `Remote - Containers` extension and run `Remote-Containers: Attach to Running Container...` from the command palette.

### OpenWebUI
- OpenWebUI (on port 8080)
- Ollie (on port 11434)

OpenWebUI is a front-end for AI (like ollama), inside .env you can configure the ML. The ollama image is build from your local dockerfile, so you can change the version of the image. You can spcify the amount of resources that you want to use in the .env file.

To run the environment, run `docker-compose up --build -d`. To stop the environment, run `docker-compose down`.

### 