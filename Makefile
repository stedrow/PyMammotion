# Python source directory
SRC_DIR := pymammotion

# Test directory
TEST_DIR := tests

# Files to exclude from formatting
EXCLUDE := tests/fixtures.py

# Run Black formatter
format:
	poetry run black $(SRC_DIR) $(TEST_DIR) --exclude $(EXCLUDE)

# Check formatting with Black (doesn't modify files)
check-format:
	poetry run black --check $(SRC_DIR) $(TEST_DIR) --exclude $(EXCLUDE)

# Run Ruff linter
lint:
	poetry run ruff check $(SRC_DIR) $(TEST_DIR)

# Run MyPy type checker
type-check:
	poetry run mypy $(SRC_DIR)

# Run Pylint
pylint:
	poetry run pylint $(SRC_DIR)

# Run tests
test:
	poetry run python -m pytest $(TEST_DIR)

# Run all checks
check: check-format lint type-check pylint

# Generate Protocol Buffer files
proto:
	poetry run protoc -I=. --python_out=. --python_betterproto_out=. ./$(SRC_DIR)/proto/*.proto
	poetry run protoc -I=. --python_out=. ./$(SRC_DIR)/proto/*.proto
	poetry run protoc -I=. --python_out=. --pyi_out=. ./$(SRC_DIR)/proto/*.proto

# Install dependencies
install:
	poetry install

# Update dependencies
update:
	poetry update

# Clean up bytecode files
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

.PHONY: format check-format lint type-check pylint test check proto install update clean