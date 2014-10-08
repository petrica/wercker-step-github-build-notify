if [ "$WERCKER_RESULT" = "passed" ]; then
   export WERCKER_GITHUB_BUILD_NOTIFY_STATE="{\"state\":\"success\"}";
elif [ "$WERCKER_RESULT" = "failed" ]; then
   export WERCKER_GITHUB_BUILD_NOTIFY_STATE="{\"state\":\"failure\"}";
else
   export WERCKER_GITHUB_BUILD_NOTIFY_STATE="{\"state\":\"pending\"}";
fi

curl -H "Authorization: token $WERCKER_GITHUB_BUILD_NOTIFY_TOKEN" \
    -d $WERCKER_GITHUB_BUILD_NOTIFY_STATE \
    https://api.github.com/repos/$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY/statuses/$WERCKER_GIT_COMMIT
