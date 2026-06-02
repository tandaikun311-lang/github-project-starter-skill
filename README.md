# GitHub Project Starter Skill

一个给新手和团队用的 GitHub 项目启动技能。

它解决的问题很简单：很多人没有自己的 GitHub 仓库，也不知道一个项目该怎么组织。安装这个技能后，可以让 Codex / Claude 帮你快速创建一个标准项目结构，并推送到自己的 GitHub。

## 适合谁

- 刚开始使用 GitHub 的个人用户
- 想把想法整理成项目仓库的人
- 想快速创建网站、技能、自动化脚本仓库的人
- 想给团队统一项目结构的人

## 一键安装

推荐把下面这条命令直接发给别人，对方复制到终端运行即可：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tandaikun311-lang/github-project-starter-skill/main/scripts/install.sh)"
```

如果对方电脑不能访问 `curl`，也可以用 `git clone`：

```bash
git clone https://github.com/tandaikun311-lang/github-project-starter-skill.git ~/.codex/skills/github-project-starter
```

如果已经安装过，想更新到最新版：

```bash
cd ~/.codex/skills/github-project-starter && git pull
```

## 安装后怎么用

在 Codex 或 Claude 里直接说：

```text
帮我用 github-project-starter 创建一个网站项目仓库，名字叫 my-brand-site，并推到 GitHub。
```

或者：

```text
帮我创建一个 Codex 技能仓库，名字叫 my-first-skill。
```

## 支持的项目类型

- `basic-repo`：通用项目仓库
- `website-repo`：静态网站项目
- `skill-repo`：Codex / Claude 技能项目
- `automation-repo`：自动化脚本项目

## 手动使用

不通过智能体，也可以直接运行脚本：

```bash
~/.codex/skills/github-project-starter/scripts/create_project.sh \
  --type website-repo \
  --name my-brand-site \
  --output ~/Projects
```

创建后进入目录：

```bash
cd ~/Projects/my-brand-site
git init
git add .
git commit -m "Initial project scaffold"
```

如果你已经登录 GitHub CLI，可以继续：

```bash
gh repo create my-brand-site --public --source . --remote origin --push
```

## 需要提前准备

推荐安装：

- `git`
- `gh`，也就是 GitHub CLI

检查命令：

```bash
git --version
gh auth status
```

如果 `gh auth status` 没登录，先运行：

```bash
gh auth login
```

## 仓库作为模板使用

这个仓库也可以作为 GitHub Template Repository。你可以点 GitHub 页面上的 `Use this template`，复制一份到自己的账号。

## 注意

这个技能只负责创建项目结构、初始化 Git 和辅助推送 GitHub。它不会替你保存账号密码，不会绕过 GitHub 登录，也不会上传本地隐私文件。
