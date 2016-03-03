#!/bin/bash

mv Vagrantfile Vagrantfile.win
mv Vagrantfile.mac Vagrantfile

if [ ! -d logs ] ; then
  mkdir logs
fi

vagrant plugin install vagrant-hostmanager 
vagrant plugin install vagrant-omnibus

vagrant up default 
