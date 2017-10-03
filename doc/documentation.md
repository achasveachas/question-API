## Overview

Here you will find the resources that make up the Q&A API v1.

If you have any problems or issues please contact the [owner](http://yechiel.me/contact).

## Schema

All API access is accessed through the endpoint
```
http://localhost:3000/api/v1/
```
All data is sent and received as JSON.

## Authentication

Resources are only available to authenticated clients. Authentication is verified by appending an API key to the request URL:
```
authorization=[API_KEY]
```
Sending a request without a token will return a status of `401` and the error:
```json
{
    "errors": [
        "Incorrect API Key"
    ]
}
```
Note, for security reasons, the same response will be sent if a wrong key is sent as well as no key at all


## Routes

The Q&A API uses standard RESTful routing, here is an overview of the available routes:


## Questions

#### Index
To see a list of all questions send a `GET` request to `/questions`. The response will be an array of Question objects, along with their asker, and answers:
```json
{
    "questions": [
        {
            "id": 1,
            "title": "Question Title?",
            "asker": {
                "id": 1,
                "name": "Question Author"
            },
            "answers": [
                {
                    "id": 1,
                    "body": "Answer Body.",
                    "answerer": {
                        "id": 2,
                        "name": "Answer Author"
                    }
                }
            ]

        }
    ]
}
```
#### Show
To see an individual question send a `GET` request to `/questions/:id`. The response will be an Question object, along with its asker and answers:
```json
{
    "question": {
        "id": 1,
        "title": "Question Title?"
    },
    "asker": {
        "id": 1,
        "name": "Question Author"
    },
    "answers": [
        {
            "id": 1,
            "body": "Answer Body.",
            "answerer": {
                "id": 2,
                "name": "Answer Author"
            }
        }
    ]
}
```
