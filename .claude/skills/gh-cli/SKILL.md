---
name: gh-cli
description: Use this skill when working with GitHub CLI (gh) commands, workflows, or automation. Covers gh commands for repositories, pull requests, issues, actions, and more.
---

# GitHub CLI (gh) Skill

Comprehensive assistance with GitHub CLI (gh) commands, workflows, and automation. Generated from official documentation covering 200+ commands.

## When to Use This Skill

This skill should be triggered when:
- Working with GitHub CLI (`gh`) commands
- Automating GitHub workflows from the command line
- Managing repositories, pull requests, issues, releases, or actions
- Authenticating with GitHub or setting up git credentials
- Searching GitHub code, commits, issues, or PRs
- Managing GitHub projects, gists, labels, or secrets
- Working with GitHub Actions workflows and runs
- Creating or managing GitHub extensions

## Key Concepts

### Core Command Categories

1. **Repository Management** (`gh repo`)
   - Create, clone, fork, view, edit, and delete repositories
   - Manage repository settings and configuration
   - Archive/unarchive repositories

2. **Pull Requests** (`gh pr`)
   - Create, list, view, checkout, and merge PRs
   - Review, comment, and manage PR status
   - Check PR checks and diff changes

3. **Issues** (`gh issue`)
   - Create, list, view, edit, and close issues
   - Comment, pin, lock, and transfer issues
   - Link issues to branches with `gh issue develop`

4. **GitHub Actions** (`gh workflow`, `gh run`, `gh cache`)
   - Trigger and manage workflow runs
   - View, rerun, cancel, and download workflow artifacts
   - Manage workflow caches

5. **Authentication** (`gh auth`)
   - Login/logout with GitHub
   - Setup git credentials with `gh auth setup-git`
   - Manage access tokens and authentication status

6. **Releases** (`gh release`)
   - Create, view, edit, and delete releases
   - Upload and download release assets
   - Verify release attestations

## Quick Reference

### Authentication & Setup

**Login to GitHub:**
```bash
# Interactive login (opens browser)
$ gh auth login

# Configure git to use gh as credential helper
$ gh auth setup-git

# Check authentication status
$ gh auth status
```

### Repository Operations

**Create and clone repositories:**
```bash
# Create a new repository
$ gh repo create my-repo --public --description "My new project"

# Clone a repository
$ gh repo clone owner/repo

# Fork a repository
$ gh repo fork owner/repo --clone

# View repository details
$ gh repo view owner/repo

# Open repository in browser
$ gh repo view owner/repo --web
```

**Repository management:**
```bash
# Set default repository for current directory
$ gh repo set-default owner/repo

# Archive a repository
$ gh repo archive owner/repo

# Sync a fork with upstream
$ gh repo sync
```

### Pull Request Workflows

**Create and manage PRs:**
```bash
# Create a PR from current branch
$ gh pr create --title "Add new feature" --body "Description here"

# Create a PR interactively
$ gh pr create --web

# List open PRs
$ gh pr list

# Checkout a PR locally
$ gh pr checkout 123

# View PR details
$ gh pr view 123

# View PR diff
$ gh pr diff 123
```

**PR review and merge:**
```bash
# Review a PR
$ gh pr review 123 --approve
$ gh pr review 123 --request-changes --body "Needs fixes"

# Merge a PR
$ gh pr merge 123 --squash
$ gh pr merge 123 --merge
$ gh pr merge 123 --rebase

# Check PR status
$ gh pr checks 123

# Comment on a PR
$ gh pr comment 123 --body "Looks good!"
```

### Issue Management

**Create and manage issues:**
```bash
# Create an issue
$ gh issue create --title "Bug report" --body "Description"

# List issues
$ gh issue list --label bug --state open

# View issue details
$ gh issue view 456

# Close an issue
$ gh issue close 456

# Reopen an issue
$ gh issue reopen 456

# Create a branch linked to an issue
$ gh issue develop 456 --name fix-bug-456
```

