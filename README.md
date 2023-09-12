# VAK - Virtually Assisted Kitchen

VAK is an AI recipe and meal generator web application built in Ruby on Rails, and using an OpenAI API, Sidekiq, Redis, and StimulusJS.

## Installation

To run the application you need to run the following commands in the terminal.

```bash
bundle install
rails db:migrate
rails server
```
and you need to have the Sidekiq and Redis running in open tabs.

```bash
sidekiq
```
```bash
sudo service redis-server start
```

## Usage

Giving the ingredients that you have, and choosing the cuisine and diet, generates a recipe. To generate meal plans, you give the days and diet type.

## Collaborators

- [Linda Wilson](https://github.com/Linda-wilson)
- [Simone Wurz](https://github.com/swurz)
- [Noah Rabe](https://github.com/NoahRabe)
- [Deyvison Ghessi](https://github.com/deyvisong)
- [Arthur Rohr Cardoso](https://github.com/ArthurRohr)

- Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

## License

[MIT](https://choosealicense.com/licenses/mit/)
