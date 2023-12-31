# OdinBook

A Social Media App where users can create content, make friends and chat with each other

## Getting Started

you need to clone the project by git or download it as a ZIP file

### Prerequisites

docker

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
docker compose up -d
```

now you can open http://localhost:5173 to interact with the app

## Technologies Used

* Spring Boot - to avoid boiler plate code
and the hassle of configuring XML files
* Spring Web -  to create REST endpoints
* Spring Data JPA  - to facilitate persisting data 
with PostgreSQL
* Spring Security with OAUTH2 - to prevent anonymous users to access forbidden resources

* Spring Integration with RabbitMQ - to easily communicate between different microservices components 

* Spring Cloud Gateway - to make requests only pass through one entry point hence increasing security

* Junit with Mockito - to test and assert Functionality

* Docker Compose - to fully containerize components

## Challenges

**Q.How to store post content**\
A.As a HTML content but i need to sanitize the content before storing

**Q.How to store images**\
A.Store images ids in the src attribute

**Q.How to handle post visibility**\
A.I'll create two columns in posts table called is_followers_visible that will represent if followers are allowed to see this post ,friends_visibility_type that if set to true then every friend returned will be able to see the post else then every friend returned won't be able to see the post, \
and a new table posts_friends_visibility( post_id, friend_id )

**Q.How do all users sync post's likes and comments**\
A.I'll create two auto-delete queues in RabbitMQ where the first will be called\ 'post.${id}.add' and the second one 'post.${id}.remove' and every user has the post will be able to listen to these queues so that when a new like or comment is created it will be pushed to add queue or when like or comment removed it will be pushed to the remove queue

**Q.How to handle user's availability**\
A.every user on log in will send a request through RabbitMQ to know who are the currently available users and will send another request to notify his friends that he became available and on logout he will send a request to notify his friends that he became unavailable

**Q.How to store cookies securely**\
A.by using backend for frontend pattern

**Q.How to handle redirect step in OAUTH2 process while using SPA(single page application)**\
A.by redirecting to the backend for frontend

**Q.How to effectively use spring cloud gateway**\
A.By configuring all services's CORS to only accept requests from the gateway and configuring the gateway itself to only accept requests from the frontend





