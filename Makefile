
clean: clean-build clean-pyc clean-test

clean-build:
	@rm -fr build/
	@rm -fr dist/

clean-pyc:
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	@rm -f .coverage
	@rm -fr htmlcov/

init: install_dev install

install:
	pipenv install

install_dev:
	pipenv install --dev

run:
	@pipenv run python ./application/main.py

test:
	pytest tests

.PHONY: init install install_dev test
