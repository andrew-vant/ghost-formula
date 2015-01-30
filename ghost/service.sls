include:
  - .install

{%- set dget = salt['defaults.get'] %}

{%- for site in dget('blogs') %}

{#- forever-service might install either an upstart service or a sysvinit
    one. We don't *really* care which, but we need to send the appropriate
    location to the -creates option below. This is a kludge but I can't think of
    a better method. If I knew exactly how forever-service determines which
    to create, this would be cleaner. #}

{%- set upstart_file = "/etc/init/ghost-{}.conf".format(site) %}
{%- set sysvinit_file = "/etc/init.d/ghost-" + site %}

{%- if salt['file.file_exists'](upstart_file) %}
{%- set creates_file = upstart_file %}
{%- else %}
{%- set creates_file = sysvinit_file %}
{%- endif %}

ghost-service-{{ site }}:
  cmd.run:
    - name: forever-service install ghost-{{ site }} -s index.js -e "NODE_ENV=production"
    - cwd: {{ dget("root") }}/sites/{{ site }}
    - creates: {{ creates_file }}
    - require:
      - npm: ghost-deps
  service.running:
    - name: ghost-{{ site }}
    - enable: True
    - require:
      - cmd: ghost-service-{{ site }}
{%- endfor %}
