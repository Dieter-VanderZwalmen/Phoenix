# HetProject.Umbrella

## Index
1. [About](#about) <br>
2. [Setup](#set-up)<br>
3. [Login](#login)


## About 
This website lets you create programs and exercises. Where a program contains certain exercises.
These programs can be added to your profile or you can make your own. Open the diagram.png file to view the database structure.

# Set up
## Database
Dit project is gemaakt met een mysql database server. Om een docker container te maken met een mysql server: `docker run --name=mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=t -d mysql`

## Dependencies
Om de dependencies te verkrijgen voer het volgende commando in apps/hetProject uit.
`mix deps.get `

## Opstarten
In de root van het project.
`mix phx.server`
Indien je ook wilt debuggen gebruik het volgende
`iex -S mix phx.server`

# Login
### Admin <br>

Username: Admin

Password: Admin

### User <br>
Username: User

Password: User
### Business Analyst <br>
Username: BA

Password: BA

