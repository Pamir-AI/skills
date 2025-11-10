# Gh-Cli - Issues

**Pages:** 12

---

## 

**URL:** https://cli.github.com/manual/gh_issue_close

**Contents:**
- gh issue close
  - Options
  - Options inherited from parent commands
  - See also

**Examples:**

Example 1 (unknown):
```unknown
gh issue close {<number> | <url>} [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_view

**Contents:**
- gh issue view
  - Options
  - Options inherited from parent commands
  - JSON Fields
  - See also
  - In use
    - In terminal
    - In the browser

Display the title, body, and other information about an issue.

With --web flag, open the issue in a web browser instead.

assignees, author, body, closed, closedAt, closedByPullRequestsReferences, comments, createdAt, id, isPinned, labels, milestone, number, projectCards, projectItems, reactionGroups, state, stateReason, title, updatedAt, url

By default, we will display items in the terminal.

Quickly open an item in the browser using --web or -w

**Examples:**

Example 1 (unknown):
```unknown
gh issue view {<number> | <url>} [flags]
```

Example 2 (unknown):
```unknown
# Viewing an issue in terminal
~/Projects/my-project$ gh issue view 21
Issue title
opened by user. 0 comments. (label)

  Issue body

View this issue on GitHub: https://github.com/owner/repo/issues/21
~/Projects/my-project$
```

Example 3 (unknown):
```unknown
# Viewing an issue in the browser
~/Projects/my-project$ gh issue view 21 --web
Opening https://github.com/owner/repo/issues/21 in your browser.
~/Projects/my-project$
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_develop

**Contents:**
- gh issue develop
  - Options
  - Options inherited from parent commands
  - Examples
  - See also

Manage linked branches for an issue.

When using the --base flag, the new development branch will be created from the specified remote branch. The new branch will be configured as the base branch for pull requests created using gh pr create.

**Examples:**

Example 1 (unknown):
```unknown
gh issue develop {<number> | <url>} [flags]
```

Example 2 (bash):
```bash
# List branches for issue 123
$ gh issue develop --list 123

# List branches for issue 123 in repo cli/cli
$ gh issue develop --list --repo cli/cli 123

# Create a branch for issue 123 based on the my-feature branch
$ gh issue develop 123 --base my-feature

# Create a branch for issue 123 and checkout it out
$ gh issue develop 123 --checkout

# Create a branch in repo monalisa/cli for issue 123 in repo cli/cli
$ gh issue develop 123 --repo cli/cli --branch-repo monalisa/cli
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_status

**Contents:**
- gh issue status
  - Options
  - Options inherited from parent commands
  - JSON Fields
  - See also
  - In use

Show status of relevant issues

assignees, author, body, closed, closedAt, closedByPullRequestsReferences, comments, createdAt, id, isPinned, labels, milestone, number, projectCards, projectItems, reactionGroups, state, stateReason, title, updatedAt, url

**Examples:**

Example 1 (unknown):
```unknown
gh issue status [flags]
```

Example 2 (unknown):
```unknown
# Viewing issues relevant to you
~/Projects/my-project$ gh issue status
Issues assigned to you
  #8509 [Fork] Improve how Desktop handles forks  (epic:fork, meta)

Issues mentioning you
  #8938 [Fork] Add create fork flow entry point at commit warning  (epic:fork)
  #8509 [Fork] Improve how Desktop handles forks  (epic:fork, meta)

Issues opened by you
  #8936 [Fork] Hide PR number badges on branches that have an upstream PR  (epic:fork)
  #6386 Improve no editor detected state on conflicts modal  (enhancement)

~/Projects/my-project$
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_reopen

**Contents:**
- gh issue reopen
  - Options
  - Options inherited from parent commands
  - See also

**Examples:**

