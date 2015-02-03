include:
  - ghost.install
  - ghost.service

{#- convenience #}
{%- set dget = salt['defaults.get'] %}
{%- set pget = salt['pillar.get'] %}

{%- for blog in dget("blogs") %}
ghost-{{ blog }}:
  file.managed:
    - name: {{ dget("root") }}/sites/{{ blog }}/config.js
    - source: salt://ghost/files/config.js.jinja
    - template: jinja
    - mode: 644
    - context:
        blog: {{ blog }}
        listen_address: {{ dget("listen_address") }}
        port: {{ loop.index0 + dget("starting_port") }}
    - require:
        - archive: ghost-install-{{ blog }}
    - watch_in:
        - service: ghost-service-{{ blog }}
{% endfor %}
