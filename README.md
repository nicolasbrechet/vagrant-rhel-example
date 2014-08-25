#vagrant-rhel-example

Using Vagrant with a Packer-made RHEL box

## Making the box with Packer

Using Bento from Opscode: https://github.com/opscode/bento

## Vagrant plugins I use

* vagrant-triggers
* vagrant-cachier
* vagrant-hostmanager


## Up & running

A `vagrant up` will:

* start the instance
* configure the hostname and update /etc/hosts
* register the instance with Red Hat Network
* update yum
* update all packages

A `vagrant halt`, `suspend` or `destroy` will unregister the instance from RHN before stopping, suspending or destroying the machine

A `vagrant resume` or `reload` will register the instance again with RHN.

