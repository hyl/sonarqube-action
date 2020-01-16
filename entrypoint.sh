#!/bin/bash

sonar_args=(-Dsonar.login="$INPUT_LOGIN" -Dsonar.host.url="$INPUT_URL" -Dsonar.projectBaseDir="$INPUT_BASEDIR" -Dsonar.projectKey="$INPUT_APP" -Dsonar.projectName="$INPUT_APP" -Dsonar.scm.provider=git -Dsonar.sourceEncoding=UTF-8)

# check for a branch name
if ["$INPUT_BRANCHNAME" !== ""]
  then 
    sonar_args=("${sonar_args[@]}" -Dsonar.branch.name) 
fi

# check for PR details
if ["$INPUT_PULLREQUESTKEY" !== ""] && ["$INPUT_PULLREQUESTBRANCH" !== ""]
  then
    sonar_args=("${sonar_args[@]}" -Dsonar.pullrequest.key="$INPUT_PULLREQUESTKEY" -Dsonar.pullrequest.key="$INPUT_PULLREQUESTBRANCH")
fi

# finally, check for a pull request base if we have one
if ["$INPUT_PULLREQUESTBASE" !== ""]
  then
      sonar_args=("${sonar_args[@]}" -Dsonar.pullrequest.base="$INPUT_PULLREQUESTBASE")
fi

sonar-scanner "${sonar_args[@]}"
