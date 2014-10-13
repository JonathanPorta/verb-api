echo "Making sure there is a local data directory at $(pwd)/data\n"
mkdir -p "$(pwd)/data"

echo "Creating data container with a volume mapped to $(pwd)/data\n"
docker run -d -v $(pwd)/data:/verbdata --name verbdata ubuntu echo 'verb data container'

echo "Running fig build\n"
fig build

echo "Running fig up\n"
fig up
