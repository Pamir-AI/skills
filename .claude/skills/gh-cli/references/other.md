# Gh-Cli - Other

**Pages:** 65

---

## 

**URL:** https://cli.github.com/manual/gh_label_edit

**Contents:**
- gh label edit
  - Options
  - Options inherited from parent commands
  - Examples
  - See also

Update a label on GitHub.

A label can be renamed using the --name flag.

The label color needs to be 6 character hex value.

**Examples:**

Example 1 (unknown):
```unknown
gh label edit <name> [flags]
```

Example 2 (bash):
```bash
# Update the color of the bug label
$ gh label edit bug --color FF0000

# Rename and edit the description of the bug label
$ gh label edit bug --name big-bug --description "Bigger than normal bug"
```

---

## 

**URL:** https://cli.github.com/manual/gh_secret_delete

**Contents:**
- gh secret delete
  - Options
  - Options inherited from parent commands
  - ALIASES
  - See also

Delete a secret on one of the following levels:

**Examples:**

Example 1 (unknown):
```unknown
gh secret delete <secret-name> [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_create

**Contents:**
- gh codespace create
  - Options
  - See also

**Examples:**

Example 1 (unknown):
```unknown
gh codespace create [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_ssh-key_add

**Contents:**
- gh ssh-key add
  - Options
  - See also

Add an SSH key to your GitHub account

**Examples:**

Example 1 (unknown):
```unknown
gh ssh-key add [<key-file>] [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_completion

**Contents:**
- gh completion
  - bash
  - zsh
  - fish
  - PowerShell
  - Options
  - See also

Generate shell completion scripts for GitHub CLI commands.

When installing GitHub CLI through a package manager, it's possible that no additional shell configuration is necessary to gain completion support. For Homebrew, see https://docs.brew.sh/Shell-Completion

If you need to set up completions manually, follow the instructions below. The exact config file locations might vary based on your system. Make sure to restart your shell before testing whether completions are working.

First, ensure that you install bash-completion using your package manager.

After, add this to your ~/.bash_profile:

Generate a _gh completion script and put it somewhere in your $fpath:

Ensure that the following is present in your ~/.zshrc:

Zsh version 5.7 or later is recommended.

Generate a gh.fish completion script:

Open your profile script with:

Add the line and save the file:

**Examples:**

Example 1 (unknown):
```unknown
gh completion -s <shell>
```

Example 2 (unknown):
```unknown
eval "$(gh completion -s bash)"
```

Example 3 (unknown):
```unknown
gh completion -s zsh > /usr/local/share/zsh/site-functions/_gh
```

Example 4 (unknown):
```unknown
autoload -U compinit
compinit -i
```

---

## 

**URL:** https://cli.github.com/manual/gh_config_set

**Contents:**
- gh config set
  - Options
  - Examples
  - See also

Update configuration with a value for the given key

**Examples:**

Example 1 (unknown):
```unknown
gh config set <key> <value> [flags]
```

Example 2 (bash):
```bash
$ gh config set editor vim
$ gh config set editor "code --wait"
$ gh config set git_protocol ssh --host github.com
$ gh config set prompt disabled
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_edit

**Contents:**
- gh codespace edit
  - Options
  - See also

**Examples:**

Example 1 (unknown):
```unknown
gh codespace edit [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_ssh-key_list

**Contents:**
- gh ssh-key list
  - ALIASES
  - See also

Lists SSH keys in your GitHub account

**Examples:**

Example 1 (unknown):
```unknown
gh ssh-key list
```

---

## 

**URL:** https://cli.github.com/manual/gh_config_list

**Contents:**
- gh config list
  - Options
  - ALIASES
  - See also

Print a list of configuration keys and values

**Examples:**

Example 1 (unknown):
```unknown
gh config list [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_help_environment

**Contents:**
- gh environment
  - See also

GH_TOKEN, GITHUB_TOKEN (in order of precedence): an authentication token that will be used when a command targets either github.com or a subdomain of ghe.com. Setting this avoids being prompted to authenticate and takes precedence over previously stored credentials.

GH_ENTERPRISE_TOKEN, GITHUB_ENTERPRISE_TOKEN (in order of precedence): an authentication token that will be used when a command targets a GitHub Enterprise Server host.

GH_HOST: specify the GitHub hostname for commands where a hostname has not been provided, or cannot be inferred from the context of a local Git repository. If this host was previously authenticated with, the stored credentials will be used. Otherwise, setting GH_TOKEN or GH_ENTERPRISE_TOKEN is required, depending on the targeted host.

GH_REPO: specify the GitHub repository in the [HOST/]OWNER/REPO format for commands that otherwise operate on a local repository.

GH_EDITOR, GIT_EDITOR, VISUAL, EDITOR (in order of precedence): the editor tool to use for authoring text.

GH_BROWSER, BROWSER (in order of precedence): the web browser to use for opening links.

GH_DEBUG: set to a truthy value to enable verbose output on standard error. Set to api to additionally log details of HTTP traffic.

DEBUG (deprecated): set to 1, true, or yes to enable verbose output on standard error.

GH_PAGER, PAGER (in order of precedence): a terminal paging program to send standard output to, e.g. less.

GLAMOUR_STYLE: the style to use for rendering Markdown. See https://github.com/charmbracelet/glamour#styles

NO_COLOR: set to any value to avoid printing ANSI escape sequences for color output.

CLICOLOR: set to 0 to disable printing ANSI colors in output.

CLICOLOR_FORCE: set to a value other than 0 to keep ANSI colors in output even when the output is piped.

GH_COLOR_LABELS: set to any value to display labels using their RGB hex color codes in terminals that support truecolor.

GH_ACCESSIBLE_COLORS (preview): set to a truthy value to use customizable, 4-bit accessible colors.

GH_FORCE_TTY: set to any value to force terminal-style output even when the output is redirected. When the value is a number, it is interpreted as the number of columns available in the viewport. When the value is a percentage, it will be applied against the number of columns available in the current viewport.

GH_NO_UPDATE_NOTIFIER: set to any value to disable GitHub CLI update notifications. When any command is executed, gh checks for new versions once every 24 hours. If a newer version was found, an upgrade notice is displayed on standard error.

GH_NO_EXTENSION_UPDATE_NOTIFIER: set to any value to disable GitHub CLI extension update notifications. When an extension is executed, gh checks for new versions for the executed extension once every 24 hours. If a newer version was found, an upgrade notice is displayed on standard error.

GH_CONFIG_DIR: the directory where gh will store configuration files. If not specified, the default value will be one of the following paths (in order of precedence):

GH_PROMPT_DISABLED: set to any value to disable interactive prompting in the terminal.

GH_PATH: set the path to the gh executable, useful for when gh can not properly determine its own path such as in the cygwin terminal.

GH_MDWIDTH: default maximum width for markdown render wrapping. The max width of lines wrapped on the terminal will be taken as the lesser of the terminal width, this value, or 120 if not specified. This value is used, for example, with pr view subcommand.

GH_ACCESSIBLE_PROMPTER (preview): set to a truthy value to enable prompts that are more compatible with speech synthesis and braille screen readers.

GH_SPINNER_DISABLED: set to a truthy value to replace the spinner animation with a textual progress indicator.

---

## 

**URL:** https://cli.github.com/manual/gh_gpg-key_delete

**Contents:**
- gh gpg-key delete
  - Options
  - See also

Delete a GPG key from your GitHub account

**Examples:**

Example 1 (unknown):
```unknown
gh gpg-key delete <key-id> [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh

**Contents:**
- gh
  - Core commands
  - GitHub Actions commands
  - Additional commands
  - Options
  - Examples

Work seamlessly with GitHub from the command line.

**Examples:**

Example 1 (bash):
```bash
$ gh issue create
$ gh repo clone cli/cli
$ gh pr checkout 321
```

---

## 

**URL:** https://cli.github.com/manual/gh_auth_switch

**Contents:**
- gh auth switch
  - Options
  - Examples
  - See also

Switch the active account for a GitHub host.

This command changes the authentication configuration that will be used when running commands targeting the specified GitHub host.

If the specified host has two accounts, the active account will be switched automatically. If there are more than two accounts, disambiguation will be required either through the --user flag or an interactive prompt.

For a list of authenticated accounts you can run gh auth status.

**Examples:**

Example 1 (unknown):
```unknown
gh auth switch [flags]
```

Example 2 (bash):
```bash
# Select what host and account to switch to via a prompt
$ gh auth switch

# Switch the active account on a specific host to a specific user
$ gh auth switch --hostname enterprise.internal --user monalisa
```

---

## 

**URL:** https://cli.github.com/manual/gh_auth

**Contents:**
- gh auth
  - Available commands
  - See also

Authenticate gh and git with GitHub

---

## 

**URL:** https://cli.github.com/manual/gh_extension_remove

**Contents:**
- gh extension remove
  - See also

Remove an installed extension

**Examples:**

Example 1 (unknown):
```unknown
gh extension remove <name>
```

---

## 

**URL:** https://cli.github.com/manual/gh_alias

**Contents:**
- gh alias
  - Available commands
  - See also

Aliases can be used to make shortcuts for gh commands or to compose multiple commands.

Run gh help alias set to learn more.

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_code

**Contents:**
- gh codespace code
  - Options
  - See also

Open a codespace in Visual Studio Code

**Examples:**

Example 1 (unknown):
```unknown
gh codespace code [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_gpg-key_list

**Contents:**
- gh gpg-key list
  - ALIASES
  - See also

Lists GPG keys in your GitHub account

**Examples:**

Example 1 (unknown):
```unknown
gh gpg-key list
```

---

## 

**URL:** https://cli.github.com/manual/gh_ssh-key

**Contents:**
- gh ssh-key
  - Available commands
  - See also

Manage SSH keys registered with your GitHub account.

---

## 

**URL:** https://cli.github.com/manual/gh_cache_delete

**Contents:**
- gh cache delete
  - Options
  - Options inherited from parent commands
  - Examples
  - See also

Delete GitHub Actions caches.

Deletion requires authorization with the repo scope.

**Examples:**

Example 1 (unknown):
```unknown
gh cache delete [<cache-id> | <cache-key> | --all] [flags]
```

Example 2 (bash):
```bash
# Delete a cache by id
$ gh cache delete 1234

# Delete a cache by key
$ gh cache delete cache-key

# Delete a cache by id in a specific repo
$ gh cache delete 1234 --repo cli/cli

# Delete a cache by key and branch ref
$ gh cache delete cache-key --ref refs/heads/feature-branch

# Delete a cache by key and PR ref
$ gh cache delete cache-key --ref refs/pull/<PR-number>/merge

# Delete all caches (exit code 1 on no caches)
$ gh cache delete --all

# Delete all caches (exit code 0 on no caches)
$ gh cache delete --all --succeed-on-no-caches
```

---

## 

**URL:** https://cli.github.com/manual/gh_agent-task_view

**Contents:**
- gh agent-task view
  - Options
  - Examples
  - See also

View an agent task session.

**Examples:**

Example 1 (unknown):
```unknown
gh agent-task view [<session-id> | <pr-number> | <pr-url> | <pr-branch>] [flags]
```

Example 2 (bash):
```bash
# View an agent task by session ID
$ gh agent-task view e2fa49d2-f164-4a56-ab99-498090b8fcdf

# View an agent task by pull request number in current repo
$ gh agent-task view 12345

# View an agent task by pull request number
$ gh agent-task view --repo OWNER/REPO 12345

# View an agent task by pull request reference
$ gh agent-task view OWNER/REPO#12345

# View a pull request agents tasks in the browser
$ gh agent-task view 12345 --web
```

---

## 

**URL:** https://cli.github.com/manual/gh_variable_delete

**Contents:**
- gh variable delete
  - Options
  - Options inherited from parent commands
  - ALIASES
  - See also

Delete a variable on one of the following levels:

**Examples:**

Example 1 (unknown):
```unknown
gh variable delete <variable-name> [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_org

**Contents:**
- gh org
  - General commands
  - Examples
  - See also

Work with GitHub organizations.

**Examples:**

Example 1 (bash):
```bash
$ gh org list
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_cp

**Contents:**
- gh codespace cp
  - Options
  - Examples
  - See also

The cp command copies files between the local and remote file systems.

As with the UNIX cp command, the first argument specifies the source and the last specifies the destination; additional sources may be specified after the first, if the destination is a directory.

The --recursive flag is required if any source is a directory.

A remote: prefix on any file name argument indicates that it refers to the file system of the remote (Codespace) machine. It is resolved relative to the home directory of the remote user.

By default, remote file names are interpreted literally. With the --expand flag, each such argument is treated in the manner of scp, as a Bash expression to be evaluated on the remote machine, subject to expansion of tildes, braces, globs, environment variables, and backticks. For security, do not use this flag with arguments provided by untrusted users; see https://lwn.net/Articles/835962/ for discussion.

By default, the cp command will create a public/private ssh key pair to authenticate with the codespace inside the ~/.ssh directory.

**Examples:**

Example 1 (unknown):
```unknown
gh codespace cp [-e] [-r] [-- [<scp flags>...]] <sources>... <dest>
```

Example 2 (bash):
```bash
$ gh codespace cp -e README.md 'remote:/workspaces/$RepositoryName/'
$ gh codespace cp -e 'remote:~/*.go' ./gofiles/
$ gh codespace cp -e 'remote:/workspaces/myproj/go.{mod,sum}' ./gofiles/
$ gh codespace cp -e -- -F ~/.ssh/codespaces_config 'remote:~/*.go' ./gofiles/
```

---

## 

**URL:** https://cli.github.com/manual/gh_extension_list

**Contents:**
- gh extension list
  - ALIASES
  - See also

List installed extension commands

gh extension ls, gh extensions ls, gh ext ls

**Examples:**

Example 1 (unknown):
```unknown
gh extension list
```

---

## 

**URL:** https://cli.github.com/manual/gh_alias_list

**Contents:**
- gh alias list
  - ALIASES
  - See also

This command prints out all of the aliases gh is configured to use.

**Examples:**

Example 1 (unknown):
```unknown
gh alias list
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace

**Contents:**
- gh codespace
  - Available commands
  - ALIASES
  - See also

Connect to and manage codespaces

---

## 

**URL:** https://cli.github.com/manual/gh_auth_login

**Contents:**
- gh auth login
  - Options
  - Examples
  - See also

Authenticate with a GitHub host.

The default hostname is github.com. This can be overridden using the --hostname flag.

The default authentication mode is a web-based browser flow. After completion, an authentication token will be stored securely in the system credential store. If a credential store is not found or there is an issue using it gh will fallback to writing the token to a plain text file. See gh auth status for its stored location.

Alternatively, use --with-token to pass in a personal access token (classic) on standard input. The minimum required scopes for the token are: repo, read:org, and gist. Take care when passing a fine-grained personal access token to --with-token as the inherent scoping to certain resources may cause confusing behaviour when interacting with other resources. Favour setting GH_TOKEN for fine-grained personal access token usage.

Alternatively, gh will use the authentication token found in environment variables. This method is most suitable for "headless" use of gh such as in automation. See gh help environment for more info.

To use gh in GitHub Actions, add GH_TOKEN: ${{ github.token }} to env.

The git protocol to use for git operations on this host can be set with --git-protocol, or during the interactive prompting. Although login is for a single account on a host, setting the git protocol will take effect for all users on the host.

Specifying ssh for the git protocol will detect existing SSH keys to upload, prompting to create and upload a new key if one is not found. This can be skipped with --skip-ssh-key flag.

For more information on OAuth scopes, see https://docs.github.com/en/developers/apps/building-oauth-apps/scopes-for-oauth-apps/.

**Examples:**

Example 1 (unknown):
```unknown
gh auth login [flags]
```

Example 2 (bash):
```bash
# Start interactive setup
$ gh auth login

# Open a browser to authenticate and copy one-time OAuth code to clipboard
$ gh auth login --web --clipboard

# Authenticate against github.com by reading the token from a file
$ gh auth login --with-token < mytoken.txt

# Authenticate with specific host
$ gh auth login --hostname enterprise.internal
```

---

## 

**URL:** https://cli.github.com/manual/gh_label_create

**Contents:**
- gh label create
  - Options
  - Options inherited from parent commands
  - Examples
  - See also

Create a new label on GitHub, or update an existing one with --force.

Must specify name for the label. The description and color are optional. If a color isn't provided, a random one will be chosen.

The label color needs to be 6 character hex value.

**Examples:**

Example 1 (unknown):
```unknown
gh label create <name> [flags]
```

Example 2 (bash):
```bash
# Create new bug label
$ gh label create bug --description "Something isn't working" --color E99695
```

---

## 

**URL:** https://cli.github.com/manual/gh_status

**Contents:**
- gh status
  - Options
  - Examples
  - See also

The status command prints information about your work on GitHub across all the repositories you're subscribed to, including:

**Examples:**

Example 1 (unknown):
```unknown
gh status [flags]
```

Example 2 (bash):
```bash
$ gh status -e cli/cli -e cli/go-gh # Exclude multiple repositories
$ gh status -o cli # Limit results to a single organization
```

---

## 

**URL:** https://cli.github.com/manual/gh_variable_get

**Contents:**
- gh variable get
  - Options
  - Options inherited from parent commands
  - JSON Fields
  - See also

Get a variable on one of the following levels:

createdAt, name, numSelectedRepos, selectedReposURL, updatedAt, value, visibility

**Examples:**

Example 1 (unknown):
```unknown
gh variable get <variable-name> [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_rebuild

**Contents:**
- gh codespace rebuild
  - Options
  - See also

Rebuilding recreates your codespace.

Your code and any current changes will be preserved. Your codespace will be rebuilt using your working directory's dev container. A full rebuild also removes cached Docker images.

**Examples:**

Example 1 (unknown):
```unknown
gh codespace rebuild [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_ssh

**Contents:**
- gh codespace ssh
  - Options
  - Examples
  - See also

The ssh command is used to SSH into a codespace. In its simplest form, you can run gh cs ssh, select a codespace interactively, and connect.

The ssh command will automatically create a public/private ssh key pair in the ~/.ssh directory if you do not have an existing valid key pair. When selecting the key pair to use, the preferred order is:

The ssh command also supports deeper integration with OpenSSH using a --config option that generates per-codespace ssh configuration in OpenSSH format. Including this configuration in your ~/.ssh/config improves the user experience of tools that integrate with OpenSSH, such as Bash/Zsh completion of ssh hostnames, remote path completion for scp/rsync/sshfs, git ssh remotes, and so on.

Once that is set up (see the second example below), you can ssh to codespaces as if they were ordinary remote hosts (using ssh, not gh cs ssh).

Note that the codespace you are connecting to must have an SSH server pre-installed. If the docker image being used for the codespace does not have an SSH server, install it in your Dockerfile or, for codespaces that use Debian-based images, you can add the following to your devcontainer.json:

**Examples:**

Example 1 (unknown):
```unknown
gh codespace ssh [<flags>...] [-- <ssh-flags>...] [<command>]
```

Example 2 (unknown):
```unknown
"features": {
	"ghcr.io/devcontainers/features/sshd:1": {
		"version": "latest"
	}
}
```

Example 3 (bash):
```bash
$ gh codespace ssh

$ gh codespace ssh --config > ~/.ssh/codespaces
$ printf 'Match all\nInclude ~/.ssh/codespaces\n' >> ~/.ssh/config
```

---

## 

**URL:** https://cli.github.com/manual/gh_extension_browse

**Contents:**
- gh extension browse
  - Options
  - See also

This command will take over your terminal and run a fully interactive interface for browsing, adding, and removing gh extensions. A terminal width greater than 100 columns is recommended.

To learn how to control this interface, press ? after running to see the help text.

Running this command with --single-column should make this command more intelligible for users who rely on assistive technology like screen readers or high zoom.

For a more traditional way to discover extensions, see:

along with gh ext install, gh ext remove, and gh repo view.

**Examples:**

Example 1 (unknown):
```unknown
gh extension browse [flags]
```

Example 2 (unknown):
```unknown
gh ext search
```

---

## 

**URL:** https://cli.github.com/manual/gh_cache

**Contents:**
- gh cache
  - Available commands
  - Options
  - Examples
  - See also

Work with GitHub Actions caches.

**Examples:**

Example 1 (bash):
```bash
$ gh cache list
$ gh cache delete --all
```

---

## 

**URL:** https://cli.github.com/manual/gh_auth_status

**Contents:**
- gh auth status
  - Options
  - JSON Fields
  - Examples
  - See also

Display active account and authentication state on each known GitHub host.

For each host, the authentication state of each known account is tested and any issues are included in the output. Each host section will indicate the active account, which will be used when targeting that host.

If an account on any host (or only the one given via --hostname) has authentication issues, the command will exit with 1 and output to stderr. Note that when using the --json option, the command will always exit with zero regardless of any authentication issues, unless there is a fatal error.

To change the active account for a host, see gh auth switch.

**Examples:**

Example 1 (unknown):
```unknown
gh auth status [flags]
```

Example 2 (bash):
```bash
# Display authentication status for all accounts on all hosts
$ gh auth status

# Display authentication status for the active account on a specific host
$ gh auth status --active --hostname github.example.com

# Display tokens in plain text
$ gh auth status --show-token

# Format authentication status as JSON
$ gh auth status --json hosts

# Include plain text token in JSON output
$ gh auth status --json hosts --show-token

# Format hosts as a flat JSON array
$ gh auth status --json hosts --jq '.hosts | add'
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_stop

**Contents:**
- gh codespace stop
  - Options
  - See also

Stop a running codespace

**Examples:**

Example 1 (unknown):
```unknown
gh codespace stop [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_auth_logout

**Contents:**
- gh auth logout
  - Options
  - Examples
  - See also

Remove authentication for a GitHub account.

This command removes the stored authentication configuration for an account. The authentication configuration is only removed locally.

This command does not revoke authentication tokens.

To revoke all authentication tokens generated by the GitHub CLI:

Note: this procedure will revoke all authentication tokens ever generated by the GitHub CLI across all your devices.

For more information about revoking OAuth application tokens, see: https://docs.github.com/en/apps/oauth-apps/using-oauth-apps/reviewing-your-authorized-oauth-apps

**Examples:**

Example 1 (unknown):
```unknown
gh auth logout [flags]
```

Example 2 (bash):
```bash
# Select what host and account to log out of via a prompt
$ gh auth logout

# Log out of a specific host and specific account
$ gh auth logout --hostname enterprise.internal --user monalisa
```

---

## 

**URL:** https://cli.github.com/manual/gh_alias_delete

**Contents:**
- gh alias delete
  - Options
  - See also

**Examples:**

Example 1 (unknown):
```unknown
gh alias delete {<alias> | --all} [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_label

**Contents:**
- gh label
  - Available commands
  - Options
  - See also

Work with GitHub labels.

---

## 

**URL:** https://cli.github.com/manual/gh_extension_upgrade

**Contents:**
- gh extension upgrade
  - Options
  - See also

Upgrade installed extensions

**Examples:**

Example 1 (unknown):
```unknown
gh extension upgrade {<name> | --all} [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_logs

**Contents:**
- gh codespace logs
  - Options
  - See also

Access codespace logs

**Examples:**

Example 1 (unknown):
```unknown
gh codespace logs [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_attestation_trusted-root

**Contents:**
- gh attestation trusted-root
  - Options
  - Examples
  - See also

Output contents for a trusted_root.jsonl file, likely for offline verification.

When using gh attestation verify, if your machine is on the internet, this will happen automatically. But to do offline verification, you need to supply a trusted root file with --custom-trusted-root; this command will help you fetch a trusted_root.jsonl file for that purpose.

You can call this command without any flags to get a trusted root file covering the Sigstore Public Good Instance as well as GitHub's Sigstore instance.

Otherwise you can use --tuf-url to specify the URL of a custom TUF repository mirror, and --tuf-root should be the path to the root.json file that you securely obtained out-of-band.

If you just want to verify the integrity of your local TUF repository, and don't want the contents of a trusted_root.jsonl file, use --verify-only.

**Examples:**

Example 1 (unknown):
```unknown
gh attestation trusted-root [--tuf-url <url> --tuf-root <file-path>] [--verify-only] [flags]
```

Example 2 (bash):
```bash
# Get a trusted_root.jsonl for both Sigstore Public Good and GitHub's instance
$ gh attestation trusted-root
```

---

## GitHub CLI manual

**URL:** https://cli.github.com/manual/

**Contents:**
- GitHub CLI manual
- Installation
- Configuration
- GitHub Enterprise
- Support

GitHub CLI, or gh, is a command-line interface to GitHub for use in your terminal or your scripts.

You can find installation instructions on our README.

Run gh auth login to authenticate with your GitHub account. Alternatively, gh will respect the GITHUB_TOKEN environment variable.

To set your preferred editor, use gh config set editor <editor>. Read more about gh config and environment variables.

Declare your aliases for often-used commands with gh alias set.

GitHub CLI supports GitHub Enterprise Server 2.20 and above. To authenticate with a GitHub instance, run:

To define this host as a default for all GitHub CLI commands, set the GH_HOST environment variable:

Finally, to authenticate commands in scripting mode or automation, set the GH_ENTERPRISE_TOKEN:

Ask usage questions and send us feedback in Discussions

Report bugs or search for existing feature requests in our issue tracker

**Examples:**

Example 1 (unknown):
```unknown
gh auth login --hostname <hostname>
```

Example 2 (unknown):
```unknown
export GH_HOST=<hostname>
```

Example 3 (unknown):
```unknown
export GH_ENTERPRISE_TOKEN=<access-token>
```

---

## 

**URL:** https://cli.github.com/manual/gh_auth_refresh

**Contents:**
- gh auth refresh
  - Options
  - Examples
  - See also

Expand or fix the permission scopes for stored credentials for active account.

The --scopes flag accepts a comma separated list of scopes you want your gh credentials to have. If no scopes are provided, the command maintains previously added scopes.

The --remove-scopes flag accepts a comma separated list of scopes you want to remove from your gh credentials. Scope removal is idempotent. The minimum set of scopes (repo, read:org, and gist) cannot be removed.

The --reset-scopes flag resets the scopes for your gh credentials to the default set of scopes for your auth flow.

If you have multiple accounts in gh auth status and want to refresh the credentials for an inactive account, you will have to use gh auth switch to that account first before using this command, and then switch back when you are done.

For more information on OAuth scopes, see https://docs.github.com/en/developers/apps/building-oauth-apps/scopes-for-oauth-apps/.

**Examples:**

Example 1 (unknown):
```unknown
gh auth refresh [flags]
```

Example 2 (bash):
```bash
# Open a browser to add write:org and read:public_key scopes
$ gh auth refresh --scopes write:org,read:public_key

# Open a browser to ensure your authentication credentials have the correct minimum scopes
$ gh auth refresh

# Open a browser to idempotently remove the delete_repo scope
$ gh auth refresh --remove-scopes delete_repo

# Open a browser to re-authenticate with the default minimum scopes
$ gh auth refresh --reset-scopes

# Open a browser to re-authenticate and copy one-time OAuth code to clipboard
$ gh auth refresh --clipboard
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_jupyter

**Contents:**
- gh codespace jupyter
  - Options
  - See also

Open a codespace in JupyterLab

**Examples:**

Example 1 (unknown):
```unknown
gh codespace jupyter [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_secret_list

**Contents:**
- gh secret list
  - Options
  - Options inherited from parent commands
  - ALIASES
  - JSON Fields
  - See also

List secrets on one of the following levels:

name, numSelectedRepos, selectedReposURL, updatedAt, visibility

**Examples:**

Example 1 (unknown):
```unknown
gh secret list [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_codespace_ports

**Contents:**
- gh codespace ports
  - Available commands
  - Options
  - JSON Fields
  - See also

List ports in a codespace

browseUrl, label, sourcePort, visibility

**Examples:**

Example 1 (unknown):
```unknown
gh codespace ports [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_extension_create

**Contents:**
- gh extension create
  - Options
  - Examples
  - See also

Create a new extension

**Examples:**

Example 1 (unknown):
```unknown
gh extension create [<name>] [flags]
```

Example 2 (bash):
```bash
# Use interactively
$ gh extension create

# Create a script-based extension
$ gh extension create foobar

# Create a Go extension
$ gh extension create --precompiled=go foobar

# Create a non-Go precompiled extension
$ gh extension create --precompiled=other foobar
```

---

## 

**URL:** https://cli.github.com/manual/gh_org_list

**Contents:**
- gh org list
  - Options
  - ALIASES
  - Examples
  - See also

List organizations for the authenticated user.

**Examples:**

Example 1 (unknown):
```unknown
gh org list [flags]
```

Example 2 (bash):
```bash
# List the first 30 organizations
$ gh org list

# List more organizations
$ gh org list --limit 100
```

---

## 

**URL:** https://cli.github.com/manual/gh_config_clear-cache

**Contents:**
- gh config clear-cache
  - Examples
  - See also

**Examples:**

Example 1 (unknown):
```unknown
gh config clear-cache
```

Example 2 (bash):
```bash
# Clear the cli cache
$ gh config clear-cache
```

---

## 

**URL:** https://cli.github.com/manual/gh_variable_list

**Contents:**
- gh variable list
  - Options
  - Options inherited from parent commands
  - ALIASES
  - JSON Fields
  - See also

List variables on one of the following levels:

createdAt, name, numSelectedRepos, selectedReposURL, updatedAt, value, visibility

**Examples:**

Example 1 (unknown):
```unknown
gh variable list [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_gpg-key_add

**Contents:**
- gh gpg-key add
  - Options
  - See also

Add a GPG key to your GitHub account

**Examples:**

Example 1 (unknown):
```unknown
gh gpg-key add [<key-file>] [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_gpg-key

**Contents:**
- gh gpg-key
  - Available commands
  - See also

Manage GPG keys registered with your GitHub account.

---

## 

**URL:** https://cli.github.com/manual/gh_config

**Contents:**
- gh config
  - Available commands
  - See also

Display or change configuration settings for gh.

Current respected settings:

---

## 

**URL:** https://cli.github.com/manual/gh_browse

**Contents:**
- gh browse
  - Options
  - Examples
  - See also

Transition from the terminal to the web browser to view and interact with:

**Examples:**

Example 1 (unknown):
```unknown
gh browse [<number> | <path> | <commit-sha>] [flags]
```

Example 2 (bash):
```bash
# Open the home page of the current repository
$ gh browse

# Open the script directory of the current repository
$ gh browse script/

# Open issue or pull request 217
$ gh browse 217

# Open commit page
$ gh browse 77507cd94ccafcf568f8560cfecde965fcfa63

# Open repository settings
$ gh browse --settings

# Open main.go at line 312
$ gh browse main.go:312

# Open main.go with the repository at head of bug-fix branch
$ gh browse main.go --branch bug-fix

# Open main.go with the repository at commit 775007cd
$ gh browse main.go --commit=77507cd94ccafcf568f8560cfecde965fcfa63
```

---

## 

**URL:** https://cli.github.com/manual/gh_alias_import

**Contents:**
- gh alias import
  - Options
  - Examples
  - See also

Import aliases from the contents of a YAML file.

Aliases should be defined as a map in YAML, where the keys represent aliases and the values represent the corresponding expansions. An example file should look like the following:

Use - to read aliases (in YAML format) from standard input.

The output from gh alias list can be used to produce a YAML file containing your aliases, which you can use to import them from one machine to another. Run gh help alias list to learn more.

**Examples:**

Example 1 (unknown):
```unknown
gh alias import [<filename> | -] [flags]
```

Example 2 (unknown):
```unknown
bugs: issue list --label=bug
igrep: '!gh issue list --label="$1" | grep "$2"'
features: |-
    issue list
    --label=enhancement
```

Example 3 (bash):
```bash
# Import aliases from a file
$ gh alias import aliases.yml

# Import aliases from standard input
$ gh alias import -
```

---

## 

**URL:** https://cli.github.com/manual/gh_ssh-key_delete

**Contents:**
- gh ssh-key delete
  - Options
  - See also

Delete an SSH key from your GitHub account

**Examples:**

Example 1 (unknown):
```unknown
gh ssh-key delete <id> [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_cache_list

**Contents:**
- gh cache list
  - Options
  - Options inherited from parent commands
  - ALIASES
  - JSON Fields
  - Examples
  - See also

List GitHub Actions caches

createdAt, id, key, lastAccessedAt, ref, sizeInBytes, version

**Examples:**

Example 1 (unknown):
```unknown
gh cache list [flags]
```

Example 2 (bash):
```bash
# List caches for current repository
$ gh cache list

# List caches for specific repository
$ gh cache list --repo cli/cli

# List caches sorted by least recently accessed
$ gh cache list --sort last_accessed_at --order asc

# List caches that have keys matching a prefix (or that match exactly)
$ gh cache list --key key-prefix

# List caches for a specific branch, replace <branch-name> with the actual branch name
$ gh cache list --ref refs/heads/<branch-name>

# List caches for a specific pull request, replace <pr-number> with the actual pull request number
$ gh cache list --ref refs/pull/<pr-number>/merge
```

---

## 

**URL:** https://cli.github.com/manual/gh_config_get

**Contents:**
- gh config get
  - Options
  - Examples
  - See also

Print the value of a given configuration key

**Examples:**

Example 1 (unknown):
```unknown
gh config get <key> [flags]
```

Example 2 (bash):
```bash
$ gh config get git_protocol
```

---

## 

**URL:** https://cli.github.com/manual/gh_search

**Contents:**
- gh search
  - Available commands
  - See also

Search across all of GitHub.

Excluding search results that match a qualifier

In a browser, the GitHub search syntax supports excluding results that match a search qualifier by prefixing the qualifier with a hyphen. For example, to search for issues that do not have the label "bug", you would use -label:bug as a search qualifier.

gh supports this syntax in gh search as well, but it requires extra command line arguments to avoid the hyphen being interpreted as a command line flag because it begins with a hyphen.

On Unix-like systems, you can use the -- argument to indicate that the arguments that follow are not a flag, but rather a query string. For example:

$ gh search issues -- "my-search-query -label:bug"

On PowerShell, you must use both the --% argument and the -- argument to produce the same effect. For example:

$ gh --% search issues -- "my search query -label:bug"

See the following for more information:

---

## 

**URL:** https://cli.github.com/manual/gh_attestation

**Contents:**
- gh attestation
  - Available commands
  - ALIASES
  - See also

Download and verify artifact attestations.

---

## 

**URL:** https://cli.github.com/manual/gh_auth_token

**Contents:**
- gh auth token
  - Options
  - See also

This command outputs the authentication token for an account on a given GitHub host.

Without the --hostname flag, the default host is chosen.

Without the --user flag, the active account for the host is chosen.

**Examples:**

Example 1 (unknown):
```unknown
gh auth token [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_secret_set

**Contents:**
- gh secret set
  - Options
  - Options inherited from parent commands
  - Examples
  - See also

Set a value for a secret on one of the following levels:

Organization and user secrets can optionally be restricted to only be available to specific repositories.

Secret values are locally encrypted before being sent to GitHub.

**Examples:**

Example 1 (unknown):
```unknown
gh secret set <secret-name> [flags]
```

Example 2 (bash):
```bash
# Paste secret value for the current repository in an interactive prompt
$ gh secret set MYSECRET

# Read secret value from an environment variable
$ gh secret set MYSECRET --body "$ENV_VALUE"

# Set secret for a specific remote repository
$ gh secret set MYSECRET --repo origin/repo --body "$ENV_VALUE"

# Read secret value from a file
$ gh secret set MYSECRET < myfile.txt

# Set secret for a deployment environment in the current repository
$ gh secret set MYSECRET --env myenvironment

# Set organization-level secret visible to both public and private repositories
$ gh secret set MYSECRET --org myOrg --visibility all

# Set organization-level secret visible to specific repositories
$ gh secret set MYSECRET --org myOrg --repos repo1,repo2,repo3

# Set organization-level secret visible to no repositories
$ gh secret set MYSECRET --org myOrg --no-repos-selected

# Set user-level secret for Codespaces
$ gh secret set MYSECRET --user

# Set repository-level secret for Dependabot
$ gh secret set MYSECRET --app dependabot

# Set multiple secrets imported from the ".env" file
$ gh secret set -f .env

# Set multiple secrets from stdin
$ gh secret set -f - < myfile.txt
```

---

## 

**URL:** https://cli.github.com/manual/gh_alias_set

**Contents:**
- gh alias set
  - Options
  - Examples
  - See also

Define a word that will expand to a full gh command when invoked.

The expansion may specify additional arguments and flags. If the expansion includes positional placeholders such as $1, extra arguments that follow the alias will be inserted appropriately. Otherwise, extra arguments will be appended to the expanded command.

Use - as expansion argument to read the expansion string from standard input. This is useful to avoid quoting issues when defining expansions.

If the expansion starts with ! or if --shell was given, the expansion is a shell expression that will be evaluated through the sh interpreter when the alias is invoked. This allows for chaining multiple commands via piping and redirection.

**Examples:**

Example 1 (unknown):
```unknown
gh alias set <alias> <expansion> [flags]
```

Example 2 (bash):
```bash
# Note: Command Prompt on Windows requires using double quotes for arguments
$ gh alias set pv 'pr view'
$ gh pv -w 123  #=> gh pr view -w 123

$ gh alias set bugs 'issue list --label=bugs'
$ gh bugs

$ gh alias set homework 'issue list --assignee @me'
$ gh homework

$ gh alias set 'issue mine' 'issue list --mention @me'
$ gh issue mine

$ gh alias set epicsBy 'issue list --author="$1" --label="epic"'
$ gh epicsBy vilmibm  #=> gh issue list --author="vilmibm" --label="epic"

$ gh alias set --shell igrep 'gh issue list --label="$1" | grep "$2"'
$ gh igrep epic foo  #=> gh issue list --label="epic" | grep "foo"
```

---
