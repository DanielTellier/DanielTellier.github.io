# Simple Personal Website Setup

## Objective
Show how to create simple website through GitHub on Ubuntu.

## Table of Contents
- [Project Structure](#project-structure)
- [Setup](#setup)

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

## Setup
- Install the following:
```shell
sudo apt install ruby-full
gem install bundler
```
- Create new public repository on Github the repo name should be:
  - \<User Name\>.github.io
- Clone the above repo to directory of your choice:
```shell
git clone git@github.com:<User Name>/<User Name>.github.io.git
```
- Setup ssh key to clone above repo.
- Run the following to make a Jekyll site:
```shell
jekyll new --skip-bundle
```
- Comment out the following line in the Gemfile: `# gem "jekyll"`
- Change the following line in the Gemfile `# gem "github-pages"` to:
```ruby
gem "github-pags", "~> GITHUB-PAGES-VERSION", group: :jekyll_plugins
```
- Here is my current Gemfile:
```ruby
source "https://rubygems.org"
gem "jekyll-theme-primer", "~> 0.6.0"
gem "github-pages", "~> 227", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data
# gem and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
```
- Now run the following:
```shell
bundle install
```
- The above command will make the following \_config.yml.
- Edit the \_config.yml with the following:
```yaml
name: <Your Name>
title: null
author: null
baseurl: ""
url: "https://<User Name>.github.io"
theme: jekyll-theme-primer
plugins:
  - jekyll-feed
```
- You can change the default folder structure to the example shown above.
- Now commit and push changes to the above remote repo.
- You should now be able to view your site using the url specified in the \
\_config.yml
- You can now create an index.md file and link the markdown posts you make \
in the posts folder.

