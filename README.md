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
| POST   | /user  | /           | Create a user from JSON request body                 |
| GET    | /user  | /names      | Provide all user names                               |
| GET    | /user  | /login      | Validates the user and provide a token               |
| GET    | /user  | /:username | Provide all information associated with the username |
| DELETE | /user  | /:username | Delete the user with associated username             |

#### Task Endpoints
| Type   | Prefix | Endpoint         | Description                                                                                              |
|--------|--------|------------------|----------------------------------------------------------------------------------------------------------|
| POST   | /task  | /                | Create a task from JSON request body                                                                     |
| POST   | /task  | /:taskId/update | Update the status of given taskId Queries: - completed: String - status: String - responsible: String    |
| GET    | /task  | /all             | Provide all the tasks                                                                                    |
| GET    | /task  | /completed       | Provide all the completed tasks                                                                          |
| GET    | /task  | /pending         | Provide all the pending tasks                                                                            |
| GET    | /task  | /inprogress      | Provide all the in-progress tasks                                                                        |
| DELETE | /task  | /:taskId        | Remove the task associated with the taskId                                                               |

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
