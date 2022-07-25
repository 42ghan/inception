# Inception

System administration by using Docker containers

# Index

# Linux (Debian & Alpine)

## Debian (VM Set-up)

- How to support secondary language (Korean)

  - Execute the following command, and choose the preferred language

  ```
  dpkg-reconfigure locales
  ```

  - `export LANG=ko_KR.UTF_8`
  - Install the language's font. (Install `nanum` font)

  ```
  apt-get install fonts-nanum fonts-nanum-coding fonts-nanum-extra
  ```

  - reboot

- [How to install Docker Engine on a linux machine](https://docs.docker.com/engine/install/ubuntu/) (follow the instruction on the link)
- How to install C Language man pages

  ```
  apt-get install manpages-dev
  ```

# Container Basics

## What is a Container?

```
"A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another." - docker.com
```

- The quotation above is a definition of a container, in terms of its functionalities, that Docker provides to its customers.
- Below the surface, if a container is viewed from an implementer's angle, it can be explained as an "isolated group of processes on a single host." (Grunert, 2019)
- The next question arises: "how are the processes grouped and is the group isolated?" Following sections will try to answer this question by explaining the basic operations and concepts of Linux (`namespaces` and `chroot`), on which the containerization techniques are based on.

## Linux `namespaces`

- A **namespace** wraps a global system resouce in an abstraction so that the processes within the namespace may see themselves as if they have their own isolated instance of the global resource.
- Only the member processes of the namespace can see any changes to the global resource.
- Following are the namespace types, resouces in the parentheses after each type indicate resouces that are isolated by each type, avaliable on Linux:
  - [`Cgroup`](#cgroup-namespace)(cgroup root directory)
  - [`IPC`](#ipc-namespace)(system V IPC, POSIX message queues)
  - [`Network`](#network-namespace)(etwork devices, stacks, ports, etc.)
  - [`Mount`](#mount-namespace)(mount points)
  - [`PID`](#pid-namespace)(process IDs)
  - [`Time`](#time-namespace)(boot and monotonic clocks)
  - [`User`](#user-namespace)(user and group IDs)
  - [`UTS`](#uts-namespace)(hostname and NIS domain name)
- Changes to the namespace of a process can be made by following system call APIs:
  - [`clone`](https://man7.org/linux/man-pages/man2/clone.2.html)
  - [`setns`](https://man7.org/linux/man-pages/man2/setns.2.html)
  - [`unshare`](https://man7.org/linux/man-pages/man2/unshare.2.html)
  - [`ioctl`](https://man7.org/linux/man-pages/man2/ioctl.2.html)
- Namespaces of each process can be checked inside the `/proc/[pid]/ns/` directory.
<figure>
<p align="center">
  <img src="assets/namespaces.png" alt="checking process's namespace" style="width: 80%; height: 80%; ">
</p>
</figure>

- Normally, a namespace is automatically removed, when the last process in the namespace terminates or leaves the namespace. However, there are number of factors that keeps the namespace alive although there is no member processes. These factors can be checked in [Namespace lifetime section of namespaces man page](https://man7.org/linux/man-pages/man7/namespaces.7.html).

### Cgroup Namespace

#### What is a `cgroup`?

- `cgroup` stands for a control group. It is "a collection of processes that are bound to a set of limits or parameters defined via the cgroup filesystem." ([`cgroup` man page](https://man7.org/linux/man-pages/man7/cgroups.7.html))

- `cgroupfs` pseudo-filesystem provides the kernel's cgroup interface. The default path where the root cgroup directory is mounted on is `/sys/fs/cgroup`.

<figure>
<p align="center">
  <img src="assets/cgroupfs.png" alt="cgroupfs ls" style="width: 80%; height: 80%; ">
</p>
</figure>

- Just by `mkdir` sub-directory inside the root directory or one of sub-directories, a new cgroup can be created. Inside the new directory, cgroup configuration files are automatically created.

<figure>
<p align="center">
  <img src="assets/new_cgroup.png" alt="new cgroup example" style="width: 80%; height: 80%; ">
</p>
</figure>

- The `cgroup.procs` file lists PIDs of the processes inside the cgroup. By appending PID of a process to the target cgroup's `cgroup.procs` file, the process can be moved to the target cgroup.

<figure>
<p align="center">
  <img src="assets/moving_cgroup.png" alt="moving cgroup example" style="width: 80%; height: 80%; ">
</p>
</figure>

- The "set of limits or parameters" on resources are defined in the files inside cgroup directories. See examples below.

<figure>
<p align="center">
  <img src="assets/cgroup_limits.png" alt="cgroup limits example" style="width: 60%; height: 60%; ">
</p>
</figure>

- A list of available "subsystems" or "controllers", "kernel components that modifies the behaviour of the processes in a cgroup", are visible in the read-only file `cgroup.controllers`. The list matches that of the parent's `cgroup.subtree_control`.

<figure>
<p align="center">
  <img src="assets/cgroup_controllers.png" alt="cgroup hierarchy" style="width: 100%; height: 100%; ">
</p>
</figure>

- Cgroup controller types are (cgroup v2):

  - `cpu` - CPU usage
  - `cpuset` - CPUs and NUMA nodes binding
  - `freezer` - suspend and restore all processes in a cgroup
  - `hugetlb` - use of huge pages
  - `io` - IO control
  - `memory` - reporting and limiting of process memory, kernel memory, and swap used by cgroups
  - `perf_event` - performance monitoring
  - `pids` - number of processes
  - `rdma` - RDMA/IB-specific resources
  - There are more types in cgroup v1, for further details check [`cgroups` man page](https://man7.org/linux/man-pages/man7/cgroups.7.html).

- The tree structure of the root cgroup directory represents hierarchical cgroup structure of processes, which can be checked by `systemd-cgls` command. Sub-cgroup's limitations cannot exceed its parent's limitations.

<figure>
<p align="center">
  <img src="assets/cgroup_hierarchy.png" alt="cgroup hierarchy" style="width: 100%; height: 100%; ">
</p>
</figure>

- There are cgroup v1 and cgroup v2. There are a few differences between these two versions. Two major differences are explained in details below. Both versions are still supported and different controllers can be simultaneously mounted under the v1 and v2 hierarchies. For further details check [`cgroups` man page](https://man7.org/linux/man-pages/man7/cgroups.7.html).

  - In cgroups v1, different controllers can be mounted against different hierarchies. Such implementation was designed to allow flexibility for application design, however it only added complexity. Therefore, in cgroups v2, all controllers are mounted against a unified hierarchy (all mounted against the root cgroups).
  - cgroups v2 imposes "no internal processes" rule, which means processes can be assigned to only the root and leaf cgroups. In other words, a non-root cgroup cannot have member processes, and distribute resources into child cgroups at the same time. This makes relationship between the parent and the child explicit and intuitive.

- Thread level resource control is also possible via cgroups. This can be done by switching `cgroup.type`. For further details check [CGROUPS VERSION 2 THREAD MODE section of `cgroups` man page](https://man7.org/linux/man-pages/man7/cgroups.7.html).

### IPC Namespace

### Network Namespace

### Mount Namespace

### PID Namespace

### Time Namespace

### User Namespace

### UTS Namespace

## `chroot`

# Docker

# References

## Debian & Alpine Linux

- [Debian changing language](https://wiki.debian.org/ChangeLanguage)
- [Debian locale setting](https://wiki.debian.org/Locale)
- [Linux man pages online](https://man7.org/linux/man-pages/index.html)

## Docker & Containers

- [Grunert, S. (2019). Demystifying Containers - Part I: Kernel Space. [online] Medium.](https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504)
