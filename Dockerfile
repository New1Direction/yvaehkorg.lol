# Serve the static site. This repo is plain HTML/CSS/JS — there is nothing to
# build — so the container just serves the files on the port Render provides.
FROM python:3.12-alpine
WORKDIR /site
COPY . .
# Render injects $PORT and routes external traffic to it; default for local runs.
ENV PORT=10000
EXPOSE 10000
CMD ["sh", "-c", "exec python -m http.server \"${PORT}\" --bind 0.0.0.0 --directory /site"]
