# Simple Personal Website Setup

## Objective
Show how to create simple website through GitHub.

## Table of Contents
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Config Setup](#config-setup)

## Project Structure
```shell
<User Name>.github.io
├── 404.html
├── _config.yml
├── docs
│   └── list of docs here
├── Gemfile
├── Gemfile.lock
├── images
│   └── list of images here
├── index.md
├── posts
│   └── list of posts as markdown files here
├── README.md
└── _site
    └── list of necessary site files here
```

## Prerequisites
- Install the following:
```shell```
- <a href="https://github.com/DanielTellier" target="_blank">GitHub</a>

## Config Setup
Place below in \_config.yml:
```shell
name: <Your Name>
title: null
author: null
baseurl: ""
url: "https://<User Name>.github.io"
theme: jekyll-theme-primer
plugins:
  - jekyll-feed
```

## Steps
- Create repo as:
\<User Name\>.github.io
- Create similar folder structure as above.
- Don't forget the \_config.yml file.
- The index.md file will be your default home page.
- For creating your markdown files you can use the following:
    - [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)
- Start learning and filling in the blogs folder with new posts!
