
clean: clean-build clean-pyc clean-test

clean-build:
	@rm -fr build/
	@rm -fr dist/

clean-pyc:
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -fr {} +
	@find . -name '*.egg-info' -exec rm -f {} +

clean-test:
	@rm -f .coverage
	@rm -fr htmlcov/

init: install_dev install

install:
	pipenv install

install_dev:
	pipenv install --dev

run: clean
	@pipenv run python ./application/main.py

test: clean
	pipenv run pytest

test-cov: clean
	pipenv run pytest --cov=application

.PHONY: init install install_dev test
