HAVE_DOCKER := $(shell which docker 2>/dev/null)
HAVE_PODMAN := $(shell which podman 2>/dev/null)

image:
ifdef HAVE_DOCKER	
	docker build -t cctbx-xfel -f docker/Dockerfile .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel -f docker/Dockerfile --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif
