OAM Single Sing On Login Pages
==============================

author: kapfenho, july 2013


Used gems:
* Sinatra
* HAML
* I18n

Assets:
* Twitter Bootstrap 3.0


## Build and install

### Binary deployment

Currently Unicorn is listed in Gemfile as application server, but you
can use any server you like.

  # local
  $ bunde --binstubs

  # production
  $ bin/cap production deploy

### JVM Deployment

Deployment on any service that supports the JSR 154 (Java Servlet 2.4 
Specification).

  $ bundle install
  $ warble war      #  JRuby version (JVM)


## Interfaces

### Login Page

*In paramters on GET*

* p_error_code:  contains the error code in the form of a string. Passed when an error occurs during authentication.
* request_id:  unique identifier that is used to track requests routed back and forth between client and server.
* OAM_REQ:  User login request context tracked at client until authentication process is completed.

*Out parameters for POST*

* ssousername:  contains the username, must be UTF-8 encoded
* password:  contains the password entered by the user, must be UTF-8 encoded
* OAM_REQ:  if present in request User login request context tracked at client until authentication process is completed.
* request_id:  if present in request unique identifier that is used to track requests routed back and forth between client and server

