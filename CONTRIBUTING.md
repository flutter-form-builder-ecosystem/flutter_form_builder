# Contributing

Thank you for considering and taking the time to contribute to this project!

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with collaborators of this repository before making a change.

Please note we have a [code of conduct](https://github.com/danvick/flutter_form_builder/blob/master/CODE_OF_CONDUCT.md), please follow it in all your interactions with the project.

## How to Contribute

First setup repository to contribute

If you already setup repository, take a look at the issues and take a stab at them. We'll try to make the issue as verbose as possible, so it is easy for you to help. When you're done, create a [Pull Request](https://github.com/danvick/flutter_form_builder/compare).

You don't need to code to help us. If you have a suggestion of a feature, see a bug or a thing that should be improved, [open an issue](https://github.com/danvick/flutter_form_builder/issues/new/choose) on Github.


## Setup development environment

### Copy repository

 * Fork `https://github.com/danvick/flutter_form_builder/` into your own GitHub account. If you already have a fork and moving to a new computer, make sure you update you fork.
 * If you haven't configured your machine with an SSH key that's known to github, then
   follow [GitHub's directions](https://help.github.com/articles/generating-ssh-keys/)
   to generate an SSH key.
 * Clone your forked repo on your local development machine: `git clone git@github.com:<your_name_here>/flutter_form_builder.git`
 * Change into directory of package to be develop directory. Example: `cd packages/flutter_form_builder`
 * Add an upstream to the original repo, so that fetch from the master repository and not your clone: `git remote add upstream git@github.com:danvick/flutter_form_builder.git`

### Running the example project

 * Change into the example directory: `cd example`
 * Run the App: `flutter run`

## Implement code

### Enhancement (new feature or request)

- Implement code
- Implement unit tests
- Add example
- Test example in all package compatible platforms
- Are a new component, validator or behaviour; add to readme package

### Bug

- Fix bug
- Update and/or add unit tests to verify fixed behaviour
- Verify if bug is fixed all package compatible platforms

## Make a pull request

We really appreciate contributions via GitHub pull requests. To contribute take the following steps:

 * Make sure you are up to date with the latest code on the master: 
   * `git fetch upstream`
   * `git checkout upstream/master -b <name_of_your_branch>`
 * Apply your changes
 * Verify your local changes and fix potential warnings/errors:
   * Check formatting: `flutter format .`
   * Run static analyses: `flutter analyze`
   * Run tests: `flutter test`
 * Commit your changes: `git commit -am "<your informative commit message>"`
 * Push changes to your fork: `git push origin <name_of_your_branch>`
 * Open a pull request and fill template

 Please make sure you solved all warnings and errors reported by the static code analyses and that you fill in the full pull request template. Failing to do so will result in us asking you to fix it.
