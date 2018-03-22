# RihannaUI

A beautiful UI for [Rihanna](https://github.com/samphilipd/rihanna).

## Installation

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Docker

RihannaUI comes with a Dockerfile ready for deployment.

Simply build with `docker build .` and you're ready to run the image!

## Configuration

You must pass in environment configuration so that RihannaUI can connect
to the database with your `rihanna_jobs` table, like so:

`DB_USERNAME=postgres DB_PASSWORD=postgres DB_DATABASE=rihanna_db DB_HOSTNAME=localhost DB_PORT=5432 mix phx.server`
