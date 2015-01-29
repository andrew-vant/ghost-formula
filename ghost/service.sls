include:
  - .install

{%- set dget = salt['defaults.get'] %}
{%- for site in dget('blogs') %}
ghost-service-{{ site }}:
  cmd.run:
    - name: forever-service install ghost-{{ site }} -s index.js -e "NODE_ENV=production"
    - cwd: {{ dget("root") }}/sites/{{ site }}
    - creates: /etc/init/ghost-{{ site }}.conf #FIXME: Fails for non-upstart!
    - require:
      - npm: ghost-deps
  service.running:
    - name: ghost-{{ site }}
    - enable: True
    - require:
      - cmd: ghost-service-{{ site }}
{%- endfor %}
