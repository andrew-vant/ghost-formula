{% from "ghost/map.jinja" import apache with context %}

ghost-frontend-apache:
  pkg.installed:
    - name: {{ apache.pkg }}
  apache_module.enable:
    - name: proxy_http
  service.running:
    - name: {{ apache.srv }}

{%- for blog in salt['pillar.get']("ghost:blogs", [] %}
ghost-frontend-{{ blog }}:
  file.managed:
    - name: {{ apache.conf }}/sites-available/{{ blog }}.conf
    - source: salt://ghost/files/apache-site.jinja
    - mode: 644
    - defaults:
        port: 80
    - context:
        blog: {{ blog }}
        ghostport: {{ loop.index + 2368 }}
    - watch_in:
      - service: ghost-frontend

ghost-enable-{{ site }}:
  file.symlink:
    - name: {{ apache.conf }}/sites-enabled/{{ site }}.conf
    - target: {{ apache.conf }}/sites-available/{{ site }}.conf
{%- endfor %}

