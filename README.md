# Software Enginering Concepts
## CS532 - Herguan Univeristy || Final Project - Spring 2016

[![Build Status](https://semaphoreci.com/api/v1/Shibl/cs532-project/branches/master/badge.svg)](https://semaphoreci.com/Shibl/cs532-project)

### Contributors
- Mohamed Shibl (161001)
- Rajesh Dulam (151049)
- Riasuddin Mohammed (153063)
- Syed Minhaj Ahmed (153030)
- Mohammed Abdul Rahman (153057)

### Development Start Guide:
To start development run the following commands in your terminal:

Install Required Gems:
```
bundle install
```

Create Development Server and Execute all Migrations:
```
be rake db:create
be rake db:migrate
```

Start Redis Server:
```
redis-server
```

Start Clockwork:
```
be clockwork app/clock.rb
```

Start Sidekiq:
```
be sidekiq -c 5
```

Start Rails Server:
```
Rails s
```

Once all the above steps are done, the development server will be up and running on: http://localhost:3000/
