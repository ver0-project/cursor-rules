# Cursor Rules: Opinionated Preset for Enhanced Workflows

[![Cursor Version](https://img.shields.io/badge/Cursor-v0.47.8-blue)](https://cursor.sh)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/ver0/cursor-rules/pulls)

A carefully crafted collection of rules that optimize your Cursor AI experience. These rules enforce consistent practices, improve AI assistance quality, and streamline common development workflows.

> **Note:** This is an opinionated preset designed to enhance productivity. Feel free to adapt these rules to your personal preferences! ✨

## 🚀 Quick Start

The `apply-rules.sh` script allows you to download rules directly to your project without cloning the entire repository:

```bash
# Download the script
curl -o apply-rules.sh https://raw.githubusercontent.com/ver0-project/cursor-rules/master/apply-rules.sh && chmod +x apply-rules.sh

# Basic usage - download rules to target directory
./apply-rules.sh /path/to/your/project

# Overwrite existing rules
./apply-rules.sh --ow /path/to/your/project
```

Parameters:

- `--ow`: Optional flag to overwrite existing rules
- `<target_directory>`: Required path where rules will be downloaded

After running the script:

1. Reindex the project, so new rules are applied.
2. Enjoy enhanced AI interactions!

## ✨ Features

- **Structured Organization** - Logically organized rules by domain and purpose
- **Improved AI Responses** - Guidelines for more helpful and consistent AI assistance
- **Development Workflows** - Optimized patterns for git, directory management, and more
- **Language-Specific Rules** - Specialized rules for Markdown and other languages
- **Customizable Framework** - Easily extend with your own rules

## 📁 Rules Organization

Rules are organized in specific directories:

| Directory   | Purpose                                         |
| ----------- | ----------------------------------------------- |
| `core/`     | Core rules for Cursor behavior and rules system |
| `local/`    | Personal rules (gitignored)                     |
| `global/`   | Rules applied to every context                  |
| `overview/` | Project overviews and descriptions              |
| `testing/`  | Testing approach guidelines                     |
| `tools/`    | OS-specific utilities and common tools          |
| `lng/`      | Language-specific rules in subdirectories       |

### Available Rules

#### Core Rules

- `coding-principles.mdc` - Guidelines for writing high-quality, maintainable code
- `cursor-rules.mdc` - Guidelines for creating and updating Cursor rules
- `emoji-usage.mdc` - Best practices for using emojis in AI responses

#### Tools Rules

- `commit-message.mdc` - Guidelines for semantic git commit messages
- `git.mdc` - Settings for proper git output display without pager
- `unix-directory-listing.mdc` - Standards for directory listings on Unix/Linux/macOS
- `windows-directory-listing.mdc` - Standards for directory listings on Windows

#### Language-Specific Rules

- `lng/markdown/formatting.mdc` - Guidelines for consistent Markdown formatting
- `lng/markdown/readme-formatting.mdc` - Best practices for README.md files

## ⚙️ Configuration

### Editor Settings

For optimal experience with `.mdc` files and to avoid flaky behavior of Cursor's MDC editor:

```json
{
  "files.associations": {
    "*.mdc": "markdown"
  },
  "workbench.editorAssociations": {
    "*.mdc": "default"
  }
}
```

This configuration sets the default text editor for `.mdc` files and enables markdown syntax highlighting.

### `.cursorindexignore` Setup

During active development of your rules:

```
# Add to .cursorindexignore
.cursor/rules/*
```

This prevents rules from being embedded in the index while they're changing rapidly. After finalizing your rules, remove this entry and manually rebuild the index for better rule accessibility.

## 🔧 Working with Rules

### Creating New Rules

1. Just ask agent to create new rule, outlining desired properties and application plain.
2. Review and work on the rule with agent.
3. Save and commit.

### Rule Synchronization

When creating or deleting rules (excluding rules in the `overview/` directory):

1. Update the `RULES` array in the `apply-rules.sh` script to keep it synchronized
2. Follow the existing categorization structure and alphabetical order
3. Commit both the rule changes and script updates together

See the [rules-synchronization.mdc](.cursor/rules/overview/rules-synchronization.mdc) file for more details.

### After Rules Update

For Cursor to apply updated or newly created rules:

1. Restart the context so rules can be re-indexed, or
2. Explicitly specify the updated rule files for Cursor to reindex them

## 🧠 Advanced Usage

### Self-Questioning Reasoning Framework

The `.ai/meta-prompt-example.md` file provides a sample "User rule" that implements a self-questioning reasoning framework. This approach enhances the AI's problem-solving capabilities through structured internal dialogue.

> **Important:** This approach is optimized for Cursor and not recommended for other AI platforms that may bill differently based on output token usage. The self-questioning framework generates substantial output tokens which could result in higher costs on platforms with different billing models.

## 🤝 Contributing

Contributions are welcome! If you have ideas for new rules or improvements to existing ones, please:

1. Fork the repository
2. Create your feature branch
3. Submit a pull request
