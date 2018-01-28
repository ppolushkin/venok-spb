# Use an official Python runtime as a parent image
FROM ubuntu:14.04

RUN apt-get -qy update && apt-get -qy upgrade && apt-get -qy install curl && apt-get -qy install gnupg2
RUN command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && rvm install 1.9.3 && gem update && gem install rails --version '3.2.19'"

# Set the working directory to /app
RUN mkdir /home/venok
WORKDIR /home/venok

# Copy the current directory contents into the container at /app
COPY Gemfile /home/venok/Gemfile
COPY Gemfile.lock /home/venok/Gemfile.lock

# Make port 3000 available to the world outside this container
EXPOSE 3000

RUN apt-get -qy install postgresql postgresql-contrib libpq-dev
RUN echo >> /etc/profile && echo "source /etc/profile.d/rvm.sh" >> /etc/profile

# Define environment variable
# You can find it in heroku
#ENV AWS_ACCESS_KEY_ID key_id
#ENV AWS_SECRET_ACCESS_KEY_ID secket
#ENV RAILS_ENV development

RUN /bin/bash -c "source /etc/profile.d/rvm.sh && bundle install"