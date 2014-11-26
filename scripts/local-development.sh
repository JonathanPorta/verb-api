echo "Build the rails app"
docker build -t jonathanporta/verb-api .

echo "Making sure there is a local data directory at $(pwd)/data"
mkdir -p "$(pwd)/data"

echo "Creating data container with a volume mapped to $(pwd)/data"
docker rm -f verb_data
docker run -d -v $(pwd)/data:/verbdata --name verb_data ubuntu echo 'verb_data container'

echo "Creating database container"
docker rm -f verb_db
docker run -e "PGDATA=/verbdata/development" -d --name verb_db --volumes-from verb_data postgres

docker rm -f verb_rails
docker run -e "RAILS_ENV=development" -d --name verb_rails -v $(pwd):/home/app -p 127.0.0.1:80:80 --link verb_db:db jonathanporta/verb-api
