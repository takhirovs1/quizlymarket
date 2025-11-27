.PHONY: help
help: # Script description and usage through `make` or `make help` commands
	$(MAKE) -C ./tools/makefile/ -f deploy.mk help-deploy
	$(MAKE) -C ./tools/makefile/ -f fire.mk help-fire
	$(MAKE) -C ./tools/makefile/ -f git.mk help-git
	$(MAKE) -C ./tools/makefile/ -f pub.mk help-pub

-include tools/makefile/deploy.mk tools/makefile/fire.mk tools/makefile/git.mk tools/makefile/pub.mk
