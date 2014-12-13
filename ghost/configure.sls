include:
  - ghost.install

{# Note that each instance of Ghost requires a port. This port doesn't need to
   be externally accessible. The formula uses ports starting from 2369. 2368 
   is Ghost's default port. If an rpm/deb package is released, I figure it 
   will probably use that port. Starting from the next port up will keep 
   this formula from interfering with the packaged installation until the 
   formula can be updated to use the package. #}

{%- for blog in ghost.blogs %}

ghost-{{ blog }}:
  file.managed:
    - name: {{ ghost.root }}/sites/{{ site }}/config.js
    - source: salt://ghost/files/config.js.jinja
    - mode: 644
    - context:
        blog: {{ blog }}
        port: {{ loop.index + 2368 }} {#- Note that loop.index starts at 1. #}
        conf: {{ conf }}
{% endfor %}

