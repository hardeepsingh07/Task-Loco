## Task Loco
Task organizer for quick simple organization of your everyday tasks

### Backend
A local API along with local Database

#### API
- Powered by NodeJS
- Relies on local Database to store and fetch data
- Will support CRUD operation for each endpoint
- Port will be set to 1997

#### User Endpoints
| Type   | Prefix | Endpoint    | Description                                          |
|--------|--------|-------------|------------------------------------------------------|
| POST   | /user  | /           | Create a user from JSON request body              |
| GET    | /user  | /names      | Provide all user names                            |
| POST    | /user  | /login      | Validates the user and provide a token           |
| POST | /user | /logout | Logout out the provided user in body
| GET | /user | /project/:username | Provide all projects associated with username
| GET    | /user  | /:username | Provide all information associated with the username |
| DELETE | /user  | /:username | Delete the user with associated username           |

#### Project Endpoints
| Type   | Prefix | Endpoint         | Description                                                                                              |
|--------|--------|------------------|----------------------------------------------------------------------------------------------------------|
| POST  | /project  | / | Create a Project from JSON request body |
| GET   | /project  | /all | Provide all Projects    |
| POST  | /project  | /add/:projectId | Add member to project associated with  project ID |
| POST   | /project  | /remove/:projectId | Remove member from project assocaited with project ID | 
| POST    | /project  | /update/:projectId | Update project associated with project ID based on JSON Body |
| GET    | /project  | /id/:projectId  | Provide project associated with project ID |
| GET | /project | /:username | Provoide all project associated with username |
| DELETE | /project  | /:project | Remove the project associated with the project ID |

#### Task Endpoints
| Type   | Prefix | Endpoint         | Description                                                                                              |
|--------|--------|------------------|----------------------------------------------------------------------------------------------------------|
| POST   | /task  | / | Create a task from JSON request body |
| POST   | /task  | /:taskId | Update task associated task ID, with JSON Body    |
| GET    | /task  | /all        | Provide all the tasks           |
| GET    | /task  | /user/:username | Provide all tasks associated with username | 
| GET    | /task  | /filter       | Provide filtered task based on JSON Body |
| GET    | /task  | /archive         | Provide all the archived tasks |
| DELETE | /task  | /:taskId        | Remove the task associated with the task ID |

#### Database
- MongoDB
- Schemas will be generated to respect application models
- Port will be set to 2000

### Front End
An iOS mobile application leveraging local API

#### Mobile Application
- Provide simple user interface
- Written in Swift
- Leverage approriate libraries for networking, asynchronous operation and dependency injections
