# GridOS - one world, one OS 
[GridOS](https://github.com/mwoerlein/gridos) |
[Pool](https://github.com/mwoerlein/pool) 

## It's a dream, not a project.
Think of a world, where you can start *any* device you like (or have at hand), log in with *your* personal credentials, and access *your* data, programs, setting, ...

GridOS brings virtualization to the next level:
- Only one global distributed installation of this OS shall exist.
- Hardware connects to the grid during boot.
- Programs run on the grid, not on dedicated hardware.
- Software updates itself on-the-fly after new versions are published.

## Goals
It's a long way to its dreams. At last if you wanna build it from scratch.

The Grid might be build on top of existing OSes as a distributed environment in a dedicated VPN or something like that.

But I wanna go the hard way:
- Be independent from existing systems and launch on a greenfield.
- Throw away existing borders - even programming languages - and create a clean environment for the current millennium.
- Adopt existing standards, if useful, define new ones, if necessary.

To reach these goals, side-projects will be spawned
- [Pool](https://github.com/mwoerlein/pool): an object oriented programming language used in the grid  

## Roadmap
As there are endless topics to discuss, there is endless work to do, and the priority might change everytime.

- understand local environment (x86)
  - [bootstrap x86-(virtual)-machines into own runtime](https://github.com/mwoerlein/gridos/projects/1)
  - [bootstrap completely in Pool](https://github.com/mwoerlein/gridos/projects/2)
  - [multi-threading](https://github.com/mwoerlein/gridos/projects/3)
  - [enhance hardware support](https://github.com/mwoerlein/gridos/projects/4)
  - ...
- design grid environment
  - TBD 

further topics:
- global identifier, global access, data transfer
- users, authentication, authorization, ownership, security, encryption
- versioning, updates, release
- redundancy, fallback, transactions, object/process transfer
- licencing, payment of programs
- many many more

## License
GridOS is distributed under [GNU General Public License v3.0](https://github.com/mwoerlein/gridos/blob/master/LICENSE).