Example 1 (unknown):
```unknown
gh issue reopen {<number> | <url>} [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_create

**Contents:**
- gh issue create
  - Options
  - Options inherited from parent commands
  - ALIASES
  - Examples
  - See also
  - In use
    - Interactively
    - With flags
    - In the browser

Create an issue on GitHub.

Adding an issue to projects requires authorization with the project scope. To authorize, run gh auth refresh -s project.

The --assignee flag supports the following special values:

**Examples:**

Example 1 (unknown):
```unknown
gh issue create [flags]
```

Example 2 (bash):
```bash
$ gh issue create --title "I found a bug" --body "Nothing works"
$ gh issue create --label "bug,help wanted"
$ gh issue create --label bug --label "help wanted"
$ gh issue create --assignee monalisa,hubot
$ gh issue create --assignee "@me"
$ gh issue create --assignee "@copilot"
$ gh issue create --project "Roadmap"
$ gh issue create --template "Bug Report"
```

Example 3 (unknown):
```unknown
# Create an issue interactively
~/Projects/my-project$ gh issue create
Creating issue in owner/repo
? Title My new issue
? Body [(e) to launch nano, enter to skip]
http://github.com/owner/repo/issues/1
~/Projects/my-project$
```

Example 4 (unknown):
```unknown
# Create an issue using flags
~/Projects/my-project$ gh issue create --title "Issue title" --body "Issue body"
http://github.com/owner/repo/issues/1
~/Projects/my-project$
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue

**Contents:**
- gh issue
  - General commands
  - Targeted commands
  - Options
  - Examples
  - See also

Work with GitHub issues.

**Examples:**

Example 1 (bash):
```bash
$ gh issue list
$ gh issue create --label bug
$ gh issue view 123 --web
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_comment

**Contents:**
- gh issue comment
  - Options
  - Options inherited from parent commands
  - Examples
  - See also

Add a comment to a GitHub issue.

Without the body text supplied through flags, the command will interactively prompt for the comment text.

**Examples:**

Example 1 (unknown):
```unknown
gh issue comment {<number> | <url>} [flags]
```

Example 2 (bash):
```bash
$ gh issue comment 12 --body "Hi from GitHub CLI"
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_unlock

**Contents:**
- gh issue unlock
  - Options inherited from parent commands
  - See also

Unlock issue conversation

**Examples:**

Example 1 (unknown):
```unknown
gh issue unlock {<number> | <url>}
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_lock

**Contents:**
- gh issue lock
  - Options
  - Options inherited from parent commands
  - See also

Lock issue conversation

**Examples:**

Example 1 (unknown):
```unknown
gh issue lock {<number> | <url>} [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_issue_delete

**Contents:**
- gh issue delete
  - Options
  - Options inherited from parent commands
  - See also

**Examples:**

Example 1 (unknown):
```unknown
gh issue delete {<number> | <url>} [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_search_issues

**Contents:**
- gh search issues
  - Options
  - JSON Fields
  - Examples
  - See also

Search for issues on GitHub.

The command supports constructing queries using the GitHub search syntax, using the parameter and qualifier flags, or a combination of the two.

GitHub search syntax is documented at: https://docs.github.com/search-github/searching-on-github/searching-issues-and-pull-requests

On supported GitHub hosts, advanced issue search syntax can be used in the --search query. For more information about advanced issue search, see: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/filtering-and-searching-issues-and-pull-requests#building-advanced-filters-for-issues

For more information on handling search queries containing a hyphen, run gh search --help.

assignees, author, authorAssociation, body, closedAt, commentsCount, createdAt, id, isLocked, isPullRequest, labels, number, repository, state, title, updatedAt, url

**Examples:**

Example 1 (unknown):
```unknown
gh search issues [<query>] [flags]
```

Example 2 (bash):
```bash
# Search issues matching set of keywords "readme" and "typo"
$ gh search issues readme typo

# Search issues matching phrase "broken feature"
$ gh search issues "broken feature"

# Search issues and pull requests in cli organization
$ gh search issues --include-prs --owner=cli

# Search open issues assigned to yourself
$ gh search issues --assignee=@me --state=open

# Search issues with numerous comments
$ gh search issues --comments=">100"

# Search issues without label "bug"
$ gh search issues -- -label:bug

# Search issues only from un-archived repositories (default is all repositories)
$ gh search issues --owner github --archived=false
```

---
