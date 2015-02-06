{%- from "ghost/map.jinja" import ghost with context -%}

{#- Stuffing defaults.get into something that's easier to write. #}
{%- set dget = salt['defaults.get'] -%}

ghost-deps:
  pkg.installed:
    - pkgs:
      - {{ ghost.npm }}
      - {{ ghost.node }}
      - {{ ghost.unzip }}
  npm.installed:
    - pkgs:
      - forever
      - forever-service
    - require:
      - pkg: ghost-deps

{%- for site in dget("blogs") %}
ghost-install-{{ site }}:
  archive.extracted:
    - name: {{ dget("root") }}/sites/{{ site }}
    - source: {{ dget("zip") }}
    - source_hash: {{ dget("zip_hash") }}
    - archive_format: zip
    - keep: true
  cmd.wait:
    - name: npm install --production
    - cwd: {{ dget("root") }}/sites/{{ site }}
    - watch:
      - archive: ghost-install-{{ site }}
{%- endfor %}
