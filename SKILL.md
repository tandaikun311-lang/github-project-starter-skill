---
name: github-project-starter
description: Create beginner-friendly GitHub project repositories from reusable templates, initialize git, and optionally publish them with gh. Use when the user wants to create a new GitHub repository, template project, Codex skill repo, website repo, automation repo, or asks how to help others install a GitHub-backed skill.
---

# GitHub Project Starter

This skill creates a clean project folder from a template and helps publish it to GitHub.

## Use When

- The user wants to create a new GitHub repository.
- The user wants a reusable project template.
- The user wants to package a Codex / Claude skill into a GitHub repo.
- The user wants to help beginners create their first GitHub repo.
- The user says: "弄一个仓库", "做成技能", "别人直接安装", "发链接安装", "创建 GitHub 项目".

## Project Types

- `basic-repo`: general project
- `website-repo`: static website project
- `skill-repo`: Codex / Claude skill project
- `automation-repo`: shell automation project

## Default Workflow

1. Decide the project type from the user's request.
2. Choose a clear repository name using lowercase letters, numbers, and hyphens.
3. Create the project from `scripts/create_project.sh`.
4. Inspect the generated files before publishing.
5. Run a simple local check:
   - `find . -maxdepth 3 -type f`
   - scan for placeholder values and secret-looking strings
6. If the user wants GitHub publishing:
   - verify `gh auth status`
   - initialize git if needed
   - commit intentionally
   - create the GitHub repo with `gh repo create`
   - push
7. Return the GitHub URL and install command.

## Commands

Create a project:

```bash
~/.codex/skills/github-project-starter/scripts/create_project.sh \
  --type website-repo \
  --name my-brand-site \
  --output ~/Projects
```

Create and publish manually:

```bash
cd ~/Projects/my-brand-site
git init
git add .
git commit -m "Initial project scaffold"
gh repo create my-brand-site --public --source . --remote origin --push
```

## Safety Rules

- Do not upload secrets, cookies, tokens, passwords, browser profiles, or local user data.
- Do not make a repository public if it contains private business files or credentials.
- If existing files are present in the output folder, stop instead of overwriting.
- For beginners, prefer public template repos only when the content is intentionally reusable.
- Keep README instructions simple enough for a first-time GitHub user.

## Output

Always return:

- local path
- GitHub URL if published
- install command if the project is a skill
- what the generated project contains
- any remaining manual step, such as `gh auth login`

