include:
  - ghost.install

{#- convenience #}
{%- set dget = salt['defaults.get'] %}
{%- set pget = salt['pillar.get'] %}

{#- Note that each instance of Ghost requires a port. This port doesn't need to
    be externally accessible. The formula uses ports starting from 2370. 2368 
    is Ghost's default port. If an rpm/deb package is released, I figure it 
    will probably use that port. Starting from the next port up should keep 
    this formula from interfering with the packaged installation until the 
    formula can be updated to use the package. #}

{%- for blog in dget("blogs") %}
ghost-{{ blog }}:
  file.managed:
    - name: {{ dget("root") }}/sites/{{ blog }}/config.js
    - source: salt://ghost/files/config.js.jinja
    - template: jinja
    - mode: 644
    - context:
        blog: {{ blog }}
        port: {{ loop.index + 2369 }} {#- Note that loop.index starts at 1. #}
{% endfor %}
