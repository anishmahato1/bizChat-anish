# README

Introduction

  This repository contains the source code for a single page chat application built using Ruby on Rails. The application allows users to create accounts, sign in,create channels and send messages in channels, or chat with each other in real time.



Prerequisites

  Before you begin, make sure you have the following installed on your system:
  * ruby 3.1.3
  * rails 7.0.4.3



Getting Started

  To get started with the application, follow these steps:

1. Clone the repository

    $ git clone git@git.bajratechnologies.com:j-23-01/bizChat-anish.git

2. Change into the directory

    $ cd bizChat-anish

3. Install the required gems:

    $ bundle install

4. Set up the database

    $ rails db:create
    $ rails db:migrate

5. Start the Rails server

    $ rails s

And now you can visit the site with the URL http://localhost:3000





Mail Configuration

  This application uses the Action Mailer framework to send email notifications.

  To configure mail settings, you will need to update the config/environments/production.rb file with your SMTP server settings. Here's an example of what the configuration might look like:

  config.action_mailer.default_url_options = { host: 'example.com', protocol: 'https' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'example.com',
    user_name:            '<your-gmail-username>',
    password:             '<your-gmail-password>',
    authentication:       'plain',
    enable_starttls_auto: true
  }

