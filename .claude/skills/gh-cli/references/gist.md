# Gh-Cli - Gist

**Pages:** 7

---

## 

**URL:** https://cli.github.com/manual/gh_gist

**Contents:**
- gh gist
  - Available commands
  - See also

Work with GitHub gists.

---

## 

**URL:** https://cli.github.com/manual/gh_gist_list

**Contents:**
- gh gist list
  - Options
  - ALIASES
  - Examples
  - See also

List gists from your user account.

You can use a regular expression to filter the description, file names, or even the content of files in the gist using --filter.

For supported regular expression syntax, see https://pkg.go.dev/regexp/syntax.

Use --include-content to include content of files, noting that this will be slower and increase the rate limit used. Instead of printing a table, code will be printed with highlights similar to gh search code:

No highlights or other color is printed when output is redirected.

**Examples:**

Example 1 (unknown):
```unknown
gh gist list [flags]
```

Example 2 (unknown):
```unknown
{{gist ID}} {{file name}}
    {{description}}
        {{matching lines from content}}
```

Example 3 (bash):
```bash
# List all secret gists from your user account
$ gh gist list --secret

# Find all gists from your user account mentioning "octo" anywhere
$ gh gist list --filter octo --include-content
```

---

## 

**URL:** https://cli.github.com/manual/gh_gist_create

**Contents:**
- gh gist create
  - Options
  - ALIASES
  - Examples
  - See also

Create a new GitHub gist with given contents.

Gists can be created from one or multiple files. Alternatively, pass - as filename to read from standard input.

By default, gists are secret; use --public to make publicly listed ones.

**Examples:**

Example 1 (unknown):
```unknown
gh gist create [<filename>... | <pattern>... | -] [flags]
```

Example 2 (bash):
```bash
# Publish file 'hello.py' as a public gist
$ gh gist create --public hello.py

# Create a gist with a description
$ gh gist create hello.py -d "my Hello-World program in Python"

# Create a gist containing several files
$ gh gist create hello.py world.py cool.txt

# Create a gist containing several files using patterns
$ gh gist create *.md *.txt artifact.*

# Read from standard input to create a gist
$ gh gist create -

# Create a gist from output piped from another command
$ cat cool.txt | gh gist create
```

---

## 

**URL:** https://cli.github.com/manual/gh_gist_rename

**Contents:**
- gh gist rename
  - See also

Rename a file in the given gist ID / URL.

**Examples:**

Example 1 (unknown):
```unknown
gh gist rename {<id> | <url>} <old-filename> <new-filename>
```

---

## 

**URL:** https://cli.github.com/manual/gh_gist_view

**Contents:**
- gh gist view
  - Options
  - See also

View the given gist or select from recent gists.

**Examples:**

Example 1 (unknown):
```unknown
gh gist view [<id> | <url>] [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_gist_edit

**Contents:**
- gh gist edit
  - Options
  - See also

Edit one of your gists

**Examples:**

Example 1 (unknown):
```unknown
gh gist edit {<id> | <url>} [<filename>] [flags]
```

---

## 

**URL:** https://cli.github.com/manual/gh_gist_delete

**Contents:**
- gh gist delete
  - Options
  - Examples
  - See also

Delete a GitHub gist.

To delete a gist interactively, use gh gist delete with no arguments.

To delete a gist non-interactively, supply the gist id or url.

**Examples:**

Example 1 (unknown):
```unknown
gh gist delete {<id> | <url>} [flags]
```

Example 2 (bash):
```bash
# Delete a gist interactively
$ gh gist delete

# Delete a gist non-interactively
$ gh gist delete 1234
```

---
