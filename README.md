# Lawrence-Test (Backend)

> This is the Server side of a job test by lawrence to develop an SDK for an API (https://github.com/evabanegacom/Lawrence-Test.git)

## Built With

- Ruby v2.7.0
- Ruby on Rails 5.2.4.4
- Rspec
- JWT
- Heroku

## Core Functionalities

- **User authentication:** allows new user to register and existing users to login.

## Getting Started

To get a local copy up and running follow these simple example steps.

- On the project GitHub page, navigate to the main page of the repository [this page](https://github.com/evabanegacom/Lawrence-Test.git).
- Under the repository name, locate and click on a green button named `Code`.
- Copy the project URL as displayed.
- If you're running Windows Operating System, open your command prompt. On Linux, Open your terminal.
- Change the current working directory to the location where you want the cloned directory to be made. Leave as it is if the current location is where you want the project to be.
- Type `git clone`, and then paste the URL you copied in Step 3.<br>
  `$ git clone https://github.com/evabanegacom/Lawrence-Test.git` <em>Press Enter key</em><br>
- Press Enter. Your local copy will be created.

## Prerequisites

- [Git](https://gist.github.com/derhuerst/1b15ff4652a867391f03).
- Web browser (Chrome/Firefox)
- [Node](https://nodejs.org/en/)
- [NPM](https://www.npmjs.com/get-npm)
- Ruby v2.7.0
- Ruby on Rails v5
- Postgresql v >= 9.5

## Project Setup

_After cloning, the following steps setup the project_

- `cd Lawrence-Test` to change the current working directory.
- `bundle install` to install all necessary dependencies.
- `rails db:create` && `rails db:migrate` to create database and tables.
- `rails s` to start the application. You're all set.
  Feel free to use POSTMAN or any other similar infrastructure to test the different endpoints.

  To run test suites included, run:

- `bundle exec rspec`

## API Documentation

> The base URL for all endpoints is `https://lawrence-test.herokuapp.com/`. Some requests requires validation while some don't. The validation is implemented using tokens generated by JWT upon registration or login. This token is then sent with the headers of the requests that requires validation, so that it can be decoded and the app can determine if the token is valid or not. If valid, the user can successfully access such end-points that requires authentication.

**Summary of Available API Endpoints**
| Endpoint | Feature | Authentication |
| ------------ | ------------| ---------- |
| POST /users | Creates a new user | False |
| POST /login | Logs in a user | False |
| GET /autologin | Checks login status of the current user | True |
| GET /users | Fetches all available users for loggedIn user | True |
| GET /all_transactions | Fetches all transactions by logged in user | True |
| POST /add_money | Creates new incoming transaction for logged in user | True |
| POST /send_money | Creates new outgoing transaction for logged in user | True |

**Sampling a request that requires authentication**

_Fetch transactions: endpoint fetches all the transactions already carried-out by the logged in user. Therefore, it requires authorization._

Endpoint: `https://lawrence-test.herokuapp.com/api/v1/all_transactions`

Request (from POSTMAN):

```js
token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE'
curl --location --request GET 'https://lawrence-test.herokuapp.com/api/v1/all_transactions' \
--header 'Authorization: Bearer <token>' \
```

Response:

```json
[
  {
        "id": 1,
        "incoming_transactions": "20.0",
        "outgoing_transactions": "0.0",
        "user_id": 1,
        "created_at": "2021-03-31T13:35:18.376Z",
        "updated_at": "2021-03-31T13:35:18.376Z"
    }
]
```

_Add Money transactions: endpoint for creating incoming transactions by the loggedIn user. Therefore, it requires authorization._

Endpoint: `https://lawrence-test.herokuapp.com/api/v1/add_money`

Request (from POSTMAN):

```Previous balance was 80.0 adding 50 made it 130.0```

```js
token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE'
curl --location --request POST 'https://lawrence-test.herokuapp.com/api/v1/add_money' \
--header 'Authorization: Bearer <token>' \

--form 'incoming_transactions="20"' \
--form 'outgoing_transactions="20"'
"any of the incoming or outgoing transactions could be blank if necessary, they are by default 0.0"
```

Response:

```json
"balance": true,
    "user": {
        "id": 1,
        "name": "precious",
        "email": "precious@yahoo.com",
        "global_balance": "130.0"
    },
    "transact": {
        "id": 34,
        "incoming_transactions": "50.0",
        "outgoing_transactions": "0.0",
        "user_id": 1,
        "created_at": "2021-03-31T21:48:13.752Z",
        "updated_at": "2021-03-31T21:48:13.752Z"
    }
}
```

_Send Money transactions: endpoint for creating outgoing transactions by the loggedIn user. Therefore, it requires authorization._

Endpoint: `https://lawrence-test.herokuapp.com/api/v1/send_money`

Request (from POSTMAN):

```js
token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE'
curl --location --request POST 'https://lawrence-test.herokuapp.com/api/v1/send_money' \
--header 'Authorization: Bearer <token>' \

--form 'incoming_transactions="20"' \
--form 'outgoing_transactions="20"'
"any of the incoming or outgoing transactions could be blank if necessary, they are by default 0.0"
```

Response:

```Previous balance was 130.0 removing 50 made it 80.0```

```json
"balance": true,
    "user": {
        "id": 1,
        "name": "precious",
        "email": "precious@yahoo.com",
        "global_balance": "80.0"
    },
    "transact": {
        "id": 35,
        "incoming_transactions": "0.0",
        "outgoing_transactions": "50.0",
        "user_id": 1,
        "created_at": "2021-03-31T21:48:13.752Z",
        "updated_at": "2021-03-31T21:48:13.752Z"
    }
}
```
**Sampling a request that DOES NOT require authentication**

_Login: endpoint fetches creates a new token and ensure that the user can access all features._

Endpoint: `https://lawrence-test.herokuapp.com/api/v1/login`

Request (From POSTMAN):

```js
curl --location --request POST 'https://lawrence-test.herokuapp.com/api/v1/login' \
--form 'email="johndoe@yahoo.com"' \
--form 'password="password"'
```

Response:

```json
{
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@doe.com"
  },
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE",
  "logged_In": true
}
```

_User registration: endpoint creates a new user and token to ensure that the user can access all features._

Endpoint: `https://lawrence-test.herokuapp.com/api/v1/login`

Request (From POSTMAN):

```js
curl --location --request POST 'https://lawrence-test.herokuapp.com/api/v1/users' \
--form 'email="johndoe@yahoo.com"' \
--form 'password="password"'
--form 'password_confirmation="password"'
--form 'name="johndoe"'
--form 'global_balance="50.0"'
```

Response:

```json
{
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@doe.com",
    "global_balance": "50.0"
  },
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE",
  "logged_In": true
}
```

## Deployment

This app was deployed to Heroku and is accessible at: `https://lawrence-test.herokuapp.com/`

## Author

👤 **Precious**

- Github: [@evabanegacom](https://github.com/evabanegacom)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/evabanegacom/Lawrence-Test/issues/).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](/LICENSE) licensed.