# Inception

System administration by using Docker containers

## Index

## Linux (Debian & Alpine)

### Debian (VM Set-up)

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

## Container Basics

### What is a Container?

```
"A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another." - docker.com
```

- The quotation above is a definition of a container, in terms of its functionalities, that Docker provides to its customers.
- Below the surface, if a container is viewed from an implementer's angle, it can be explained as an "isolated group of processes on a single host." (Grunert, 2019)
- The next question arises: "how are the processes grouped and is the group isolated?" Following sections will try to answer this question by explaining the basic operations and concepts of Linux (`namespaces` and `chroot`), on which the containerization techniques are based on.

### Linux `namespaces`

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
  ![checking process's namespace](/assets/namespaces.png)
- Normally, a namespace is automatically removed. when the last process in the namespace terminates or leaves the namespace. However, there are number of factors that keeps the namespace alive although there is no member processes. These factors can be checked in [Namespace lifetime section of namespaces man page](https://man7.org/linux/man-pages/man7/namespaces.7.html).

#### Cgroup Namespace

#### IPC Namespace

#### Network Namespace

#### Mount Namespace

#### PID Namespace

#### Time Namespace

#### User Namespace

#### UTS Namespace

### `chroot`

### `cgroup`

- `cgroup` stands for Control Groups.
- [`cgroup` man page](https://man7.org/linux/man-pages/man7/cgroups.7.html)

## Docker

## References

### Debian & Alpine Linux

- [Debian changing language](https://wiki.debian.org/ChangeLanguage)
- [Debian locale setting](https://wiki.debian.org/Locale)
- [Linux man pages online](https://man7.org/linux/man-pages/index.html)

### Docker & Containers

- [Grunert, S. (2019). Demystifying Containers - Part I: Kernel Space. [online] Medium.](https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504)
