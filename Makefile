ENV_FOR_DYNACONF ?= development

clean: clean-build clean-pyc clean-test

clean-build:
	@rm -fr build/
	@rm -fr dist/

clean-pyc:
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -fr {} +
	@find . -name '*.egg-info' -exec rm -rf {} +

clean-test:
	@rm -f .coverage
	@rm -fr htmlcov/
	@rm -fr .pytest_cache/

check_system_deps:
	@hash python 2> /dev/null || echo >&2 'Python is required'
	@hash poetry 2> /dev/null || echo >&2 'Poetry is required'
	@hash pyenv 2> /dev/null || echo >&2 'Pyenv is highly recommended'

init: install
	poetry env info

install: check_system_deps
	@poetry install

run: clean
	@ENV_FOR_DYNACONF=$(ENV_FOR_DYNACONF) poetry run python ./application/main.py

test: clean
	@poetry run pytest

.PHONY: init install run test
