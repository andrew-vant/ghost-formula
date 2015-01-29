include:
  - .install

{%- set dget = salt['defaults.get'] %}

ghost-upstart-template:
  file.patch:
    - name: /usr/local/lib/node_modules/forever-service/templates/upstart/upstart.template
    - source: salt://ghost/files/upstart.diff
    - hash: md5=21707777a397dd175a096e3ec8c14463
    - require:
      - npm: ghost-deps

{%- for site in dget('blogs') %}
ghost-service-{{ site }}:
  cmd.run:
    - name: forever-service install ghost-{{ site }} -s index.js -e "NODE_ENV=production"
    - cwd: {{ dget("root") }}/sites/{{ site }}
    - creates: /etc/init/ghost-{{ site }}.conf #FIXME: Fails for non-upstart!
    - require:
      - file: ghost-upstart-template
      - npm: ghost-deps
  service.running:
    - name: ghost-{{ site }}
    - enable: True
    - require:
      - cmd: ghost-service-{{ site }}
{%- endfor %}
