github = require 'github'
github = new github version: "3.0.0", debug: false, headers: Accept: "application/vnd.github.moondragon+json"

pr = (token, branch, body, cb) ->
  github.authenticate type: "oauth", token: token

  body = """## Updates

  #{body}

  ## Review

  - @cfpb/front-end-team-admin

  ## I am a bot

  After this PR is merged, I will instruct Travis to [automagically](https://github.com/cfpb/capital-framework/tree/master/scripts/npm/prepublish) perform the following steps:

  1. Increment Capital Framework's [version](https://github.com/cfpb/capital-framework/blob/canary/package.json#L3) per our [guidelines](https://github.com/cfpb/capital-framework/issues/179).
  2. Add a timestamped entry to the [changelog](https://github.com/cfpb/capital-framework/blob/canary/CHANGELOG.md) with the new version and its changes.
  3. [Tag](https://github.com/cfpb/capital-framework/tags) the release and push it to GitHub.
  4. Publish both [capital-framework](https://www.npmjs.com/package/capital-framework) and any individually updated [components](http://cfpb.github.io/capital-framework/components/) to npm.
  5. Update both [canary](https://github.com/cfpb/capital-framework/tree/canary), our development branch, and [master](https://github.com/cfpb/capital-framework/tree/master), our release branch.

  If I do something wrong, [blame a human](https://github.com/cfpb/hubot-capital-framework/issues/new).

  ![kitten gif](http://thecatapi.com/api/images/get?format=src&type=gif)
  """

  github.pullRequests.create user: 'cfpb', repo: 'capital-framework', title: 'CF Release', base: 'master', head: branch, body: body, (err, data) ->
    cb err if err
    cb null, data

module.exports = pr
