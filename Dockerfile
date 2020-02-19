# For running locally
docker run --rm -it \
  --volume="$PWD:/srv/jekyll" \
  --volume="$PWD/vendor/bundle:/usr/local/bundle" \
  -p 4000:4000 jekyll/jekyll:3.8 \
  jekyll serve