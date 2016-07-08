# atlas-api

An api layer for ATLAS. This will sit on the server with ATLAS and interface with the production database. It's not perfect, but it'll work until we can build ATLAS 4 with built in API endpoints.

## Requirements

* Ruby 2.2.0+
* Rails 5
* MySQL
* An exisiting ATLAS installation

## Setup

* Clone the repository
* Copy `config/database.default.yml` to `config/database.yml`
* Configure `config/database.yml` to point to your ATLAS database

## Running Specs

After cloning the repository ensure all specs are passing.

`cd <project_directory> && rake`


## Contributing

* Before writing any new code, make sure all specs are green.
* Create a feature branch
* Open a pull request (yes, this early.)
* Test drive your feature! Red, green, refactor!

When it's ready to be merged, ping 2-3 reviewers. If the feature is ready it will be merged into a release branch and deployed.
