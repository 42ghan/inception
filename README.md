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

## Docker

## References

### Debian & Alpine Linux

- [Debian changing language](https://wiki.debian.org/ChangeLanguage)
- [Debian locale setting](https://wiki.debian.org/Locale)

### Docker & Containers

- [Demystifying Containers](https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504)

```

```
