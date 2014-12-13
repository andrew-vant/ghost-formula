ghost-deps:
  pkg.installed:
    - pkgs:
      - {{ pkgnames.npm }}
      - {{ pkgnames.node }}
      - {{ pkgnames.unzip }}
  npm.installed:
    - pkgs:
      - forever
    - require:
      - pkg: ghost-deps

{% for site in ghost.blogs %}
ghost-install-{{ site }}:
  archive.extracted:
    - name: /srv/ghost/sites/{{ site }}
    - source: {{ ghost.zip }}
    - source_hash: {{ ghost.hash }}
    - archive_format: zip
    - keep: true
{% endfor %}

