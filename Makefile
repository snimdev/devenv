# Snim devenv: clones and manages the Snim repos side by side.
# Repos live in their own git repositories and are gitignored here.

REPOS = specs snim homebrew-tap setup-msvc
ORG   = git@github.com:snimdev

# Optional, untracked: private repos (PRIVATE) and settings such as SNIM_ARTISAN.
-include local.mk

.PHONY: clone pull status roadmap

clone:
	@for r in $(REPOS) $(PRIVATE); do \
		if [ -d $$r/.git ]; then \
			echo "$$r: already cloned"; \
		elif echo " $(PRIVATE) " | grep -q " $$r "; then \
			git clone -q $(ORG)/$$r.git $$r 2>/dev/null || echo "$$r: private, skipped"; \
		else \
			git clone $(ORG)/$$r.git $$r; \
		fi; \
	done

pull:
	@for r in $(REPOS) $(PRIVATE); do \
		if [ -d $$r/.git ]; then \
			echo "== $$r"; \
			git -C $$r pull --rebase; \
		fi; \
	done

status:
	@for r in $(REPOS) $(PRIVATE); do \
		if [ -d $$r/.git ]; then \
			echo "== $$r"; \
			git -C $$r status -sb; \
		fi; \
	done

# Re-runs the website's specs sync, which normally runs on every push to specs (DRY=1 previews it).
roadmap:
	@test -n "$(SNIM_ARTISAN)" || { echo "Set SNIM_ARTISAN in local.mk"; exit 1; }
	@$(SNIM_ARTISAN) specs:sync $(if $(DRY),--dry-run,)
