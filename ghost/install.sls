{%- from "ghost/map.jinja" import pkgnames with context -%}
{%- set get = salt['defaults.get'] -%}

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

{%- for site in get("blogs") %}
ghost-install-{{ site }}:
  archive.extracted:
    - name: {{ get("root") }}/sites/{{ site }}
    - source: {{ get("zip") }}
    - source_hash: {{ get("zip_hash") }}
    - archive_format: zip
    - keep: true
  cmd.wait:
    - name: npm install --production
    - cwd: {{ get("root") }}/sites/{{ site }}
    - watch:
      - archive: ghost-install-{{ site }}
{%- endfor %}
