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

patch1:
ifdef HAVE_DOCKER
	docker build -t cctbx-xfel:p1 -f docker/Dockerfile.patch1 .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel:p1 -f docker/Dockerfile.patch1 --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif

patch2:
ifdef HAVE_DOCKER
	docker build -t cctbx-xfel:p2 -f docker/Dockerfile.patch2 .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel:p2 -f docker/Dockerfile.patch2 --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif

patch3:
ifdef HAVE_DOCKER
	docker build -t cctbx-xfel:p3 -f docker/Dockerfile.patch3 .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel:p3 -f docker/Dockerfile.patch3 --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif

patch4:
ifdef HAVE_DOCKER
	docker build -t cctbx-xfel:p4 -f docker/Dockerfile.patch4 .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel:p4 -f docker/Dockerfile.patch4 --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif

patch5:
ifdef HAVE_DOCKER
	docker build -t cctbx-xfel:p5 -f docker/Dockerfile.patch5 .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel:p5 -f docker/Dockerfile.patch5 --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif

patch6:
ifdef HAVE_DOCKER
	docker build -t cctbx-xfel:p6 -f docker/Dockerfile.patch6 .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel:p6 -f docker/Dockerfile.patch6 --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif

patch7:
ifdef HAVE_DOCKER
	docker build -t cctbx-xfel:p7 -f docker/Dockerfile.patch7 .
else
ifdef HAVE_PODMAN
	podman build -t cctbx-xfel:p7 -f docker/Dockerfile.patch7 --format docker .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif
