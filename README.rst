=====
ghost
=====

Install and configure the Ghost blogging platform.

This formula is intended to easily set up one or multiple Ghost blogs on the 
same server. Each instance listens on a separate port.

It is probably desirable to run nginx or apache in front of them. 
pillar.example shows one way to make this formula play nice with 
`nginx-formula <https://github.com/saltstack-formulas/nginx-formula>`_.

The only required pillar entry is a list of blogs. The formula won't break
if they aren't provided, but it won't do anything useful either. 

The formula defaults can be found in ghost/defaults.yaml.

Available States
================

.. contents::
    :local:

``ghost``
---------

Applies all Ghost states.

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

Todo
====

The most significant missing feature is a state for managing Ghost themes. 
It's problematic in two different ways. First, themes don't have a standard
configuration file format, so a pillared template won't work. Second, themes
can't be configured through the user interface as far as I can tell, so
it can't just be left up to the end user, who may not have the shell access
that is currently necessary.  This may have to wait for better upstream
support.

The second most significant missing feature is support for non-debian OS
families, particularly the RHEL/CentOS family. This should be fairly easy.

The formula also needs to handle upgrades properly. Right now I don't think it does. 