### GitHub Actions

**Workflow operations:**
```bash
# List workflows
$ gh workflow list

# Trigger a workflow
$ gh workflow run build.yml

# View workflow runs
$ gh run list --workflow build.yml

# Watch a workflow run in real-time
$ gh run watch 123456

# Download workflow artifacts
$ gh run download 123456

# Rerun a failed workflow
$ gh run rerun 123456 --failed
```

### Release Management

**Create and manage releases:**
```bash
# Create a release
$ gh release create v1.0.0 --title "Version 1.0.0" --notes "Release notes"

# Create release with assets
$ gh release create v1.0.0 dist/*.zip --notes "Release with binaries"

# List releases
$ gh release list

# View release details
$ gh release view v1.0.0

# Download release assets
$ gh release download v1.0.0

# Delete a release
$ gh release delete v1.0.0
```

### Search Commands

**Search across GitHub:**
```bash
# Search for code
$ gh search code "function authenticate" --language go

# Search for repositories
$ gh search repos "machine learning" --language python --stars ">1000"

# Search for issues
$ gh search issues "bug" --repo owner/repo --state open

# Search for PRs
$ gh search prs "feature" --author username

# Exclude results (use -- to prevent flag parsing)
$ gh search issues -- "my-query -label:bug"
```

### Gist Management

**Create and manage gists:**
```bash
# Create a gist from file
$ gh gist create myfile.py --desc "Python script"

# Create public gist
$ gh gist create myfile.py --public

# List your gists
$ gh gist list

# View a gist
$ gh gist view <gist-id>

# Clone a gist
$ gh gist clone <gist-id>
```

### Label Management

**Manage repository labels:**
```bash
# Clone labels from another repo
$ gh label clone cli/cli --force

# Create a label
$ gh label create bug --color FF0000 --description "Bug reports"

# Edit a label
$ gh label edit bug --color FF0000 --name big-bug

# List labels
$ gh label list
```

## Reference Files

This skill includes comprehensive documentation in `references/`:

- **actions.md** - Actions documentation
- **getting_started.md** - Getting Started documentation
- **gist.md** - Gist documentation
- **issues.md** - Issues documentation
- **other.md** - Other documentation
- **pull_requests.md** - Pull Requests documentation
- **release.md** - Release documentation
- **repositories.md** - Repositories documentation

Use `view` to read specific reference files when detailed information is needed.

## Advanced Features

### API Interactions

**Make authenticated API calls:**
```bash
# Make a GET request
$ gh api repos/owner/repo

# Make a POST request
$ gh api repos/owner/repo/issues -f title="Bug" -f body="Description"

# Use GraphQL API
$ gh api graphql -f query='query { viewer { login } }'

# Paginate through results
$ gh api --paginate repos/owner/repo/issues
```

### Extensions

**Manage gh extensions:**
```bash
# Install an extension
$ gh extension install owner/gh-extension

# List installed extensions
$ gh extension list

# Search for extensions
$ gh extension search copilot

# Upgrade extensions
$ gh extension upgrade --all

# Create your own extension
$ gh extension create my-extension
```

### Aliases

**Create custom command aliases:**
```bash
# Create an alias
$ gh alias set pv 'pr view'

# List aliases
$ gh alias list

# Use the alias
$ gh pv 123

# Delete an alias
$ gh alias delete pv
```

### Secrets and Variables

**Manage repository secrets:**
```bash
# Set a secret
$ gh secret set MY_SECRET --body "secret-value"

# Set a secret from file
$ gh secret set MY_SECRET < secret.txt

# List secrets
$ gh secret list

# Delete a secret
$ gh secret delete MY_SECRET
```

**Manage repository variables:**
```bash
# Set a variable
$ gh variable set MY_VAR --body "value"

# List variables
$ gh variable list

# Get a variable value
$ gh variable get MY_VAR

# Delete a variable
$ gh variable delete MY_VAR
```

