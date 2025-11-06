# CS4218 Project - Virtual Vault

Virtual Vault is a full-stack MERN (MongoDB, Express.js, React.js, Node.js) e-commerce website. My task was to extensively test the written code

## Unit Test (Jest)

Jest was used to write and run unit tests to ensure individual components and functions work as expected, finding and fixing bugs in the process
- Key concepts to write good unit tests:
  - Identify all external dependencies and mock them
  - Use the AAA (Arrange, Act, Assert) methodology to write clean and maintainable tests
- My unit test contributions:
  - `Order.js`, `orderModel.js`
  - authController.js (`updateProfileController`, `getOrdersController`, `getAllOrdersController`, `orderStatusController`)
  - productController.js (`braintreeTokenController`, `brainTreePaymentController`)

<br>

## Integration Test (Jest and Supertest)

Jest was used to test the integration between multiple application components (models, controllers, and routes) while maintaining isolation from external dependencies. The npm Supertest library was used to verify the correctness and reliability of the HTTP server’s API endpoints
- Key concepts to write good integration tests:
  - To test interaction with a database, fake the database (in the case of Mongo, use an in-memory Mongo instance)
  - External APIs/libraries should be mocked, because it is expected that they are already thoroughly tested by their maintainers
- My integration test contributions:
  - authController.js (`updateProfileController`, `getOrdersController`, `getAllOrdersController`, `orderStatusController`), `orderModel.js`
  - productController.js (`braintreeTokenController`, `brainTreePaymentController`)
- My Supertest contributions:
  - authRoutes.integration.test.js (`updateProfileController`, `getOrdersController`, `getAllOrdersController`, `orderStatusController`)
  - productRoutes.integration.test.js (`braintreeTokenController`, `brainTreePaymentController`)

<br>

## E2E Test (Playwright)
Playwright was used for UI testing to validate the behavior and appearance of the website's user interface
- My E2E test contributions:
  - `HomePage.e2e.test.js`, `Dashboard.e2e.test.js`, `Orders.e2e.test.js`, `Profile.e2e.test.js`

<br>

## Performance Test (JMeter, Grafana, InfluxDB)
Apache JMeter was used for load testing to assess the performance and scalability of the ecommerce platform under various traffic conditions. In particular, I conducted 2 types of load tests on the payment endpoints:
  - Capacity testing: to determine the maximum number of concurrent users the system can handle before user experience begins to degrade
  - Soak testing: to evaluate the application’s stability and resource utilization over an extended period under sustained load

My tech set up:
  - **Apache JMeter**: to simulate a large number of concurrent users to assess how well the application performs under heavy load
  - **Telegraf**: to collect metrics like CPU or memory utilisation from the dockerised application and push the metrics to InfluxDB
  - **InfluxDB**: to collect and store time-series metrics from Telegraf and JMeter
  - **Grafana**: to visualize the metrics stored in InfluxDB through dynamic dashboards, enabling real-time monitoring and trend analysis

Given this set up, I was able to visualise the state of the application **in real time**, allowing me to detect anomalies quickly and correlate metrics visually 

![Alt text](/images/Grafana.png)
<i>Results of a 4 hour soak test displayed on Grafana</i>

<br>

## Static Code Analysis (SonarQube)
SonarQube was used for static code analysis and coverage reports to maintain code quality and identify potential issues

<br>

## Setting Up The Project

1. **Download and Install Node.js**

2. **Create a new MongoDB Cluster**:

    - Create a project in MongoDB Atlas and within that project deploy a free cluster.

3. **Configure Database Access**:

    - Create a new user for your database (if not alredy done so) in MongoDB Atlas.
    - Navigate to "Database Access" under "Security" and create a new user with the appropriate permissions.

4. **Whitelist IP Address**:

    - Go to "Network Access" under "Security" and whitelist your IP address to allow access from your machine.
    - For example, you could whitelist 0.0.0.0 to allow access from anywhere for ease of use.


## Application Setup

1. **Install Frontend and Backend Dependencies**

    - Run the following command in your project's root directory:

        ```
        npm install && cd client && npm install && cd ..
        ```

3. **Add database connection string to `.env`**

    - Add the connection string copied from MongoDB Atlas to the `.env` file inside the project directory (replace the necessary placeholders):
        ```env
        MONGO_URL = <connection string>
        ```

4. **Adding sample data to database**

    - Download “Sample DB Schema” from Canvas (if applicable) and extract it.
    - In MongoDB Compass, create a database named `test` under your cluster.
    - Add four collections to this database: `categories`, `orders`, `products`, and `users`.
    - Under each collection, click "ADD DATA" and import the respective JSON from the extracted "Sample DB Schema".

5. **Running the Application**
    - Use `npm run dev` to run the app from root directory, which starts the development server.
    - Navigate to `http://localhost:3000` to access the application.


## Setting up SonarQube

SonarQube consists of 2 parts:

-   Server -> the UI portion which is accessible via `http://localhost:9000/`
-   Scanner -> a dependency installed via npm, should be already in your `package.json`

</br>

To download and link SonarQube to this project, follow the following steps:

1. **Download and run SonarQube**

