Buildbook for RHEL6
===================

xexecscript set for [vmbuilder](https://github.com/hansode/vmbuilder)

Requirements
------------

+ RHEL/CentOS/Scientific

execscript
----------

Run SCRIPT after distro installation finishes.
Script will be called with the guest's chroot as first argument, so you can use `chroot $1 <cmd>` to run code in the virtual machine.

License
-------

[Beerware](http://en.wikipedia.org/wiki/Beerware) license.

If we meet some day, and you think this stuff is worth it, you can buy me a beer in return.
