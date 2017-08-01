# Github build notify

A wercker step to notify build status for current pipeline to Github private repo.
add this step to the beginning of the pipeline and to `after-steps` sections of each pipeline that you would like to be reported back to github.

## Options

### optional

If not provided the step will pe skipped. Useful for local build.

* `token` - Github oauth token. access https://github.com/settings/applications and generate Personal access token
* `target_url` - (optional, default $WERCKER_BUILD_URL) The target URL to associate with this status. This URL will be linked from the GitHub UI to allow users to easily see the 'source' of the Status.
