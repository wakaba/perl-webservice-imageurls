# <https://github.com/wakaba/generate-pm-package>
GENPMPACK = generate-pm-package

all:

dist:
	$(GENPMPACK) config/dist/webservice-imageurls.pi packages/
