include:
  - .install

{%- set dget = salt['defaults.get'] %}

{%- for site in dget('blogs') %}
ghost-service-{{ site }}:
  cmd.run:
    - name: forever-service install ghost-{{ site }} -s index.js -e "NODE_ENV=production"
    - cwd: {{ dget("root") }}/sites/{{ site }}
    - unless: test -e /etc/init/ghost-{{ site }}.conf -o -e /etc/init.d/ghost-{{ site }}
    - require:
      - npm: ghost-deps
      - cmd: ghost-install-{{ site }}
  service.running:
    - name: ghost-{{ site }}
    - enable: True
    - require:
      - cmd: ghost-service-{{ site }}
{%- endfor %}
