
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

init: install
	poetry env info

install:
	@poetry install

run: clean
	@poetry run python ./application/main.py

test: clean
	@poetry run pytest

.PHONY: init install run test
