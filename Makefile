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

# Publishes each spec to the snim.dev roadmap and its issue (DRY=1 shows the diff only).
roadmap:
	@python3 specs/roadmap.py $(if $(DRY),--dry-run,)