-   Download the zip file from https://docs.sonarsource.com/sonarqube-server/server-installation/from-zip-file/basic-installation
-   Make sure you have JDK17 installed
-   Unzip the zip file (if using WSL, please unzip it in your linux directory)
-   Run the `sonar.sh`, details of where it is found -> https://docs.sonarsource.com/sonarqube-server/server-installation/from-zip-file/starting-stopping-server/from-zip-file

2. **Set up SonarQube**

-   After running SonarQube, access it at localhost:9000
    -   Login: admin
    -   Password: admin
-   You will be asked to update your password
-   Go to My Account -> Security and create a User token
    -   Paste your token into the `sonar-project.properties` file

3. **Generating SonarQube Report**

-   Run tests with Jest (with coverage)
-   Run SonarQube Server (you should be able to access it at `http://localhost:9000/`)
-   Run SonarQube Scanner using `npm run sonarqube`
-   Click the link in the output to view the results

4. **Stop SonarQube**

-   Execute `sonar.sh stop`


## Unit Testing with Jest

1. **Install Jest**:  
    ```bash
    npm install --save-dev jest

    ```

2. **Write Tests**  

3. **Run Tests**  
   Execute your tests using Jest to ensure that your components meet the expected behaviour.  
   You can run the tests by using the following command in the root of the directory:

    - **Frontend tests**

        ```bash
        npm run test:frontend
        ```

    - **Backend tests**

        ```bash
        npm run test:backend
        ```

    - **All the tests**
        ```bash
        npm run test
        ```


## Installing JMeter
- Download and extract the latest binary from https://jmeter.apache.org/download_jmeter.cgi
- Ensure that you have JDK installed correctly
  - Check that it is in your path with `java –version`
- Run the respective script under the bin directory to launch jmeter
  - `jmeter` (linux)

## JMeter basics
- `Thread group` -> thread group is where you specify the details of your performance test
- `Ramp up period` -> refers to the time JMeter will taken to spawn the threads. So if ramp up period = 1s, JMeter will spawn all the threads in 1s
- `Loop count` -> how many times you want each thread to do the actions that you specify. If your action is assessing a simple endpoint, then loop count refers to the number of times each thread will assess the endpoint. Can be set to infinite
- `Server Name or IP` -> for this field, you dont put any `:` or `/`
- `Default config element` -> since we are gonna do multiple HTTP requests, we can add a default config element. Under `Server Name or IP`, you can add the the target endpoint base URL e.g. `localhost`. This is so that in the individual http request sampler, we only need to specifiy the path (base URL is already included)
- `Samplers` -> refers to whatever endpoint you want to hit (we use HTTP Request). You specify the path under the 'Path' field
- `Listener` -> after setting up your thread group, the last thing we want to do is to listen to the results. Add a 'Aggregate Graph' listener. Here, we can see the average response time, median response time etc.

## Installing Grafana, InfluxDB, and Telegraf
- Just find them on the respective websites and run them with the commands below

## Dockerise the ecommerce application
- Build the Docker image (example command)
```
docker build -t cs4218-monolith:dev .
```
- Launch the container (example command)
  - `--env-file .env` -> loads your environment variables (DB URI, JWT_SECRET, etc) into the container
  - `-p 3000:3000 -p 6060:6060` -> maps host ports to container ports
  - `-d` -> runs in detached mode
  - `--cpus="2.0" --memory="4g"` -> limit the container's resources to emulate a cloud VM environment
```
docker run -d --name cs4218-monolith --cpus="2.0" --memory="4g" --env-file .env -p 3000:3000 -p 6060:6060 cs4218-monolith:dev
```

## Connecting the platforms
- Connect Jmeter to InfluxDB by putting a backend listener connection on Jmeter, which points to the InfluxDB bucket (InfluxDB will store metrics like response time and throughput from JMeter)
  - The InfluxDB URL in the backend listener is `http://localhost:8086/api/v2/write?org=<your_org_name>&bucket=<your_bucket_name>`
- Connect Grafana to InfluxDB by adding a new connection in Grafana to http://localhost:8086
- Get Telegraf to read inputs from docker and output to InfluxDB by editing the `telegraf.conf` file (located in `/etc/telegraf/` directory)
  - Details in: https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker
  - InfluxDB will store metrics like CPU usage percent and memory utilisation from Telegraf

## Commands for Granafa, InfluxDB, Telegraf
- start `grafana`: sudo systemctl start grafana-server (by default, web app will open on http://localhost:3000)
- verify `grafana` running: sudo systemctl status grafana-server
- stop `grafana`: sudo systemctl stop grafana-server
- start `influxDB`: sudo service influxdb start (by default, web app will open on http://localhost:8086)
- check `influxDB` status: sudo service influxdb status
- stop `influxDB`: sudo systemctl stop influxdb
- start `telegraf`: sudo systemctl start telegraf
- verify `telegraf `running: sudo systemctl status telegraf
- restart `telegraf`: sudo systemctl restart telegraf

## Run JMeter in non-gui mode
- `-n`: CLI mode
- `-t`: path to test file
- `-l`: log directory
- `-e`: tells jmeter to create a report
- `-o`: specify path to report directory
```
./jmeter -n -t "<path to jmx file>" -l "<path-to-where-your-logs-will-be-stored>" -e -o "<path-to-where-your-web-report-will-be-stored>"
```