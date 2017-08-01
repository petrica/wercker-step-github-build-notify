if [ ! -n "$WERCKER_GITHUB_BUILD_NOTIFY_TARGET_URL" ]
then
    WERCKER_GITHUB_BUILD_NOTIFY_TARGET_URL=$WERCKER_BUILD_URL
fi


if [ "$WERCKER_RESULT" = "passed" ]; then
   export WERCKER_GITHUB_BUILD_NOTIFY_STATE="{\"state\":\"success\",\"target_url\":\"$WERCKER_GITHUB_BUILD_NOTIFY_TARGET_URL\",\"description\":\"$WERCKER_GITHUB_BUILD_NOTIFY_DESCRIPTION\",\"context\":\"wercker/$WERCKER_DEPLOYTARGET_NAME\"}";
elif [ "$WERCKER_RESULT" = "failed" ]; then
   export WERCKER_GITHUB_BUILD_NOTIFY_STATE="{\"state\":\"failure\",\"target_url\":\"$WERCKER_GITHUB_BUILD_NOTIFY_TARGET_URL\",\"description\":\"$WERCKER_GITHUB_BUILD_NOTIFY_DESCRIPTION\",\"context\":\"wercker/$WERCKER_DEPLOYTARGET_NAME\"}";
else
   export WERCKER_GITHUB_BUILD_NOTIFY_STATE="{\"state\":\"pending\",\"target_url\":\"$WERCKER_GITHUB_BUILD_NOTIFY_TARGET_URL\",\"description\":\"$WERCKER_GITHUB_BUILD_NOTIFY_DESCRIPTION\",\"context\":\"wercker/$WERCKER_DEPLOYTARGET_NAME\"}";
fi

info "JSON: $WERCKER_GITHUB_BUILD_NOTIFY_STATE"

if [ ! -z "$WERCKER_GITHUB_BUILD_NOTIFY_TOKEN" ]; then
	curl -H "Authorization: token $WERCKER_GITHUB_BUILD_NOTIFY_TOKEN" \
	    -d "$WERCKER_GITHUB_BUILD_NOTIFY_STATE" \
	    https://api.github.com/repos/$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY/statuses/$WERCKER_GIT_COMMIT
else
	info "Github access key not provided. Skipping step."
fi