### Projects (Beta)

**Manage GitHub Projects:**
```bash
# Create a project
$ gh project create --owner monalisa --title "My Project"

# List projects
$ gh project list

# View project details
$ gh project view 123

# Add item to project
$ gh project item-add 123 --url https://github.com/owner/repo/issues/456

# Edit project item
$ gh project item-edit --id <item-id> --field-id <field-id> --text "In Progress"
```

## Common Workflows

### 1. Contributing to an Open Source Project

```bash
# Fork the repository
$ gh repo fork owner/repo --clone

# Create a new branch
$ git checkout -b feature-branch

# Make changes, then create a PR
$ gh pr create --title "Add new feature" --body "Description"

# Respond to review comments
$ gh pr review <pr-number> --comment --body "Updated per feedback"
```

### 2. Managing a Release

```bash
# Tag your release
$ git tag v1.0.0
$ git push origin v1.0.0

# Create GitHub release with assets
$ gh release create v1.0.0 \
    --title "Version 1.0.0" \
    --notes "Release notes here" \
    dist/*.tar.gz dist/*.zip

# Verify release attestations (if using artifact attestation)
$ gh release verify v1.0.0
```

### 3. CI/CD Debugging

```bash
# Watch a workflow run in progress
$ gh run watch

# View failed jobs
$ gh run view <run-id> --log-failed

# Download artifacts for local testing
$ gh run download <run-id>

# Rerun only failed jobs
$ gh run rerun <run-id> --failed

# View workflow logs
$ gh run view <run-id> --log
```

### 4. Team Collaboration

```bash
# Assign issue to team member
$ gh issue create --title "Task" --assignee username

# Request PR review from team
$ gh pr create --reviewer user1,user2

# Check PR review status
$ gh pr status

# Merge when ready
$ gh pr merge --auto --squash
```

## Tips and Best Practices

1. **Set Default Repository:** Use `gh repo set-default` in your project directory to avoid typing `--repo` flag

2. **Use Web Flag:** Add `--web` or `-w` to most commands to open in browser instead of terminal

3. **JSON Output:** Add `--json` flag to get machine-readable output for scripting

4. **Interactive Mode:** Many commands support interactive prompts if you omit required flags

5. **Environment Variables:** Configure gh behavior with:
   - `GH_TOKEN` - Authentication token
   - `GH_REPO` - Default repository
   - `GH_HOST` - GitHub hostname (for Enterprise)
   - `GH_EDITOR` - Preferred text editor

6. **Auto-completion:** Enable shell completion with `gh completion -s bash/zsh/fish`

## Working with This Skill

### For Beginners
Start with authentication (`gh auth login`) and basic commands like `gh repo view`, `gh issue list`, and `gh pr status`. The reference files contain detailed explanations and more examples.

### For Specific Features
Use the appropriate category reference file for detailed command documentation:
- `references/repositories.md` - Repository operations
- `references/pull_requests.md` - PR workflows
- `references/issues.md` - Issue management
- `references/actions.md` - GitHub Actions
- `references/release.md` - Release management

### For Advanced Users
Explore extensions, API interactions, and automation workflows. Combine gh with shell scripts and git hooks for powerful automation.

## Resources

### references/
Organized documentation extracted from official sources. These files contain:
- Detailed explanations
- Code examples with language annotations
- Links to original documentation
- Table of contents for quick navigation

### scripts/
Add helper scripts here for common automation tasks.

### assets/
Add templates, boilerplate, or example projects here.

## Notes

- This skill was automatically generated from official documentation
- Reference files preserve the structure and examples from source docs
- Code examples include language detection for better syntax highlighting
- Quick reference patterns are extracted from common usage examples in the docs

## Updating

To refresh this skill with updated documentation:
1. Re-run the scraper with the same configuration
2. The skill will be rebuilt with the latest information
