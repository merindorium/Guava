.DEFAULT: help

help: ## Show this help message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

release_tooling: ## Install dev tooling
	brew update > /dev/null
	brew bundle --file ./script/Brewfile.release

xcodeproj: ## Generates Xcode project
	swift package generate-xcodeproj

carthage_build: ## Builds iOS and Mac frameworks with Carthage 
	carthage build --no-skip-current --platform iOS,Mac

carthage_archive: ## Archives frameworks with Carthage
	carthage archive

release: ## Releases iOS and Mac frameworks
release: release_tooling xcodeproj carthage_build carthage_archive
