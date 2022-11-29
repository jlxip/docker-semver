# docker-semver

## About
This is a very simple GitHub action to build and push Docker images. It's based on [docker/build-push-action](https://github.com/docker/build-push-action), with the only difference that the tags must follow [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html). When a tag is pushed on the GitHub repository, let's say `1.4.1`, `docker/build-push-action` is called, uploading to the hub the following tags, all pointing to the same image:
- `1.4.1`
- `1.4`
- `1`
- `latest`

This way, users can always pull to `user/yourimage:1` and be able to update it while knowing that no backwards-incompatible changes will be made.

Note: when pushing `1.5.1-rc1`, it will NOT push `1.5.1`, but it will push `1.5` and `1`. Note that due to Docker limitations, metadata (`1.5.1+build1`) cannot be used as a version.

Use in the lines of:
```
name: Publish
on:
  create:
    tags:
      - '*'
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      - name: Build and push
        uses: jlxip/docker-semver@1
        with:
          context: .
          image: user/yourimage
          version: ${{ github.ref_name }}
```
