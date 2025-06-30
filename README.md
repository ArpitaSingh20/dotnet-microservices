
# ASP.NET Core Docker Microservices

This project demonstrates a microservices architecture using ASP.NET Core, Docker, and supporting technologies. It is designed as a practical example for building, running, and understanding distributed systems with .NET and containerization.

## Purpose

- Showcase how to structure and run a microservices-based solution with ASP.NET Core and Docker.
- Demonstrate service isolation, inter-service communication, and container orchestration.
- Provide a starting point for learning and extending microservices patterns in .NET.

## Practices Used

- **Microservices Architecture:** Each domain (Applicants, Jobs, Identity, Web) is implemented as an independent service.
- **Docker Compose:** All services, including SQL Server, Redis, and RabbitMQ, are orchestrated using Docker Compose for local development.
- **Dependency Injection:** Services use DI via ASP.NET Core and Autofac for loose coupling.
- **Event-Driven Communication:** Services communicate asynchronously using RabbitMQ and MassTransit.
- **Data Persistence:** SQL Server is used for data storage; Dapper is used for data access.
- **API-First:** Each service exposes RESTful APIs for its domain.
- **Separation of Concerns:** Business logic, data access, and messaging are separated into clear layers.

## Setup Instructions

1. **Clone the repository**
    ```sh
    git clone <repo-url>
    cd dotnet-microservices
    ```

2. **Start all services using Docker Compose**
    ```sh
    docker-compose up -d
    ```
    This will build and start all containers (Web, Applicants.Api, Jobs.Api, Identity.Api, SQL Server, Redis, RabbitMQ).

3. **Verify containers are running**
    ```sh
    docker ps
    ```
    Ensure all services are up. SQL Server will be available at `localhost:5433` (user: `sa`, password: `Pass@word`).

4. **Access the web application**
    - Open your browser and navigate to [http://localhost:8080](http://localhost:8080)

5. **Development and Debugging**
    - Open the solution in Visual Studio Code.
    - Start and debug individual services as needed.

---
This project is intended for educational and demonstration purposes. Feel free to extend or adapt it for your own learning or prototyping needs.





