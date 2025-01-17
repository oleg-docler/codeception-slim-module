help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  tests                   to perform tests."
	@echo "  coverage                to perform tests with code coverage."
	@echo "  static                  to run phpstan and php-cs-fixer check."
	@echo "  static-phpstan          to run phpstan."
	@echo "  static-psalm            to run psalm."
	@echo "  static-cs-check         to run php-cs-fixer."
	@echo "  static-cs-fix           to run php-cs-fixer, writing the changes."

tests:
	vendor/bin/codecept build
	vendor/bin/codecept run

coverage:
	vendor/bin/codecept build
	vendor/bin/codecept run --coverage --coverage-xml --coverage-html

static: static-phpstan static-psalm static-cs-check

static-phpstan:
	composer install
	composer bin phpstan install
	vendor/bin/phpstan analyze $(PHPSTAN_PARAMS)

static-psalm:
	composer install
	composer bin psalm install
	vendor/bin/psalm.phar $(PSALM_PARAMS)

static-cs-fix:
	composer install
	composer bin php-cs-fixer install
	vendor/bin/php-cs-fixer fix --diff $(CS_PARAMS)

static-cs-check:
	$(MAKE) static-cs-fix CS_PARAMS="--dry-run"
