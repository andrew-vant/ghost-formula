=====
ghost
=====

Install and configure the Ghost blogging platform.

This formula is intended to easily set up multiple Ghost blogs on the same
server. It works by taking the downloadable Zip package from the `Ghost
download page <https://ghost.org/download/>`_ and using it to install
multiple instances of Ghost. 

Each instance listens on a separate port. It is probably desirable to run nginx
or apache in front of them. pillar.example shows one way to make this
formula play nice with `nginx-formula <https://github.com/saltstack-formulas/nginx-formula>`_.

The only required pillar entry is a list of blogs. The formula won't break
if they aren't provided, but it won't do anything either. 

The formula defaults can be found in ghost/defaults.yaml.

Available States
================

.. contents::
    :local:

``ghost``
---------

Installs and configures Ghost and sets up services for it. 

``ghost.install``
-----------------

Installs Ghost without configuring it. The installation zip file is downloaded
from the `Ghost web site <https://ghost.org/download/>`_ by default, but the
source can be redirected by a pillar entry.

This installs one Ghost instance for each entry in pillar\:ghost\:blogs.

``ghost.service``
-----------------

Installs upstart or sysvinit services for each Ghost instance.

``ghost.configure``
-------------------

Configures each blog's config.js file. 


